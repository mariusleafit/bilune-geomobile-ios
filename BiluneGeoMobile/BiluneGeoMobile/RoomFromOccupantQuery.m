//
//  RoomFromOccupantQuery.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 06.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "RoomFromOccupantQuery.h"
@interface RoomFromOccupantQuery() {
    NSString *queryName;
    id<RoomQueryDelegate> queryDelegate;
    AGSQueryTask *queryTask;
    AGSQuery *query;
    BuildingStack *queryBuildingStack;
    Occupant *queryOccupant;
}
@end

@implementation RoomFromOccupantQuery

-(id)initWithOccupant:(Occupant *)occupant andName:(NSString *)name andDelegate:(id<RoomQueryDelegate>)delegate andBuildingStack:(BuildingStack *)buildingStack {
    self = [super init];
    if(self) {
        queryName = name;
        queryDelegate = delegate;
        queryBuildingStack = buildingStack;
        queryOccupant = occupant;
        
        queryTask = [AGSQueryTask queryTaskWithURL:occupant.floorUrlFull];
        queryTask.delegate = self;
        
        
        query = [AGSQuery query];
        query.outFields = [NSArray arrayWithObjects:@"*", nil];
        query.where = [NSString stringWithFormat:@"LOC_CODE='%@'",occupant.locCode];
        query.returnGeometry = true;
    }
    return self;
}

-(void)execute {
    [queryTask executeWithQuery:query];
}

#pragma mark AGSQueryTaskDelegate
//results are returned
- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation *)op didExecuteWithFeatureSetResult:(AGSFeatureSet *)featureSet {
	//get Room from featureSet
    Room *foundRoom = nil;
    if([featureSet.features count] > 0) {
        NSString *locCode = [(AGSGraphic *)(featureSet.features[0]) attributeAsStringForKey:@"LOC_CODE"];
        NSString *locOccupants = [(AGSGraphic *)(featureSet.features[0]) attributeAsStringForKey:@"LOC_OCCUPANTS"];
        NSString *batAddress = [(AGSGraphic *)(featureSet.features[0]) attributeAsStringForKey:@"BAT_ADRESSE"];
        NSString *locType = [(AGSGraphic *)(featureSet.features[0]) attributeAsStringForKey:@"LOC_TYPE_DESIGNATION"];
        NSString *floorCode = [(AGSGraphic *)(featureSet.features[0]) attributeAsStringForKey:@"ETG_CODE"];
        NSString *locArea = [(AGSGraphic *)(featureSet.features[0]) attributeAsStringForKey:@"SHAPE_Area"];
        
        //get parentBuilding
        Building *parentBuilding = [queryBuildingStack getBuildingWithFullURL:queryOccupant.buildingUrlFull];
        if(parentBuilding) {
            //getFloor
            Floor *parentFloor = [parentBuilding getFloorWithFloorCode:floorCode];
            if(parentFloor) {
                AGSPolygon *roomPolygon = (AGSPolygon *)(((AGSGraphic *)(featureSet.features[0])).geometry);
                
                foundRoom = [Room createWithName:locCode andOccupants:locOccupants andPolygon:roomPolygon andParentFloor:parentFloor andParentBuilding:parentBuilding andAddress:batAddress andType:locType andArea:locArea];
            }
        }
        
    }
    [queryDelegate roomQueryRoomFound:foundRoom andQueryName:queryName];
}




//error occured
- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation *)op didFailWithError:(NSError *)error {
    [queryDelegate roomQueryErrorOccured:queryName];
}


@end
