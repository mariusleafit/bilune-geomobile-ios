//
//  RoomQueryDelegate.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@protocol RoomQueryDelegate <NSObject>
-(void) roomQueryRoomFound:(Room *)room andQueryName:(NSString *)queryName;
-(void) roomQueryErrorOccured:(NSString*)queryName;
@end
