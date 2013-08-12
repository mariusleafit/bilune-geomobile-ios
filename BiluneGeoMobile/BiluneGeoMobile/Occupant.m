//
//  Occupant.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Occupant.h"
#import "Constants.h"

@implementation Occupant

@synthesize endpoint;
@synthesize floorID;
@synthesize locCode;
@synthesize locTypeDesignation;
@synthesize occupantName;
@synthesize floorUrlFull;
@synthesize buildingUrlFull;

+(id)occupantWithEndpoint:(NSString *)pEndpoint andFloorID:(NSNumber *)pFloorID andLocCode:(NSString *)pLocCode andLocTypeDesignation:(NSString *)pLocTypeDesignation andOccupantsName:(NSString *)pOccupantsName {
    Occupant *returnOccupant = [[Occupant alloc] init];
    returnOccupant.endpoint = pEndpoint;
    returnOccupant.floorID = pFloorID;
    returnOccupant.locCode = pLocCode;
    returnOccupant.locTypeDesignation = pLocTypeDesignation;
    returnOccupant.occupantName = pOccupantsName;
    
    NSString *cuttedEndpoint = [pEndpoint stringByReplacingOccurrencesOfString:@"ebilune/" withString:@""];
    
    returnOccupant.floorUrlFull = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/MapServer/%@",[Constants BILUNE_MAIN_URL],cuttedEndpoint,pFloorID]];
    returnOccupant.buildingUrlFull = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/MapServer",[Constants BILUNE_MAIN_URL],cuttedEndpoint]];
    return returnOccupant;
}

+(id)occupantWithDictionary:(NSDictionary *)data4 {
    NSString *endpoint = [data4 objectForKey:@"Endpoint"];
    NSNumber *floorID = [data4 objectForKey:@"FloorID"];
    NSString *locCode = [data4 objectForKey:@"LocCode"];
    NSString *locTypeDesignation = [data4 objectForKey:@"LocTypeDesignation"];
    NSString *occupantName = [data4 objectForKey:@"Name"];
    
    return [Occupant occupantWithEndpoint:endpoint andFloorID:floorID andLocCode:locCode andLocTypeDesignation:locTypeDesignation andOccupantsName:occupantName];
}

@end
