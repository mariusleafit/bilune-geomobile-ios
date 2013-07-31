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
    BuildingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BuildingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
        FloorListViewController *viewController = (FloorListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FloorListView"];
        [viewController setBuilding:clickedBuilding];
        [self presentViewController:viewController animated:YES completion:nil];

    }
}

#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark IBAction
- (IBAction)returnToMenu:(id)sender {
    //show SearchOccupants
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:viewController animated:YES completion:nil];
}


@end
