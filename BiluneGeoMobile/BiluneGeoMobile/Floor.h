//
//  Floor.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Building.h"

@interface Floor : NSObject {
    
}
+(Floor *)createWidthData:(NSDictionary *)data andParentBuilding:(Building *)parentBuilding;

-(NSURL *)getParentBuildingURL;
-(Building *)getParentBuilding;
-(NSString *)getFloorID;
-(NSInteger *)getIntFloorID;
-(NSString *)getFloorCode;
-(NSString *)getFloorName;
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
