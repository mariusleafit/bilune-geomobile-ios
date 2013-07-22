//
//  BuildingListCell.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 19.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildingListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UILabel *addressText;

@end
