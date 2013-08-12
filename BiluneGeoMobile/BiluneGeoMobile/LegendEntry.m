//
//  LegendEntry.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "LegendEntry.h"

@implementation LegendEntry
@synthesize title, color;

-(id)initWithColor:(UIColor *)pColor title:(NSString *)pTitle {
    self = [super init];
    if(self) {
        self.title = pTitle;
        self.color = pColor;
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.title = (NSString *)[dict valueForKey:@"Value"];
        self.color = [UIColor colorWithRed:([[dict valueForKey:@"Red"] floatValue]/255.0) green:([[dict valueForKey:@"Green"] floatValue]/255.0) blue:([[dict valueForKey:@"Blue"] floatValue]/255.0) alpha:([[dict valueForKey:@"Alpha"] floatValue]/255.0)];
    }
    return self;
}
@end
