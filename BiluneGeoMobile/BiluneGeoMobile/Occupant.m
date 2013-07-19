//
//  Occupant.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Occupant.h"

@implementation Occupant

@synthesize endpoint;
@synthesize floorID;
@synthesize locCode;
@synthesize locTypeDesignation;
@synthesize occupantName;

+(id)occupantWidthEndpoint:(NSString *)pEndpoint andFloorID:(NSNumber *)pFloorID andLocCode:(NSString *)pLocCode andLocTypeDesignation:(NSString *)pLocTypeDesignation andOccupantsName:(NSString *)pOccupantsName {
    Occupant *returnOccupant = [[Occupant alloc] init];
    returnOccupant.endpoint = pEndpoint;
    returnOccupant.floorID = pFloorID;
    returnOccupant.locCode = pLocCode;
    returnOccupant.locTypeDesignation = pLocTypeDesignation;
    returnOccupant.occupantName = pOccupantsName;
    return returnOccupant;
}

+(id)occupantWidthDictionary:(NSDictionary *)data4 {
    NSString *endpoint = [data4 objectForKey:@"Endpoint"];
    NSNumber *floorID = [data4 objectForKey:@"FloorID"];
    NSString *locCode = [data4 objectForKey:@"LocCode"];
    NSString *locTypeDesignation = [data4 objectForKey:@"LocTypeDesignation"];
    NSString *occupantName = [data4 objectForKey:@"Name"];
    
    return [Occupant occupantWidthEndpoint:endpoint andFloorID:floorID andLocCode:locCode andLocTypeDesignation:locTypeDesignation andOccupantsName:occupantName];
}

@end
