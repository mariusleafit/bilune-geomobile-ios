//
//  RoomHelper.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "BuildingStack.h"

@interface RoomHelper : NSObject
+(Room *)getRoomFromGraphic:(AGSGraphic *)graphic andBuildingStack:(BuildingStack *)buildingStack andBuildingUrlFull:(NSURL *)buildingUrlFull;
@end
