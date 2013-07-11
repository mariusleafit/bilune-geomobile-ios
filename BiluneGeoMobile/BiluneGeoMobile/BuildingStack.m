//
//  BuildingStack.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "BuildingStack.h"

@interface BuildingStack()

@property(strong) NSArray *buildingUrls;
@property(strong) NSArray *buildings;

@end

@implementation BuildingStack

@synthesize buildings;
@synthesize buildingUrls;

///*create BuildingStack width JSON-data
+(BuildingStack *) createWidthData:(NSDictionary *)data {
    BuildingStack *returnBuildingStack = [[BuildingStack alloc] init];
    
    //setValues width data;
    
    return returnBuildingStack;
}

///*get Building width URL (eg. http://biluneapp.unine.ch/arcgis/rest/services/ebilune/30_unimail_web/MapServer)
-(Building *) getBuildingWidthFullURL:(NSURL *)fullURL{
    Building *returnBuilding = nil;
    if(self.buildings && self.buildings.count > 0) {
        int i = 0;
        while(returnBuilding == nil && self.buildings.count > i) {
            if(((Building *)self.buildings[i]).fullURL == fullURL) {
                returnBuilding = (Building *)self.buildings[i];
            }
            i++;
        }
    }
    return returnBuilding;
}

///*get Building width URL (eg. ebilune/30_unimail_web)
-(Building *) getBuildingWidthShortURL:(NSString *)shortURL {
    Building *returnBuilding = nil;
    if(self.buildings && self.buildings.count > 0) {
        int i = 0;
        while(returnBuilding == nil && self.buildings.count > i) {
            if(((Building *)self.buildings[i]).shortURL == shortURL) {
                returnBuilding = (Building *)self.buildings[i];
            }
            i++;
        }
    }
    return returnBuilding;
}

-(NSArray *)getBuildings {
    return buildings;
}

///*sets opacity of all buildings to 1.0
-(void)hideBuildings {
    
}

///*sets opacitiy of all buildings to 0
-(void)showBuildings {
    
}

@end
