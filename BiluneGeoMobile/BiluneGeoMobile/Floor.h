//
//  Floor.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Building;

@interface Floor : NSObject {
    
}

@property(strong, nonatomic) NSNumber *floorID;
@property(strong, nonatomic) NSString *floorName;
@property(strong, nonatomic) NSString *floorCode;
@property(strong, nonatomic) Building *parentBuilding;

+(Floor *)createWidthData:(NSDictionary *)data andParentBuilding:(Building *)parentBuilding;

-(NSURL *)getParentBuildingURL;
-(NSString *)getStrFloorID;
-(NSURL *)getFloorURL;

-(void)setVisibility:(BOOL)visibility;
-(BOOL)isVisible;

-(void)hide;
-(void)show;

/*
-(AGSSpatialReference *)getSpatialReference;
-(AGSEnvelope *)getExtent;
-(Room *)getClickedRoomWidthX:(NSNumber *)x andY:(NSNumber *)y;
 
 //comparator???
*/
@end
