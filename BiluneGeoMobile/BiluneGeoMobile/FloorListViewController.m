//
//  FloorListViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "FloorListViewController.h"
#import "AppDelegate.h"
#import "BuildingImageMapping.h"
#import "Floor.h"
#import "RoomListViewController.h"

@interface FloorListViewController ()
@property (weak) AppDelegate *appDelegate;
@end

@implementation FloorListViewController

Building *building;

@synthesize appDelegate;

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
    
    //prepare View
    [self.buildingAddress setText:building.address];
    if([building getImage]){
        [self.buildingImage setImage:[building getImage]];
    }
    
    self.title = @"Etages";
    
    self.floorsTable.delegate = self;
    self.floorsTable.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBuilding:(Building *)pBuilding {
    building = pBuilding;
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[building getFloors] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"FloorCell";
    
    //get cell
    UITableViewCell *cell = [self.floorsTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Floor *currentFloor = [[building getFloors] objectAtIndex:indexPath.row];
    if(currentFloor) {
        cell.textLabel.text  = currentFloor.floorName;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomListViewController *viewController = [[RoomListViewController alloc] initWithNibName:@"RoomList" bundle:nil];
    [viewController setFloor:[[building getFloors] objectAtIndex:indexPath.row]];
    [self.appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark IBAction


@end
