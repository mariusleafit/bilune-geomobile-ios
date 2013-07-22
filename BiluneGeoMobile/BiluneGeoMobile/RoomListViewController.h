//
//  RoomListViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Floor.h"

@interface RoomListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UILabel *buildingAddress;
@property (weak, nonatomic) IBOutlet UILabel *floorName;
@property (weak, nonatomic) IBOutlet UITableView *roomList;
- (IBAction)returnToEtages:(id)sender;

- (void) setFloor:(Floor *)pFloor;
@end
