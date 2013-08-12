    //
//  BuildingStack.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "BuildingStack.h"

@interface BuildingStack()

@property(strong) NSMutableArray *buildings;

@end

@implementation BuildingStack

@synthesize buildings;

-(id)init {
    self = [super init];
    if(self) {
        self.buildings = [[NSMutableArray alloc] init];
    }
    return self;
}

///*create BuildingStack with JSON-data
+(BuildingStack *) createWithData:(NSDictionary *)data {
    if(data == nil) {
        return nil;
    }
    
    BuildingStack *returnBuildingStack = [[BuildingStack alloc] init];
    
    //initialize with Dictionary
    // add Buildings
    for(NSDictionary *buildingDict in data) {
        if(buildingDict != nil) {
            Building *tmpBuilding = [Building createWithData:buildingDict];
            if(tmpBuilding) {
                [returnBuildingStack.buildings addObject:tmpBuilding];
            }
        }
    }

    return returnBuildingStack;
}

///*get Building with URL (eg. http://biluneapp.unine.ch/arcgis/rest/services/ebilune/30_unimail_web/MapServer)
-(Building *) getBuildingWithFullURL:(NSURL *)pFullURL{
    Building *returnBuilding = nil;
    if(self.buildings && self.buildings.count > 0) {
        int i = 0;
        while(returnBuilding == nil && self.buildings.count > i) {
            Building *tmpBuilding = (Building *)self.buildings[i];
            if([[tmpBuilding.fullURL absoluteString] isEqualToString:[pFullURL absoluteString]]) {
                returnBuilding = tmpBuilding;
            }
            i++;
        }
    }
    return returnBuilding;
}

///*get Building with URL (eg. ebilune/30_unimail_web)
-(Building *) getBuildingWithShortURL:(NSString *)pShortURL {
    Building *returnBuilding = nil;
    if(self.buildings && self.buildings.count > 0) {
        int i = 0;
        while(returnBuilding == nil && self.buildings.count > i) {
            Building *tmpBuilding = (Building *)self.buildings[i];
            if([tmpBuilding.shortURL isEqualToString:pShortURL]) {
                returnBuilding = tmpBuilding;
            }
            i++;
        }
    }
    return returnBuilding;
}

-(Building *)getBuildingWithPoint:(AGSPoint *)point andSpatialReference:(AGSSpatialReference *)spatialReference {
    Building *returnBuilding = nil;
    int i = 0;
    while(returnBuilding == nil && i < [self.buildings count]) {
        Building *tmpBuilding = [self.buildings objectAtIndex:i];
        if([tmpBuilding isClickedWithPoint:point andSpatialReference:nil]) {
            returnBuilding = tmpBuilding;
        }
        i++;
    }
    return returnBuilding;
}

-(NSArray *)getBuildings {
    return buildings;
}

-(void)resetFloorVisibility {
    for(Building *building in self.buildings) {
        [building resetFloorVisibility];
    }
}

@end
