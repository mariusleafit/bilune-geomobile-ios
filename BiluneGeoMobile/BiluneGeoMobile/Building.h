//
//  Building.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Floor.h"
@interface Building : NSObject {
    
    
}

@property (nonatomic, strong) NSURL *fullURL;
@property (nonatomic, strong) NSString *shortURL;
@property (nonatomic, strong) NSString *mapName;
@property (nonatomic, strong) NSString *address;

/*
 @property (nonatomic, strong, readonly) AGSEnvelope *extent;
 @property (nonatomic, strong, readonly) AGSEnvelope *maxExtent;
 @property (nonatomic, strong, readonly) AGSSpatialReference *spatialReference;
*/

+(Building *)createWidthData:(NSDictionary *)data;

-(NSString *)getBatCode;
-(NSArray *)getFloors;
-(NSArray *)getVisibleFloors;
-(NSArray *)getVisibleFloorIDs;
-(Floor *)getFloorWidthFloorCode:(NSString *)floorCode;
-(Floor *)getFloorWidthFloorID:(NSNumber *)floorID;
-(void)changeVisibleFloorsWidthFloorCode:(NSString *)floorCode;
-(void)changeVisibleFloorsWidthFloorCodes:(NSArray *)floorCodes;

-(void)hide;
-(void)show;


/*
-GetImage
-(BOOL)isClickedWidthPoint:(AGSPoint *)point andSpatialReference:(AGSSpatialReference *)spatialReference;
-(Room *)getClickedRoomWidthX:(NSNumber*)x andY:(NSNumber *)y;
*/


@end
