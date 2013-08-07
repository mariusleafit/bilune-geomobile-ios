//
//  RoomFromObjectIDQuery.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
#import "RoomQueryDelegate.h"
#import "BuildingStack.h"

@interface RoomFromObjectIDQuery : NSObject <AGSQueryTaskDelegate>
-(id)initWidthUrl:(NSURL *)url andName:(NSString *)name andDelegate:(id<RoomQueryDelegate>)delegate andObjectID:(int)objectID andBuildingStack:(BuildingStack *)buildingStack;

-(void)execute;
@end
