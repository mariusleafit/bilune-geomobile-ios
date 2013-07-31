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
    static NSString *cellIdentifier = @"ChangeFloorCell";
    
    //get cell
    ChangeFloorListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ChangeFloorListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //get Floor
    Floor *floor = [[building getFloorsSortedAsc:YES] objectAtIndex:indexPath.row];
    if(floor) {
        cell.floorName.text = floor.floorName;
        [cell.visibilitySwitch setOn:floor.isVisible];
    }
    
    return cell;
}


#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)returnToCarte:(id)sender {
}
- (IBAction)returnToMap:(id)sender {
}
@end
