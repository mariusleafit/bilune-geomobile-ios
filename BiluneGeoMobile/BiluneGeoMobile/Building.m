
//
//  Building.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Building.h"
#import "Constants.h"


@interface Building()

@property(strong) NSMutableArray *floors;

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
    if(data == nil) {
        return nil;
    }
    
    Building *returnBuilding = [[Building alloc]init];
    
    //init with NSDictionary
    returnBuilding.shortURL = (NSString *)[data valueForKey:@"Url"];
    returnBuilding.fullURL = [NSString stringWithFormat:@"%@%@/MapServer",[Constants BILUNE_MAIN_URL],[[data valueForKey:@"Url"] stringByReplacingOccurrencesOfString:@"ebilune/" withString:@""]];
    
    returnBuilding.mapName = (NSString *)[data valueForKey:@"Name"];
    
    returnBuilding.address = (NSString *)[data valueForKey:@"Address"];
    
    //Extend: XMin , XMax, YMin, YMax SpatialReference: SpatialReference
    
    //getFloors
    returnBuilding.floors = [[NSMutableArray alloc] init];
    for (NSDictionary *floorDict in (NSDictionary *)[data valueForKey:@"Floors"]) {
        if(floorDict != nil) {
            Floor *tmpFloor = [Floor createWidthData:floorDict andParentBuilding:returnBuilding];
            if(tmpFloor) {
                [returnBuilding.floors addObject: tmpFloor];
            }
        }
    }
    
    //calculate MaxExtent
    
    return returnBuilding;
}

-(NSString *)getBatCode {
    NSString *returnBatCode;
    if(!self.mapName) {
        NSLog(@"test if substring works ");
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
        [returnFloorIDs addObject:[floor getStrFloorID]];
    }
    return returnFloorIDs;
}

-(Floor *)getFloorWidthFloorCode:(NSString *)floorCode {
    Floor *returnFloor = nil;
    if(self.floors && self.floors.count > 0) {
        int i = 0;
        while(returnFloor == nil && self.floors.count > i) {
            if(((Floor *)self.floors[i]).floorCode == floorCode) {
                returnFloor = (Floor *)self.floors[i];
            }
            i++;
        }
    }
    return returnFloor;
}

-(Floor *)getFloorWidthFloorID:(NSNumber *)floorID {
    Floor *returnFloor = nil;
    if(self.floors && self.floors.count > 0) {
        int i = 0;
        while(returnFloor == nil && self.floors.count > i) {
            if(((Floor *)self.floors[i]).floorID == floorID) {
                returnFloor = (Floor *)self.floors[i];
            }
            i++;
        }
    }
    return returnFloor;
}


-(void)changeVisibleFloorsWidthFloorCode:(NSString *)floorCode{
    [self changeVisibleFloorsWidthFloorCodes:[NSArray arrayWithObject:floorCode]];
}

-(void)changeVisibleFloorsWidthFloorCodes:(NSArray *)floorCodes {
    //get floors to be set visible
    NSMutableArray *newFloors = [NSMutableArray arrayWithCapacity:5];/*capacitiy is just an indicator*/
    for(NSString *floorCode in floorCodes) {
        if([self getFloorWidthFloorCode:floorCode]) {
            [newFloors addObject:[self getFloorWidthFloorCode:floorCode]];
        }
    }
    
    if(newFloors.count > 0) {
        //get currently visible floors
        NSMutableArray *currentFloors = [NSMutableArray arrayWithArray:[self getVisibleFloors]];
        if(currentFloors.count > 0) {
            for(Floor *floor in currentFloors){
                [floor setVisibility:NO];
            }
        }
        
        //sort newFloors by floorID
        NSLog(@"Test: Folder sorting");
        [newFloors sortUsingComparator:^NSComparisonResult(id a, id b) {
            return[((Floor *)a).floorID compare:((Floor *)b).floorID];
        }];
        
        for(Floor *floor in newFloors) {
            [floor setVisibility:YES];
        }
        
    }
}

-(void)hide {
    
}

-(void)show {
    
}
@end
