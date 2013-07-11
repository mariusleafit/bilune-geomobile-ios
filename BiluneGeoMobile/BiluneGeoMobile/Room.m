//
//  Room.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Room.h"
#import "Floor.h"
#import "Building.h"

@implementation Room

@synthesize name;
@synthesize occupants;
@synthesize polygon;
@synthesize parentFloor;
@synthesize parentBuilding;
@synthesize address;
@synthesize type;
@synthesize area;

+(Room *)createWidthName:(NSString *)name andOccupants:(NSString *)occupants andPolygon:(NSString *)polygon andParentFloor:(Floor *)floor andParentBuilding:(Building *)building andAddress:(NSString *)address andType:(NSString *)type andArea:(NSString *)area {
    
    Room *returnRoom = [[Room alloc] init ];
    returnRoom.name = name;
    returnRoom.occupants = occupants;
    returnRoom.polygon = polygon;
    returnRoom.parentFloor = floor;
    returnRoom.parentBuilding = building;
    returnRoom.address = address;
    returnRoom.type = type;
    returnRoom.area = area;
    
    return returnRoom;
}

@end
