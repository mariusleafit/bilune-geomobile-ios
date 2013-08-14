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
@property (weak, nonatomic) IBOutlet UITableView *infoTable;


-(void)setRoom:(Room *)pRoom;
@end
