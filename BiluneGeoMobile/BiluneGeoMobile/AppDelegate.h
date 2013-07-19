//
//  AppDelegate.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingStack.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *occupants;
@property (strong, nonatomic) BuildingStack *buildingstack;
@end
