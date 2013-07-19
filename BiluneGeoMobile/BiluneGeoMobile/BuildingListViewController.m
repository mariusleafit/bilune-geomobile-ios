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

@interface BuildingListViewController ()
@property (weak) AppDelegate *appDelegate;
@end

@implementation BuildingListViewController

@synthesize appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = GetAppDelegate();
	
    for(Building *b in [appDelegate.buildingstack getBuildings]) {
        NSLog(b.mapName);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBAction
- (IBAction)returnToMenu:(id)sender {
    //show SearchOccupants
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    BuildingListViewController *viewController = (BuildingListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
