//
//  Floor.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>

@class Building;

@interface Floor : NSObject {
    NSNumber* visibility;
}

@property(strong, nonatomic) NSNumber *floorID;
@property(strong, nonatomic) NSString *floorName;
@property(strong, nonatomic) NSString *floorCode;
@property(strong, nonatomic) Building *parentBuilding;
@property (nonatomic, strong) AGSEnvelope *extent;
@property BOOL defaultVisibility;
@property(strong, nonatomic) AGSFeatureLayer *featureLayer;

+(Floor *)createWidthData:(NSDictionary *)data andParentBuilding:(Building *)parentBuilding;

-(NSURL *)getParentBuildingURL;
-(NSString *)getStrFloorID;
-(NSURL *)getFloorURL;

-(void)setVisibility:(BOOL)pVisibility;
-(BOOL)isVisible;

-(void)hide;
-(void)show;


-(AGSSpatialReference *)getSpatialReference;
//-(Room *)getClickedRoomWidthX:(NSNumber *)x andY:(NSNumber *)y;
 
 //comparator???

@end
