//
//  Room.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Floor.h"

@interface Room : NSObject {
    
}
+(Room *)createWidthName:(NSString *)name andOccupants:(NSString *)occupants andPolygon:/*(AGSPolygon *)*/(NSString *)polygon andParentFloor:(Floor *)floor
       andParentBuilding:(Building *)building andAddress:(NSString *)address andType:(NSString *)type andArea:(NSString *)area;

-(NSString *)getName;
-(NSString *)getOccupants;
-/*(AGSPolygon *)*/(NSString *)getPolygon;
-(Floor *)getParentFloor;
-(Building *)getParentBuilding;
-(NSString *)getAddress;
-(NSString *)getType;
-(NSString *)getArea;

@end
