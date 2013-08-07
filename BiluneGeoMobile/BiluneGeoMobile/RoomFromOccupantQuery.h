//
//  RoomFromOccupantQuery.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 06.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
#import "Occupant.h"
#import "RoomQueryDelegate.h"
#import "BuildingStack.h"

@interface RoomFromOccupantQuery : NSObject<AGSQueryTaskDelegate>
-(id)initWidthOccupant:(Occupant *)occupant andName:(NSString *)queryName andDelegate:(id<RoomQueryDelegate>)delegate andBuildingStack:(BuildingStack *)buildingStack;

-(void)execute;
@end
