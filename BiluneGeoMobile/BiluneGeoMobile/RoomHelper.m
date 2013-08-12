//
//  RoomHelper.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "RoomHelper.h"
#import "Building.h"


@implementation RoomHelper
+(Room *)getRoomFromGraphic:(AGSGraphic *)graphic andBuildingStack:(BuildingStack *)buildingStack andBuildingUrlFull:(NSURL *)buildingUrlFull {
    Room *returnRoom;
    if(graphic != nil && buildingStack != nil && buildingUrlFull) {
        NSString *locCode = [graphic attributeAsStringForKey:@"LOC_CODE"];
        NSString *locOccupants = [graphic attributeAsStringForKey:@"LOC_OCCUPANTS"];
        NSString *batAddress = [graphic attributeAsStringForKey:@"BAT_ADRESSE"];
        NSString *locType = [graphic attributeAsStringForKey:@"LOC_TYPE_DESIGNATION"];
        NSString *floorCode = [graphic attributeAsStringForKey:@"ETG_CODE"];
        NSString *locArea = [graphic attributeAsStringForKey:@"SHAPE_Area"];
        
        //get parentBuilding
        Building *parentBuilding = [buildingStack getBuildingWithFullURL:buildingUrlFull];
        if(parentBuilding) {
            //getFloor
            Floor *parentFloor = [parentBuilding getFloorWithFloorCode:floorCode];
            if(parentFloor) {
                AGSPolygon *roomPolygon = (AGSPolygon *)graphic.geometry;
                returnRoom = [Room createWithName:locCode andOccupants:locOccupants andPolygon:roomPolygon andParentFloor:parentFloor andParentBuilding:parentBuilding andAddress:batAddress andType:locType andArea:locArea];
            }
        }
        
        
    }
    return returnRoom;
}
@end
