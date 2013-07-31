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
+(NSString *)ROAD_MAP_URL{return @"http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer";}
+(NSString *)SATELITE_MAP_URL{return @"http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer";}

+(AGSEnvelope *)INITIAL_EXTENT {
    return [[AGSEnvelope alloc] initWithXmin:771387.8263244121 ymin:5939725.698962646 xmax:773689.5858964956 ymax:5943264.654304724 spatialReference:[Constants BASEMAP_SPATIALREFERENCE]];
}
+(AGSSpatialReference *)BASEMAP_SPATIALREFERENCE {
    return [[AGSSpatialReference alloc] initWithWKID:102100];
}
+(AGSSpatialReference *)BILUNE_SPATIALREFERENCE {
    return [[AGSSpatialReference alloc] initWithWKID:21781];
}

+(int)ZOOMSTATE_TRANSITION_HEIGHT {
    return 300;
}
@end
