//
//  RoomFromObjectIDQuery.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//
#import "RoomFromObjectIDQuery.h"
#import "Room.h"

@interface RoomFromObjectIDQuery() {

    NSString *queryName;
    NSURL *queryUrl;
    id<RoomQueryDelegate> queryDelegate;
    int queryObjectID;
    AGSQueryTask *queryTask;
    AGSQuery *query;
    BuildingStack *queryBuildingStack;
}


@end

@implementation RoomFromObjectIDQuery
-(id)initWidthUrl:(NSURL *)url andName:(NSString *)name andDelegate:(id<RoomQueryDelegate>)delegate andObjectID:(int)objectID andBuildingStack:(BuildingStack *)buildingStack{
    self = [super init];
    if(self) {
        queryName = name;
        queryUrl = url;
        queryDelegate = delegate;
        queryObjectID = objectID;
        queryBuildingStack = buildingStack;
        
        queryTask = [AGSQueryTask queryTaskWithURL:url];
        queryTask.delegate = self;
        
        
        query = [AGSQuery query];
        query.outFields = [NSArray arrayWithObjects:@"*", nil];
        query.objectIds = [NSArray arrayWithObjects:[NSNumber numberWithInt:objectID], nil];
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
        NSString *buildingUrlFull = [[queryUrl absoluteString] substringToIndex:([queryUrl absoluteString].length -2)];
        
        Building *parentBuilding = [queryBuildingStack getBuildingWidthFullURL:[NSURL URLWithString:buildingUrlFull]];
        if(parentBuilding) {
            //getFloor
            Floor *parentFloor = [parentBuilding getFloorWidthFloorCode:floorCode];
            if(parentFloor) {
                AGSPolygon *roomPolygon = (AGSPolygon *)(((AGSGraphic *)(featureSet.features[0])).geometry);
            
                foundRoom = [Room createWidthName:locCode andOccupants:locOccupants andPolygon:roomPolygon andParentFloor:parentFloor andParentBuilding:parentBuilding andAddress:batAddress andType:locType andArea:locArea];
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
