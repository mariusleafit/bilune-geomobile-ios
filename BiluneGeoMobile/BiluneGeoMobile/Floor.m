//
//  Floor.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Floor.h"
#import "Building.h"

@interface Floor()

@end

@implementation Floor

@synthesize floorID;
@synthesize floorName;
@synthesize floorCode;
@synthesize parentBuilding;
@synthesize defaultVisibility;


+(Floor *)createWidthData:(NSDictionary *)data andParentBuilding:(Building *)parentBuilding {
    if(data == nil) {
        return nil;
    }
    
    Floor *returnFloor = [[Floor alloc] init];
    returnFloor.parentBuilding = parentBuilding;
    //load data from JSON
    returnFloor.floorID = (NSNumber *)[data valueForKey:@"ID"];
    
    returnFloor.floorName = (NSString *)[data valueForKey:@"Name"];
    
    returnFloor.floorCode = (NSString *)[data valueForKey:@"Code"];
    
    returnFloor.defaultVisibility = (BOOL)[data valueForKey:@"defaultVisibility"];
    
    //Extend & SpatialReference
    return returnFloor;
}

///returns fullUrl of parentBuilding
-(NSURL *)getParentBuildingURL {
    return self.parentBuilding.fullURL;
}

-(NSString *)getStrFloorID {
    NSLog(@"Test Floor getStrFloorID");
    return [NSString stringWithFormat:@"%@", self.floorID];
}

-(NSURL *)getFloorURL {
    return [NSString stringWithFormat:@"%@/%@", self.getParentBuildingURL, self.getStrFloorID];
}

-(void) setVisibility:(BOOL)visibility {
    
}

-(BOOL) isVisible{
    return NO;
}

-(void)hide {
    
}

-(void)show {
    
}

@end
