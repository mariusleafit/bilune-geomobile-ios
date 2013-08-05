//
//  RoomInfoViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "RoomInfoViewController.h"

@interface RoomInfoViewController () {
    Room *room;
}

@end

@implementation RoomInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.address.detailTextLabel.text = room.address;
    self.floorName.detailTextLabel.text = room.parentFloor.floorName;
    self.roomName.detailTextLabel.text = room.name;
    self.area.detailTextLabel.text = room.area;
    self.roomType.detailTextLabel.text = room.type;
    self.occupants.detailTextLabel.text = room.occupants;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRoom:(Room *)pRoom {
    room = pRoom;
}

#pragma mark IBAction
- (IBAction)returnToMap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
