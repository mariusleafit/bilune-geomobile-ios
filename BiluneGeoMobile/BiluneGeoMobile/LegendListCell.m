//
//  LegendCell.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 07.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "LegendListCell.h"

@implementation LegendListCell

@synthesize titleLabel;

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
