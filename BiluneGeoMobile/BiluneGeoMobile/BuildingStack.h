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
-(Building *) getBuildingWidthFullURL:(NSURL *)fullURL;
///*get Building width URL (eg. ebilune/30_unimail_web)
-(Building *) getBuildingWidthShortURL:(NSString *)shortURL;
/*
-(Building *) getClickedBuildingWidthPoint:(AGSPoint *)point andSpatialReference:(AGSSpatialReference *)spatialReference; 
 */
-(NSArray *) getBuildings;
///*sets opacity of all buildings to 1.0
-(void) hideBuildings;
///*sets opacitiy of all buildings to 0
-(void) showBuildings;

@end
