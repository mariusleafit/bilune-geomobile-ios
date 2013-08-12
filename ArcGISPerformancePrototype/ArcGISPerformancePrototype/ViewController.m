//
//  ViewController.m
//  ArcGISPerformancePrototype
//
//  Created by Marius Gächter on 12.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.mapView addMapLayer:[[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"] ]];
    
    //add buildings
    /*[self.mapView addMapLayer:[[AGSFeatureLayer alloc]  initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/01_snicolas4_web/MapServer/2"] mode:AGSFeatureLayerModeSnapshot] ];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/02_boine20/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/06_fbgLac5a_web/MapServer/4"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/07_dupeyrou1/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/08_dupeyrou6/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/09_fbghopital27/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/10_fbghopital41/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/13_beauxarts28/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/14_pmars26_web/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/15_fbghopital106/MapServer/3"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/16_fbghopital61/MapServer/2"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/17_fbghopital77/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/19_breguet1_web/MapServer/2"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/23_mal10/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/24_pam7/MapServer/2"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/25_pam11/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/26_lagassiz1_web/MapServer/3"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/29_bellevaux51_web/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/30_unimail_web/MapServer/3"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/31_latenium/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/31_latenium/MapServer/1"] mode:AGSFeatureLayerModeSnapshot ]];
    [self.mapView addMapLayer:[[AGSFeatureLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/33_vau22/MapServer/0"] mode:AGSFeatureLayerModeSnapshot ]];*/
    
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc]  initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/01_snicolas4_web/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/02_boine20/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/06_fbgLac5a_web/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/07_dupeyrou1/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/08_dupeyrou6/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/09_fbghopital27/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/10_fbghopital41/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/13_beauxarts28/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/14_pmars26_web/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/15_fbghopital106/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/16_fbghopital61/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/17_fbghopital77/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/19_breguet1_web/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/23_mal10/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/24_pam7/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/25_pam11/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/26_lagassiz1_web/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/29_bellevaux51_web/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/30_unimail_web/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/31_latenium/MapServer"] ]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/31_latenium/MapServer"]]];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/33_vau22/MapServer"]  ]];
    
    [self.mapView zoomToEnvelope:[[AGSEnvelope alloc] initWithXmin:771387.8263244121 ymin:5939725.698962646 xmax:773689.5858964956 ymax:5943264.654304724 spatialReference:[[AGSSpatialReference alloc] initWithWKID:102100]] animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
