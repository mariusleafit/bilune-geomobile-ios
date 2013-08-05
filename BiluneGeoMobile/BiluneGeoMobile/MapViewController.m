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

@interface MapViewController ()
@property (weak) AppDelegate *appDelegate;
@property (strong, nonatomic) OverviewLayer *overviewLayer;
@property (nonatomic) AGSTiledMapServiceLayer *sateliteBasemap;
@property (nonatomic) AGSTiledMapServiceLayer *roadBasemap;
@end

@implementation MapViewController


@synthesize mapView, sateliteBasemap, roadBasemap;

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
