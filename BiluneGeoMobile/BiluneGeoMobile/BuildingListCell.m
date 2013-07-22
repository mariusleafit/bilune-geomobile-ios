//
//  BuildingListCell.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 19.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "BuildingListCell.h"

@implementation BuildingListCell

@synthesize addressText;
@synthesize buildingImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
