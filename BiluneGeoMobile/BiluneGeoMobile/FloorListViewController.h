//
//  FloorListViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"

@interface FloorListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UILabel *buildingAddress;
@property (weak, nonatomic) IBOutlet UITableView *floorsTable;


-(void) setBuilding:(Building *)pBuilding;
@end
