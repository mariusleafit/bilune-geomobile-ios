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
#import "MainMenuViewController.h"
#import "InfoViewController.h"
#import "LegendViewController.h"

@interface MapViewController () {
    RoomFromObjectIDQuery *getClickedRoomQuery;
    Room *clickedRoom;
    Room *roomToZoomTo;
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
    //prepare navigationBar
    [self setTitle:@"Carte"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
     initWithTitle:@"Home"
     style:UIBarButtonItemStyleBordered
     target:self
     action:@selector(returnToHome)];
    
    
    //**prepare map**
    
    //set basemap
    sateliteBasemap =  [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:[Constants SATELITE_MAP_URL]]];
    roadBasemap = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:[Constants ROAD_MAP_URL]]];
    [self.mapView addMapLayer:sateliteBasemap withName:@"sateliteBasemap"];
    [self.mapView addMapLayer:roadBasemap withName:@"roadBasemap"];
    [sateliteBasemap setVisible:NO];
    
    //add ovserver for maprotation
    [self.mapView addObserver:self forKeyPath:@"rotationAngle" options:(NSKeyValueObservingOptionNew) context:NULL];
    
    
    
    //set delegates
    self.mapView.touchDelegate = self;
    self.mapView.layerDelegate = self;
    
    
}

- (void)viewDidUnload {
    //Stop the GPS, undo the map rotation (if any)
    if(self.mapView.locationDisplay.dataSourceStarted){
        [self.mapView.locationDisplay stopDataSource];
        self.mapView.rotationAngle = 0;
    }
    self.mapView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRoomToZoomTo:(Room *)room {
    roomToZoomTo = room;
}

#pragma mark memory management
/*-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.mapView removeFromSuperview];
    [super dismissViewControllerAnimated:flag completion:completion];
}*/

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
    
    //init roomMarkingLayer
    self.roomMarkingLayer = [[AGSGraphicsLayer alloc] initWithSpatialReference:[Constants BILUNE_SPATIALREFERENCE]];
    
    
    //if roomToZoomTo was set
    if(roomToZoomTo) {
        //project polygon
        AGSPoint *projectedPolygon = (AGSPoint *)[[AGSGeometryEngine defaultGeometryEngine] projectGeometry:roomToZoomTo.polygon toSpatialReference:[Constants BASEMAP_SPATIALREFERENCE]];

        //set initial Extent
        [self.mapView zoomToEnvelope:projectedPolygon.envelope animated:NO];
        
        //change visible floors
        [roomToZoomTo.parentBuilding changeVisibleFloorsWithFloorCode:roomToZoomTo.parentFloor.floorCode];
        //add building to mapView
        [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[roomToZoomTo.parentFloor getFloorURL] mode:AGSFeatureLayerModeSnapshot] withName:[ [roomToZoomTo.parentFloor getFloorURL] absoluteString]];
        
                
        //mark room
        AGSSimpleFillSymbol *roomMarkerSymbol = [[AGSSimpleFillSymbol alloc] initWithColor:[UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:0.5] outlineColor:nil];
        AGSGraphic *roomMarkerGraphic = [AGSGraphic graphicWithGeometry:projectedPolygon symbol:roomMarkerSymbol attributes:nil infoTemplateDelegate:nil];
        [self.roomMarkingLayer removeAllGraphics];
        [self.roomMarkingLayer addGraphic:roomMarkerGraphic];
        
        //add pin
        AGSPictureMarkerSymbol *pinSymbol = [[AGSPictureMarkerSymbol alloc] initWithImage:[UIImage imageNamed:@"pin32.png"]];
        AGSGraphic *pinGraphic = [AGSGraphic graphicWithGeometry:projectedPolygon.envelope.center symbol:pinSymbol attributes:nil infoTemplateDelegate:nil];
        [self.roomMarkingLayer addGraphic:pinGraphic];
        
        //show callout
        self.mapView.callout.title = roomToZoomTo.name;
        self.mapView.callout.detail = @"Cliquez pour plus de détails..";
        self.mapView.callout.delegate = self;
        [self.mapView.callout showCalloutAt:projectedPolygon.envelope.center pixelOffset:CGPointMake(0.0f, 0.0f) animated:NO];
    }
    
    //init OverviewLayer
    AGSGraphicsLayer *overviewGraphicsLayer = [[AGSGraphicsLayer alloc] initWithSpatialReference:[Constants BASEMAP_SPATIALREFERENCE]];
    [self.mapView addMapLayer:overviewGraphicsLayer withName:@"overviewLayer"];
    self.overviewLayer = [[OverviewLayer alloc] initWithGraphicsLayer:overviewGraphicsLayer andBuildingStack:self.appDelegate.buildingstack];
    
    //init buildings
    [self.appDelegate.buildingstack resetFloorVisibility];
    for (Building *building in [self.appDelegate.buildingstack getBuildings]) {
        if(building != roomToZoomTo.parentBuilding) {
            for(Floor *floor in [building getVisibleFloorsSortedAsc:false]) {
                [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[floor getFloorURL] mode:AGSFeatureLayerModeSnapshot] withName:[ [floor getFloorURL] absoluteString]];
            }
        }
    }
    
    if(roomToZoomTo) {
        [self setVisibilityOfBuildings:YES];
        [self.overviewLayer setVisibility:NO];
    } else {
        [self setVisibilityOfBuildings:NO];
        [self.overviewLayer setVisibility:YES];
    }
    
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
    

    //if error with resolution (sometimes mapView.resolution isn't "uptodate" --> hardcode (occures when mapView hasnt finished loading)
    if(scaleBarValueInMeters < 10) {
        if(roomToZoomTo) {
            scaleBarValueInMeters = 24.0;
        } else {
            scaleBarValueInMeters = 617.0;
        }
        [self.mapScale updateBar:(scaleBarValueInMeters  / 80.0)];
    } else {
        //update scaleBar
        [self.mapScale updateBar:AGSUnitsToUnits(self.mapView.resolution, [self.roadBasemap mapServiceInfo].units, AGSUnitsMeters)];
    }
    
    //verify if overview and buildings are correctly hidden/visible
    if(scaleBarValueInMeters >=[Constants ZOOMSTATE_TRANSITION_HEIGHT]) {/*overview*/
        if(!self.overviewLayer.isVisible) {
            [self setVisibilityOfBuildings:NO];
            [self.overviewLayer setVisibility:YES];
        }
    } else {/*building*/
        if(self.overviewLayer.isVisible) {
            [self setVisibilityOfBuildings:YES];
            [self.overviewLayer setVisibility:NO];
        }
    }
}

//if overviewlayer was visible but now the Buildings
-(void) zoomStateTransitionFromOverviewToBuildings {
    //hide Overview
    [self.overviewLayer setVisibility:NO];
    //show Buildings
    [self setVisibilityOfBuildings:YES];
    
    //show text for Buildings
    self.mapInfoText.text = @"1 click = info de la salle\nClick long = changement d'étage";
}

//if buildings were visible and now overviewlayer
-(void) zoomStateTransitionFromBuildingsToOverview{
    //hide Buildings
    [self setVisibilityOfBuildings:NO];
    
    //showOverview
    [self.overviewLayer setVisibility:YES];
    
    //show text for overview
    self.mapInfoText.text = @"Localisation des bâtiments\nde l'Université de Neuchâtel";
    
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

#pragma mark Map rotation Management
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //if rotationAngle changed
    if([keyPath isEqual:@"rotationAngle"]){
        [self.compass rotate:self.mapView.rotationAngle];
    }
}

#pragma mark ChangeEtageManagement
-(void) updateVisibleFloorsFromBuilding:(Building *)building {
    //delete every Floor of Building
    for(Floor *floor in [building getFloors]) {
        [self.mapView removeMapLayerWithName:[[floor getFloorURL] absoluteString]];
    }
    
    //show visible Floors
    for(Floor *floor in [building getVisibleFloorsSortedAsc:YES]) {
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
            roomToZoomTo = nil;
            
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
                AGSSimpleFillSymbol *roomMarkerSymbol = [[AGSSimpleFillSymbol alloc] initWithColor:[UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:0.5] outlineColor:nil];
                AGSGraphic *roomMarkerGraphic = [AGSGraphic graphicWithGeometry:roomPolygon symbol:roomMarkerSymbol attributes:nil infoTemplateDelegate:nil];
                [self.roomMarkingLayer removeAllGraphics];
                [self.roomMarkingLayer addGraphic:roomMarkerGraphic];

                //display callout (gets updated when request is finished
                self.mapView.callout.title = @"...";
                self.mapView.callout.detail = @"...";
                self.mapView.callout.delegate = nil;
                [self.mapView.callout showCalloutAt:mappoint pixelOffset:CGPointMake(0.0f, 0.0f) animated:YES];
            
                getClickedRoomQuery = [[RoomFromObjectIDQuery alloc] initWithUrl:[NSURL URLWithString:floorUrlFull] andName:@"RoomFromObjectIDQuery" andDelegate:self andObjectID:objectID andBuildingStack:self.appDelegate.buildingstack];
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
        Building *clickedBuilding = [self.appDelegate.buildingstack getBuildingWithPoint:mappoint andSpatialReference:[Constants BASEMAP_SPATIALREFERENCE]];
        
        //show changeFloor
        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
        ChangeFloorViewController *viewController = [[ChangeFloorViewController alloc] initWithNibName:@"ChangeFloor" bundle:nil];
        [viewController setBuilding:clickedBuilding];
        [viewController setMapViewController:self];
        //[self presentViewController:viewController animated:YES completion:nil];
        
        [self.appDelegate.navigationController pushViewController:viewController animated:YES];
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
    getClickedRoomQuery = nil;
    mapView.callout.hidden = true;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Impossible de charger les données, veuillez vérifier l'état du réseau." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark AGSCalloutDelegate
-(void)didClickAccessoryButtonForCallout:(AGSCallout *)callout {
    if(clickedRoom) {
        //display RoominfoView
        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
        RoomInfoViewController *viewController = [[RoomInfoViewController alloc] initWithNibName:@"RoomInfo" bundle:nil];
        [viewController setRoom:clickedRoom];
        //[self presentViewController:viewController animated:YES completion:nil];
        [self.appDelegate.navigationController pushViewController:viewController animated:YES];
    } else if(roomToZoomTo) {
        //display RoominfoView
        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
        RoomInfoViewController *viewController = [[RoomInfoViewController alloc] initWithNibName:@"RoomInfo" bundle:nil];
        [viewController setRoom:roomToZoomTo];
        //[self presentViewController:viewController animated:YES completion:nil];
         [self.appDelegate.navigationController pushViewController:viewController animated:YES];

    }
}

#pragma mark DeviceOrientation
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark IBAction

- (IBAction)showLegend:(id)sender {
    //showLegend
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Legend"];
    [self presentViewController:viewController animated:YES completion:nil];*/
    [self.appDelegate.navigationController pushViewController:[[LegendViewController alloc]  initWithNibName:@"Legend" bundle:nil] animated:YES];
}

- (IBAction)toggleGPS:(id)sender {
    if(![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Service Localisation désactivé"
                                                        message:@"Pour réactiver, utilisez Paramètres."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        if(self.mapView.locationDisplay.dataSourceStarted){
            [self.mapView.locationDisplay stopDataSource];
            self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeOff;
            self.gpsButton.tintColor = [UIColor whiteColor];
        } else {
            [self.mapView.locationDisplay startDataSource];
            self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
            self.gpsButton.tintColor = [UIColor greenColor];
        }
    }
}
- (IBAction)showInfo:(id)sender {
    //show Info
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"InfoUNINE"];
    [self presentViewController:viewController animated:YES completion:nil];*/

    [self.appDelegate.navigationController pushViewController:[[InfoViewController alloc] initWithNibName:@"Info" bundle:nil] animated:YES];
   
}
- (IBAction)toggleSatelite:(id)sender {
    if(self.sateliteBasemap.isVisible) {
        [self.sateliteBasemap setVisible:NO];
        [self.roadBasemap setVisible:YES];
        self.sateliteButton.tintColor = [UIColor whiteColor];
    } else {
        [self.sateliteBasemap setVisible:YES];
        [self.roadBasemap setVisible:NO];
         self.sateliteButton.tintColor = [UIColor greenColor];
    }
}

-(void)returnToHome {
    for(UIViewController *viewController in self.appDelegate.navigationController.viewControllers) {
        if([viewController isKindOfClass:[MainMenuViewController class]]) {
            [self.appDelegate.navigationController popToViewController:viewController animated:YES];
        }
    }
}
@end
