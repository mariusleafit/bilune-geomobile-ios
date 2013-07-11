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

+(id)occupantWidthDictionary:(NSDictionary *)data {
    NSString *endpoint = [data objectForKey:@"Endpoint"];
    NSNumber *floorID = [data objectForKey:@"FloorID"];
    NSString *locCode = [data objectForKey:@"LocCode"];
    NSString *locTypeDesignation = [data objectForKey:@"LocTypeDesignation"];
    NSString *occupantName = [data objectForKey:@"Name"];
    
    return [Occupant occupantWidthEndpoint:endpoint andFloorID:floorID andLocCode:locCode andLocTypeDesignation:locTypeDesignation andOccupantsName:occupantName];
}

@end
