//
//  ChangeFloorViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"

@interface ChangeFloorViewController : UIViewController<UITableViewDataSource> {
    Building *building;
}
-(void)setBuilding:(Building *)pBuilding;
@property (weak, nonatomic) IBOutlet UITableView *floorList;
- (IBAction)returnToMap:(id)sender;

@end
