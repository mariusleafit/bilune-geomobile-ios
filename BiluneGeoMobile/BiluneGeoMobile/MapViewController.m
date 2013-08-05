//
//  MapViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "MapViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "OverviewLayer.h"
#import "ChangeFloorViewController.h"
#import "RoomHelper.h"
#import "RoomFromObjectIDQuery.h"
#import "RoomInfoViewController.h"

@interface MapViewController () {
    RoomFromObjectIDQuery *getClickedRoomQuery;
    Room *clickedRoom;
}
@property (weak) AppDelegate *appDelegate;
@property (strong, nonatomic) OverviewLayer *overviewLayer;
@property (nonatomic) AGSTiledMapServiceLayer *sateliteBasemap;
@property (nonatomic) AGSTiledMapServiceLayer *roadBasemap;
@property (strong, nonatomic) AGSGraphicsLayer *roomMarkingLayer;

@end

@implementation MapViewController


@synthesize mapView, sateliteBasemap, roadBasemap, roomMarkingLayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.appDelegate = GetAppDelegate();
    
    //**prepare map**
    
    //set basemap
    sateliteBasemap =  [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:[Constants SATELITE_MAP_URL]]];
    roadBasemap = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:[Constants ROAD_MAP_URL]]];
    [self.mapView addMapLayer:sateliteBasemap withName:@"sateliteBasemap"];
    [self.mapView addMapLayer:roadBasemap withName:@"roadBasemap"];
    [sateliteBasemap setVisible:NO];
    
    //set delegates
    self.mapView.touchDelegate = self;
    self.mapView.layerDelegate = self;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MapView preparation
-(void)mapViewDidLoad:(AGSMapView *)mapView {
    
    //set zoom listener
    // register for pan notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToPan:)
                                                 name:AGSMapViewDidEndPanningNotification object:nil];
    
    // register for zoom notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToZoom:)
                                                 name:AGSMapViewDidEndZoomingNotification object:nil];
    
    //set initial Extent
    [self.mapView zoomToEnvelope:[Constants INITIAL_EXTENT] animated:NO];
    
    //init OverviewLayer
    AGSGraphicsLayer *overviewGraphicsLayer = [[AGSGraphicsLayer alloc] initWithSpatialReference:[Constants BASEMAP_SPATIALREFERENCE]];
    [self.mapView addMapLayer:overviewGraphicsLayer withName:@"overviewLayer"];
    self.overviewLayer = [[OverviewLayer alloc] initWidthGraphicsLayer:overviewGraphicsLayer andBuildingStack:self.appDelegate.buildingstack];
    
    //init buildings
    [self.appDelegate.buildingstack resetFloorVisibility];
    for (Building *building in [self.appDelegate.buildingstack getBuildings]) {
        for(Floor *floor in [building getVisibleFloorsSortedAsc:false]) {
            [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[floor getFloorURL] mode:AGSFeatureLayerModeSnapshot] withName:[ [floor getFloorURL] absoluteString]];
        }
    }
    
    [self setVisibilityOfBuildings:NO];
    [self.overviewLayer setVisibility:YES];
    
    //init roomMarkingLayer
    self.roomMarkingLayer = [[AGSGraphicsLayer alloc] initWithSpatialReference:[Constants BILUNE_SPATIALREFERENCE]];
    [self.mapView addMapLayer:self.roomMarkingLayer withName:@"roomMarkingLayer"];
    
    self.mapView.allowRotationByPinching = true;
}

#pragma mark ZoomManagement
-(void) respondToPan: (NSNotification *)notification {
    NSLog(@"ausschnitt geändert");
}

-(void) respondToZoom: (NSNotification *)notification {
    //manage zoomStateTransisitons (eg. from Overviewlayer to Buildings)
    int oldScaleBarValueInMeters = scaleBarValueInMeters;
    scaleBarValueInMeters = AGSUnitsToUnits(self.mapView.resolution, [self.roadBasemap mapServiceInfo].units, AGSUnitsMeters) * 80;
    if(oldScaleBarValueInMeters < [Constants ZOOMSTATE_TRANSITION_HEIGHT] && scaleBarValueInMeters >= [Constants ZOOMSTATE_TRANSITION_HEIGHT])/*from Buildings to Overview*/ {
        [self zoomStateTransitionFromBuildingsToOverview];
    } else if(oldScaleBarValueInMeters >= [Constants ZOOMSTATE_TRANSITION_HEIGHT] && scaleBarValueInMeters < [Constants ZOOMSTATE_TRANSITION_HEIGHT])/*from Overview to Buildings*/ {
        [self zoomStateTransitionFromOverviewToBuildings];
    }
    
    //update scaleBar
    
    [self.mapScale updateBar:AGSUnitsToUnits(self.mapView.resolution, [self.roadBasemap mapServiceInfo].units, AGSUnitsMeters)];
}

//if overviewlayer was visible but now the Buildings
-(void) zoomStateTransitionFromOverviewToBuildings {
    //hide Overview
    [self.overviewLayer setVisibility:NO];
    //show Buildings
    [self setVisibilityOfBuildings:YES];
}

//if buildings were visible and now overviewlayer
-(void) zoomStateTransitionFromBuildingsToOverview{
    //hide Buildings
    [self setVisibilityOfBuildings:NO];
    
    //showOverview
    [self.overviewLayer setVisibility:YES];
}

-(void) setVisibilityOfBuildings:(BOOL)visibility{
    for(AGSLayer *layer in self.mapView.mapLayers) {
        if([layer class] == [AGSFeatureLayer class]) {
            if(visibility) {
                [layer setOpacity:1.0];
            } else {
                [layer setOpacity:0.0];
            }
        }
    }
}

#pragma mark ChangeEtageManagement
-(void) updateVisibleFloorsFromBuilding:(Building *)building {
    //delete every Floor of Building
    for(Floor *floor in [building getFloors]) {
        [self.mapView removeMapLayerWithName:[[floor getFloorURL] absoluteString]];
    }
    
    //show visible Floors
    for(Floor *floor in [building getVisibleFloorsSortedAsc:false]) {
        [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[floor getFloorURL] mode:AGSFeatureLayerModeSnapshot] withName:[ [floor getFloorURL] absoluteString]];
    }
}

#pragma mark AGSMapViewTouchDelegate
-(void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint graphics:(NSDictionary *)graphics {
    //switch zoom level
    if(scaleBarValueInMeters > [Constants ZOOMSTATE_TRANSITION_HEIGHT]) {
        //get clicked Building from OverviewLayer and Zoom to it
        AGSGraphic *clickedGraphic = [graphics valueForKey:@"overviewLayer"];
        if(clickedGraphic) {
            Building *clickedBuilding = [self.overviewLayer getBuildingFromGraphic:clickedGraphic];
            if(clickedBuilding) {
                [self.mapView zoomToEnvelope:clickedBuilding.extent animated:YES];
            }
        }
    } else if(scaleBarValueInMeters <= [Constants ZOOMSTATE_TRANSITION_HEIGHT]) {
        //to make sure that there is only one request at the same time
        if(getClickedRoomQuery == nil) {
            //reset clicked room
            clickedRoom = nil;
            
            __block int objectID;
            __block NSString *floorUrlFull = nil;
            __block AGSPolygon *roomPolygon = nil;
            
            //if there are multiple clicked Graphics --> get the roomGraphic
            [graphics enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                AGSGraphic *tmpGraphic = (AGSGraphic *)obj[0];
                NSString *tmpKey = (NSString *)key;
                
                //is room?
                if([tmpGraphic attributeAsStringForKey:@"OBJECTID"]) {
                    objectID = [tmpGraphic attributeAsUnsignedIntForKey:@"OBJECTID" exists:nil];
                    floorUrlFull = tmpKey;
                    roomPolygon = (AGSPolygon *)tmpGraphic.geometry;
                    *stop = YES;
                }
            }];
            //query room
            if(floorUrlFull) {
                //mark Room on map
                AGSSimpleFillSymbol *roomMarkerSymbol = [[AGSSimpleFillSymbol alloc] initWithColor:[UIColor colorWithRed:170 green:170 blue:170 alpha:0.5] outlineColor:nil];
                AGSGraphic *roomMarkerGraphic = [AGSGraphic graphicWithGeometry:roomPolygon symbol:roomMarkerSymbol attributes:nil infoTemplateDelegate:nil];
                [self.roomMarkingLayer removeAllGraphics];
                [self.roomMarkingLayer addGraphic:roomMarkerGraphic];
                //add pin
                /*AGSPictureMarkerSymbol *pinSymbol = [[AGSPictureMarkerSymbol alloc] initWithImage:[UIImage imageNamed:@"pin32.png"]];
                AGSGraphic *pinGraphic = [AGSGraphic graphicWithGeometry:mappoint symbol:pinSymbol attributes:nil infoTemplateDelegate:nil];
                [self.roomMarkingLayer addGraphic:pinGraphic];*/

                //display callout (gets updated when request is finished
                self.mapView.callout.title = @"...";
                self.mapView.callout.detail = @"...";
                self.mapView.callout.delegate = nil;
                [self.mapView.callout showCalloutAt:mappoint pixelOffset:CGPointMake(0.0f, 0.0f) animated:YES];
            
                getClickedRoomQuery = [[RoomFromObjectIDQuery alloc] initWidthUrl:[NSURL URLWithString:floorUrlFull] andName:@"RoomFromObjectIDQuery" andDelegate:self andObjectID:objectID andBuildingStack:self.appDelegate.buildingstack];
                [getClickedRoomQuery execute];
            } else {
                [self.roomMarkingLayer removeAllGraphics];
                self.mapView.callout.hidden = true;
            }
        }
    }
}

-(void)mapView:(AGSMapView *)mapView didTapAndHoldAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint graphics:(NSDictionary *)graphics {
    //if Buildings are visible
    if(scaleBarValueInMeters <= [Constants ZOOMSTATE_TRANSITION_HEIGHT]) {
        Building *clickedBuilding = [self.appDelegate.buildingstack getBuildingWidthPoint:mappoint andSpatialReference:[Constants BASEMAP_SPATIALREFERENCE]];
        
        //show changeFloor
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
        ChangeFloorViewController *viewController = (ChangeFloorViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ChangeFloor"];
        [viewController setBuilding:clickedBuilding];
        [viewController setMapViewController:self];
        [self presentViewController:viewController animated:YES completion:nil];
        
        
        
        //[self presentModalViewController:settingsMenuController animated:YES];
    }
}

#pragma mark RoomQueryDelegate
-(void)roomQueryRoomFound:(Room *)room andQueryName:(NSString *)queryName{
    
    if([queryName isEqualToString:@"RoomFromObjectIDQuery"]) {
        if(room) {
            //display callout
            mapView.callout.title = room.name;
            mapView.callout.detail = @"Cliquez pour plus de détails..";
            mapView.callout.delegate = self;
            getClickedRoomQuery = nil;
            
            clickedRoom = room;
        } else {
            mapView.callout.hidden = true;
        }
    }
}

-(void)roomQueryErrorOccured:(NSString *)queryName {
    NSLog(@"room error occured");
    getClickedRoomQuery = nil;
    mapView.callout.hidden = true;
}

#pragma mark AGSCalloutDelegate
-(void)didClickAccessoryButtonForCallout:(AGSCallout *)callout {
    if(clickedRoom) {
        //display RoominfoView
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
        RoomInfoViewController *viewController = (RoomInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RoomInfo"];
        [viewController setRoom:clickedRoom];
        [self presentViewController:viewController animated:YES completion:nil];

    }
}

#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return YES;
}

#pragma mark IBAction
- (IBAction)returnToMenu:(id)sender {
    //show SearchOccupants
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:viewController animated:YES completion:nil];*/
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
