//
//  MainMenuViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SearchOccupantsViewController.h"
#import "BuildingListViewController.h"
#import <ArcGIS/ArcGIS.h>
#import "MapViewController.h"

@interface MainMenuViewController ()
@property (weak) AppDelegate *appDelegate;
@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = GetAppDelegate();
    
	// Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"UNINE"];
    self.navigationItem.hidesBackButton = true;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark IBAction

- (IBAction)showSearchOccupants:(id)sender {
    //show SearchOccupants
    [self.appDelegate.navigationController pushViewController:[[SearchOccupantsViewController alloc] initWithNibName:@"SearchOccupants" bundle:nil] animated:YES];
}

- (IBAction)showBuildingList:(id)sender {
    //show SearchOccupants
     [self.appDelegate.navigationController pushViewController:[[BuildingListViewController alloc] initWithNibName:@"BuildingList" bundle:nil] animated:YES];
}

- (IBAction)showMap:(id)sender {
    [self.appDelegate.navigationController pushViewController:[[MapViewController alloc] initWithNibName:@"Map" bundle:nil] animated:YES];
}
@end
