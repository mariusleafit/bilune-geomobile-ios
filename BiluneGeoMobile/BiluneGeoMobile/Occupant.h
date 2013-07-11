//
//  Occupant.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Occupant : NSObject

@property (nonatomic, strong) NSString *endpoint;
@property (nonatomic, strong) NSNumber *floorID;
@property (nonatomic, strong) NSString *locCode;
@property (nonatomic, strong) NSString *locTypeDesignation;
@property (nonatomic, strong) NSString *occupantName;

+(id)occupantWidthEndpoint:(NSString *)pEndpoint andFloorID:(NSNumber *)pFloorID andLocCode:(NSString *)pLocCode andLocTypeDesignation:(NSString *)pLocTypeDesignation andOccupantsName:(NSString *)pOccupantsName;

+(id)occupantWidthDictionary:(NSDictionary *)data;

@end
