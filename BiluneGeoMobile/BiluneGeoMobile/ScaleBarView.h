//
//  ScaleBarView.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 30.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleBarView : UIView {
	// Unit label
	UILabel *unitLabel;
	
	CGFloat pixels;
	NSString *label;
}

// Updates the scaleBar
-(void) updateBar:(CGFloat)metersPerUnit;


@end
