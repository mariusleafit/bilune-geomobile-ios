//
//  ChangeFloorViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 05.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "ChangeFloorViewController.h"
#import "ChangeFloorListCell.h"

@interface ChangeFloorViewController ()

@end

@implementation ChangeFloorViewController

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
	self.floorList.dataSource = self;
    self.title = @"Étages";
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //change floors on map
    
    //is at least one floor visible?
    BOOL isVisible = false;
    for(Floor *floor in [building getFloors]) {
        if([floor isVisible]) {
            isVisible = true;
        }
    }
    //set visibility back to default
    if(!isVisible) {
        [building resetFloorVisibility];
    }
    [mapViewController updateVisibleFloorsFromBuilding:building];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBuilding:(Building *)pBuilding {
    building = pBuilding;
}

-(void)setMapViewController:(MapViewController *)pMapViewController {
    mapViewController = pMapViewController;
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[building getFloors] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ChangeFloorCell";
    
    //get cell
    ChangeFloorListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        UIViewController *tmpViewController = [[UIViewController alloc] initWithNibName:@"ChangeFloorCell" bundle:nil];
        //cell = [[ChangeFloorListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell = (ChangeFloorListCell *)tmpViewController.view;
    }
    
    //get Floor
    Floor *floor = [[building getFloorsSortedAsc:NO] objectAtIndex:indexPath.row];
    if(floor) {
        cell.floorName.text = floor.floorName;
        [cell.visibilitySwitch setOn:floor.isVisible];
        cell.floor = floor;
    }
    
    return cell;
}


#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark IBAction

@end
