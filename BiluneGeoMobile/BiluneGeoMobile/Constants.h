//
//  constants.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 12.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>

#define OCCUPANTSURL @"https://biluneapp.unine.ch/IGeomobileAccessServices/occupants"
#define BUILDINGSURL @"https://biluneapp.unine.ch/IGeomobileAccessServices/buildings"

@interface Constants : NSObject

//VENUS constants
+(float) DOWNLOADTIMEOUT;

//ArcGIS constants
+(NSString *) BILUNE_MAIN_URL;
+(NSString *) SATELITE_MAP_URL;
+(NSString *) ROAD_MAP_URL;

+(AGSEnvelope *) INITIAL_EXTENT;
+(AGSSpatialReference *) BASEMAP_SPATIALREFERENCE;
+(AGSSpatialReference *) BILUNE_SPATIALREFERENCE;

//at which length of the scale should the buildings be hidden and overview displayed
+(int) ZOOMSTATE_TRANSITION_HEIGHT;
@end
