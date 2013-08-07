//
//  RoomInfoViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface RoomInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)returnToMap:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *infoTable;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;


-(void)setRoom:(Room *)pRoom;
@end
