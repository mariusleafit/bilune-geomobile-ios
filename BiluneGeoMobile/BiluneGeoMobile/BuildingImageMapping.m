//
//  BuildingImageMapping.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 22.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "BuildingImageMapping.h"

@implementation BuildingImageMapping
+(NSDictionary *)mappingDict {
    NSDictionary *returnDict = [[NSDictionary alloc]
                                initWithObjects:[[NSArray alloc] initWithObjects:
                                @"01_snicolas4.jpg",
                                 @"02_boine20.jpg",
                                 @"06_fbglac5a.jpg",
                                 @"07_dupeyrou1.jpg",
                                 @"07_dupeyrou6.jpg",
                                 @"09_fbghopital27.jpg",
                                 @"10_fbghopital41.jpg",
                                 @"13_beauxarts28.jpg",
                                 @"14_pmars26.jpg",
                                 @"15_fbghopital106.jpg",
                                 @"16_fbghopital61.jpg",
                                 @"17_fbghopital77.jpg",
                                 @"19_Breguet1.jpg",
                                 @"23_MAL10.jpg",
                                 @"24_PAM7.jpg",
                                 @"25_pam11.jpg",
                                 @"26_Agassiz1.jpg",
                                 @"29_bellevaux51.jpg",
                                 @"30_unimail.jpg",
                                 @"31_latenium_1e.jpg",
                                 @"33_vau22.jpg",nil]
                                forKeys:[[NSArray alloc] initWithObjects:
                                @"01_snicolas4",
                                 @"02_boine20",
                                 @"06_fbglac5a",
                                 @"07_dupeyrou1",
                                 @"07_dupeyrou6",
                                 @"09_fbghopital27",
                                 @"10_fbghopital41",
                                 @"13_beauxarts28",
                                 @"14_pmars26",
                                 @"15_fbghopital106",
                                 @"16_fbghopital61",
                                 @"17_fbghopital77",
                                 @"19_Breguet1",
                                 @"23_MAL10",
                                 @"24_PAM7",
                                 @"25_pam11",
                                 @"26_Agassiz1",
                                 @"29_unimail_g",
                                 @"30_unimail",
                                 @"31_latenium_1e",
                                 @"33_vau22",nil]
                                ];
    return returnDict;
}
@end
