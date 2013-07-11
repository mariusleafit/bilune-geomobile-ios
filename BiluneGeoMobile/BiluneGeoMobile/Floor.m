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


+(Floor *)createWidthData:(NSDictionary *)data andParentBuilding:(Building *)parentBuilding {
    Floor *returnFloor = [[Floor alloc] init];
    returnFloor.parentBuilding = parentBuilding;
    //load data from JSON
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
    
}

-(void)hide {
    
}

-(void)show {
    
}

@end
