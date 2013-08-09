//
//  CompassView.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 09.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "CompassView.h"

@interface CompassView()

@property (nonatomic) UIImageView *compassImage;
@end

@implementation CompassView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super initWithCoder:aDecoder]) {
        
        self.compassImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
        [self.compassImage setImage:[UIImage imageNamed:@"compass.png"]];
        [self addSubview:self.compassImage];
        
    }
    return self;
}


-(void)rotate:(float)rotationDegrees {
    [self.compassImage setTransform:CGAffineTransformMakeRotation(-(rotationDegrees*3.14)/180)];
}

@end
