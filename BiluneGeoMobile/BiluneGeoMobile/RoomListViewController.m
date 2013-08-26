//
//  RoomListViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "RoomListViewController.h"
#import "AppDelegate.h"
#import "BuildingImageMapping.h"
#import "FloorListViewController.h"
#import "RoomsFromFloorQuery.h"
#import "MapViewController.h"

@interface RoomListViewController () {
    RoomsFromFloorQuery *roomsQuery;
}
@property (weak) AppDelegate *appDelegate;
@property (nonatomic) NSArray *roomsOfFloor;
@end

@implementation RoomListViewController

Floor *currentFloor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = GetAppDelegate();
    
	// prepare View
    if([currentFloor.parentBuilding getImage]){
        [self.buildingImage setImage:[currentFloor.parentBuilding getImage]];
    }
    
    self.buildingAddress.text = currentFloor.parentBuilding.address;
    
    self.floorName.text = currentFloor.floorName;
    
    self.roomsOfFloor = [[NSArray alloc] initWithObjects:nil];
    
    //load Rooms from currentFloor
    roomsQuery = [[RoomsFromFloorQuery alloc] initWithFloor:currentFloor andName:@"RoomsFromFloorQuery" andDelegate:self];
    [roomsQuery execute];
    
    self.title = @"Locaux";
    
    self.roomList.dataSource = self;
    self.roomList.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setFloor:(Floor *)pFloor {
    currentFloor = pFloor;
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.roomsOfFloor count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"RoomCell";
    
    //get cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //get room
    Room *room = [self.roomsOfFloor objectAtIndex:indexPath.row];
    if(room) {
        cell.textLabel.text = room.name;
        cell.detailTextLabel.text = room.type;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Room *room = [self.roomsOfFloor objectAtIndex:indexPath.row];
    if(room) {
        MapViewController *viewController = [[MapViewController alloc] initWithNibName:@"Map" bundle:nil];
        [viewController setRoomToZoomTo:room];
        [self.appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark MultipleRoomsQueryDelegate
-(void)roomQueryRoomsFound:(NSArray *)rooms andQueryName:(NSString *)queryName {
    self.roomsOfFloor = rooms;
    [self.roomList reloadData];
}

-(void)roomQueryErrorOccured:(NSString *)queryName {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Impossible de charger les données, veuillez vérifier l'état du réseau." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark DeviceOrientation
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark IBAction

@end
