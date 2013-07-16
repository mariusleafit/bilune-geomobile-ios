//
//  constants.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 12.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Constants.h"

@implementation Constants

+(NSString *) OCCUPANTSURL {return @"https://biluneapp.unine.ch/IGeomobileAccessServices/occupants";}
+(NSString *) BUILDINGSURL {return @"https://biluneapp.unine.ch/IGeomobileAccessServices/buildings";}
+(float) DOWNLOADTIMEOUT {return 5.0;}

//BILUNE Constants
+(NSString *)BILUNE_MAIN_URL{return @"http://biluneapp.unine.ch/arcgis/rest/services/ebilune/";}

@end
