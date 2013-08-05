//
//  BuildingStack.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Building.h"

@interface BuildingStack : NSObject {
    
}

///*create BuildingStack width JSON-data
+(BuildingStack *) createWidthData:(NSDictionary *)data;

///*get Building width URL (eg. http://biluneapp.unine.ch/arcgis/rest/services/ebilune/30_unimail_web/MapServer)
-(Building *) getBuildingWidthFullURL:(NSURL *)pFullURL;
///*get Building width URL (eg. ebilune/30_unimail_web)
-(Building *) getBuildingWidthShortURL:(NSString *)pShortURL;

-(Building *) getBuildingWidthPoint:(AGSPoint *)point andSpatialReference:(AGSSpatialReference *)spatialReference;

-(NSArray *) getBuildings;

-(void) resetFloorVisibility;
@end
