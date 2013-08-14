//
//  ChangeFloorViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
#import "MapViewController.h"

@interface ChangeFloorViewController : UIViewController<UITableViewDataSource> {
    Building *building;
    MapViewController *mapViewController;
}
-(void)setBuilding:(Building *)pBuilding;
@property (weak, nonatomic) IBOutlet UITableView *floorList;
-(void)setMapViewController:(MapViewController *)pMapViewController;
@end
