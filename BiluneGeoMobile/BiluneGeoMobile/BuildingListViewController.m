//
//  BuildingListViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "BuildingListViewController.h"
#import "AppDelegate.h"
#import "Building.h"
#import "BuildingListCell.h"
#import "BuildingImageMapping.h"
#import "FloorListViewController.h"

@interface BuildingListViewController ()
@property (weak) AppDelegate *appDelegate;
@end

@implementation BuildingListViewController

@synthesize appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];    
    self.appDelegate = GetAppDelegate();
    
    self.title = @"Bâtiments UNINE";
    
    self.buildingsList.dataSource = self;
    self.buildingsList.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[appDelegate.buildingstack getBuildings] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BuildingCell";
    
    //get cell
    BuildingListCell *cell = [self.buildingsList dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        UIViewController *tmpViewController = [[UIViewController alloc] initWithNibName:@"BuildingListCell" bundle:nil];
        cell = (BuildingListCell *)tmpViewController.view;
    }
    
    //get building
    Building *building = [[appDelegate.buildingstack getBuildings] objectAtIndex:indexPath.row];
    if(building) {
        cell.addressText.text  = building.address;
        if([building getImage]){
            [cell.buildingImage setImage:[building getImage]];
        }
    }

    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Building *clickedBuilding = [[appDelegate.buildingstack getBuildings] objectAtIndex:indexPath.row];
    if(clickedBuilding) {
        FloorListViewController *viewController = [[FloorListViewController alloc] initWithNibName:@"FloorList" bundle:nil];
        [viewController setBuilding:clickedBuilding];
        [self.appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark DeviceOrientation
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark IBAction



@end
