//
//  LegendViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LegendViewController : UIViewController<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *legendTable;
@property (weak, nonatomic) AppDelegate *appDelegate;
@end
