//
//  OverviewLayer.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 26.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "OverviewLayer.h"
#import "Building.h"
#import "Constants.h"


@implementation OverviewLayer

@synthesize buildingStack, graphicsLayer;

-(id)initWidthGraphicsLayer:(AGSGraphicsLayer *)pGraphicsLayer andBuildingStack:(BuildingStack *)pBuildingStack {
    self = [super init];
    if(self) {
        self.graphicsLayer = pGraphicsLayer;
        self.buildingStack = pBuildingStack;
        
        
        /*
		 * create graphic for each building and add the buildingUrl to its parameters
		 */
		for(Building *building in [buildingStack getBuildings]) {
            //create point
            AGSPoint *centerOfBuilding = [[AGSPoint alloc] initWithX:building.extent.center.x y:building.extent.center.y spatialReference:[Constants BILUNE_SPATIALREFERENCE]];
            AGSGeometryEngine *geometryEngine = [[AGSGeometryEngine alloc] init];
            centerOfBuilding = (AGSPoint *)[geometryEngine projectGeometry:centerOfBuilding toSpatialReference:[Constants BASEMAP_SPATIALREFERENCE]];
            
            //create marker
            AGSSimpleMarkerSymbol *buildingMarker = [[AGSSimpleMarkerSymbol alloc] initWithColor:[[UIColor alloc] initWithRed:(255/255.0) green:(104/255.0) blue:(110/255.0) alpha:1 ]];
            [buildingMarker setStyle:AGSSimpleMarkerSymbolStyleSquare];
            [buildingMarker setOutline:[[AGSSimpleLineSymbol alloc] initWithColor:[[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1] width:1 ]];
            
            //create attributes
            NSDictionary *buildingAttributes = [[NSDictionary alloc]
                                                initWithObjects:[[NSArray alloc] initWithObjects:building.shortURL, nil]
                                                forKeys:[[NSArray alloc] initWithObjects:@"buildingUrl", nil]];
            
            //create graphic
            AGSGraphic *buildingGraphic = [[AGSGraphic alloc] initWithGeometry:centerOfBuilding symbol:buildingMarker attributes:buildingAttributes infoTemplateDelegate:nil];
            
            //add graphic
            [self.graphicsLayer addGraphic:buildingGraphic];
		}
    }
    return self;
}

-(void)setVisibility:(BOOL)pVisibility {
    [self.graphicsLayer setVisible:pVisibility];
}


///get Building from BuildingStack using the BuildingUrl saved in the graphic
-(Building *)getBuildingFromGraphic:(AGSGraphic *)graphic {
    Building *returnBuilding = nil;
    
    if([graphic valueForKey:@"buildingUrl"]) {
        NSString *shortURL = (NSString *)((NSArray *)[graphic valueForKey:@"buildingUrl"])[0];
        returnBuilding = [self.buildingStack getBuildingWidthShortURL:shortURL];
    }
    
    return returnBuilding;
}

@end
