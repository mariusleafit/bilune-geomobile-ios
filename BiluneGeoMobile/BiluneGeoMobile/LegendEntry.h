//
//  LegendEntry.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LegendEntry : NSObject
-(id)initWithColor:(UIColor *)color title:(NSString *)title;
-(id)initWithDictionary:(NSDictionary *)dict;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *title;
@end
