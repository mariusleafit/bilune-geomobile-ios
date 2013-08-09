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
        self.scaleImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 80, 8)];
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

// Override drawRect for drawing the actual scale bar
// cf. source #1
/*- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(ctx, 8.0);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 30, 10);
    CGPathAddLineToPoint(path, NULL, 110, 10);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGContextSetStrokeColorWithColor(ctx,[UIColor blackColor].CGColor);
    CGContextStrokePath(ctx);
    CGPathRelease(path);
	
}*/

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
