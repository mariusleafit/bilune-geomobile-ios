//
//  ChangeFloorListCell.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 31.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeFloorListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *floorName;
@property (weak, nonatomic) IBOutlet UISwitch *visibilitySwitch;

@end
