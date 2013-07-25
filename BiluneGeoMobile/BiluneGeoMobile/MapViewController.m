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

@interface MapViewController ()
@property (weak) AppDelegate *appDelegate;
@end

@implementation MapViewController

#pragma mark attributes
AGSTiledMapServiceLayer *sateliteBasemap;
AGSTiledMapServiceLayer *roadBasemap;

@synthesize mapView;

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
    
    //set initial Extent
    [self.mapView zoomToEnvelope:[Constants INITIAL_EXTENT] animated:NO];
    
    //show buildings
    for (Building *building in [self.appDelegate.buildingstack getBuildings]) {
        for(Floor *floor in [building getVisibleFloors]) {
            [self.mapView addMapLayer:floor.featureLayer];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
