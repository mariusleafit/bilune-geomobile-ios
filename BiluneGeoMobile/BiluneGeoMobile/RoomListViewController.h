//
//  RoomListViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Floor.h"
#import "MultipleRoomsQueryDelegate.h"

@interface RoomListViewController : UIViewController<MultipleRoomsQueryDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UILabel *buildingAddress;
@property (weak, nonatomic) IBOutlet UILabel *floorName;
@property (weak, nonatomic) IBOutlet UITableView *roomList;

- (void) setFloor:(Floor *)pFloor;
@end
