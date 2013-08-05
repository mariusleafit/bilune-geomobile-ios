//
//  Building.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
#import "Floor.h"
#import "Room.h"
@interface Building : NSObject {
    
    
}

@property (nonatomic, strong) NSURL *fullURL;
@property (nonatomic, strong) NSString *shortURL;
@property (nonatomic, strong) NSString *mapName;
@property (nonatomic, strong) NSString *address;


@property (nonatomic, strong) AGSEnvelope *extent;
@property (nonatomic, strong) AGSEnvelope *maxExtent;
@property (nonatomic, strong) AGSSpatialReference *spatialReference;


+(Building *)createWidthData:(NSDictionary *)data;

-(NSString *)getBatCode;
-(NSArray *)getFloorsSortedAsc:(BOOL)asc;
-(NSArray *)getFloors;
-(NSArray *)getVisibleFloorsSortedAsc:(BOOL)asc;
-(NSArray *)getVisibleFloorIDsSortedAsc:(BOOL)asc;
-(Floor *)getFloorWidthFloorCode:(NSString *)floorCode;
-(Floor *)getFloorWidthFloorID:(NSNumber *)floorID;
-(void)changeVisibleFloorsWidthFloorCode:(NSString *)floorCode;
-(void)changeVisibleFloorsWidthFloorCodes:(NSArray *)floorCodes;

//set the Visibility of the Floors to the defaultVisibility
-(void)resetFloorVisibility;

-(UIImage *)getImage;
-(BOOL)isClickedWidthPoint:(AGSPoint *)point andSpatialReference:(AGSSpatialReference *)spatialReference;
/*-(Room *)getClickedRoomWidthX:(NSNumber*)x andY:(NSNumber *)y;*/



@end
