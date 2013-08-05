//
//  RoomInfoViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface RoomInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
- (IBAction)returnToMap:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *address;
@property (weak, nonatomic) IBOutlet UITableViewCell *floorName;
@property (weak, nonatomic) IBOutlet UITableViewCell *roomName;
@property (weak, nonatomic) IBOutlet UITableViewCell *area;
@property (weak, nonatomic) IBOutlet UITableViewCell *roomType;
@property (weak, nonatomic) IBOutlet UITableViewCell *occupants;

-(void)setRoom:(Room *)pRoom;
@end
