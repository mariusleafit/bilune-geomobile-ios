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

@interface RoomListViewController ()
@property (weak) AppDelegate *appDelegate;
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
	// prepare View
    if([currentFloor.parentBuilding getImage]){
        [self.buildingImage setImage:[currentFloor.parentBuilding getImage]];
    }
    
    self.buildingAddress.text = currentFloor.parentBuilding.address;
    
    self.floorName.text = currentFloor.floorName;
    
    //load Rooms from currentFloor
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setFloor:(Floor *)pFloor {
    currentFloor = pFloor;
}

#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark IBAction
- (IBAction)returnToEtages:(id)sender {
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    FloorListViewController *viewController = (FloorListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FloorListView"];
    [viewController setBuilding:currentFloor.parentBuilding];
    [self presentViewController:viewController animated:YES completion:nil];*/
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
