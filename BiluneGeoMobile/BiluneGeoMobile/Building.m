
//
//  Building.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Building.h"
#import "Floor.h"

@interface Building()

@property(strong) NSArray *floors;

@end

@implementation Building

@synthesize fullURL;
@synthesize shortURL;
@synthesize mapName;
@synthesize address;
@synthesize floors;

/*
 @synthesize extent;
 @synthesize maxExtent;
 @synthesize spatialReference;
*/

+(Building *) createWidthData:(NSDictionary *)data {
    Building *returnBuilding = [[Building alloc]init];
    
    //init
    
    return returnBuilding;
}

-(NSString *)getBatCode {
    NSString *returnBatCode;
    if(!self.mapName) {
        returnBatCode = [self.mapName substringToIndex:1];
    }
    return returnBatCode;
}

-(NSArray *)getFloors {
    return self.floors;
}

-(NSArray *)getVisibleFloors {
    //capacity can be increased (by adding more objects) is just an indicator
    NSMutableArray *returnFloors = [NSMutableArray arrayWithCapacity:30];
    if(self.floors && self.floors.count > 0) {
        for ( Floor *floor in self.floors) {
            if(floor.isVisible) {
                [returnFloors addObject:floor];
            }
        }
    }
    return [NSArray arrayWithArray:returnFloors];
}

///returns String array
-(NSArray *)getVisibleFloorIDs {
    //capacity can be increased (by adding more objects) is just an indicator
    NSMutableArray *returnFloorIDs = [NSMutableArray arrayWithCapacity:30];
    for(Floor *floor in [self getVisibleFloors]) {
        [returnFloorIDs addObject:[floor getFloorID]];
    }
}

-(void)changeVisibleFloorsWidthFloorCode:(NSString *)floorCode{
    
}

-(void)changeVisibleFloorsWidthFloorCodes:(NSArray *)floorCodes {
    //get floors to be set visible
    NSMutableArray *newFloors = [NSMutableArray arrayWithCapacity:5];/*capacitiy is just an indicator*/
    for(NSString *floorCode in floorCodes) {
        
    }
    
    
}
@end
