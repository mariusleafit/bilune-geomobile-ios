//
//  ScaleBarView.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 30.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "ScaleBarView.h"

@interface ScaleBarView()
@property (nonatomic) UIImageView *scaleImage;
    
@end

@implementation ScaleBarView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super initWithCoder:aDecoder]) {
        self.scaleImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 80, 7)];
        [self.scaleImage setImage:[UIImage imageNamed:@"scale.png"]];
        [self addSubview:self.scaleImage];
        
        unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 52, 17)];
        [unitLabel setText:@"100 m"];
        [unitLabel setFont:[UIFont fontWithName:@"Helvetica" size: 12.0]];
        [unitLabel setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.0]];
        [unitLabel setOpaque:NO];
        
        [self addSubview:unitLabel];
    }
    return self;
}

-(void) updateBar:(CGFloat)metersPerUnit {
	[unitLabel setText:label];
    
    float distanceInMeter = (80 * metersPerUnit);
    if(distanceInMeter > 1000) {
        [unitLabel setText:[NSString stringWithFormat:@"%2.0f km",(distanceInMeter / 1000)]];
    }else {
        [unitLabel setText:[NSString stringWithFormat:@"%2.0f m",distanceInMeter]];
    }
	
	[self setNeedsDisplay];
}

@end
