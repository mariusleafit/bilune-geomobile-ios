//
//  OverviewLayer.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 26.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuildingStack.h"
#import <ArcGIS/ArcGIS.h>

@interface OverviewLayer : NSObject

@property(nonatomic, weak) AGSGraphicsLayer *graphicsLayer;
@property(nonatomic, weak) BuildingStack *buildingStack;

-(id)initWidthGraphicsLayer:(AGSGraphicsLayer *)pGraphicsLayer andBuildingStack:(BuildingStack *)pBuildingStack;

-(void)setVisibility:(BOOL)pVisibility;
-(Building *)getBuildingFromGraphic:(AGSGraphic *)graphic;
@end
