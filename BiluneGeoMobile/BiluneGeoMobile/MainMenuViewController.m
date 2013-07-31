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

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    SearchOccupantsViewController *viewController = (SearchOccupantsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SearchOccupants"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)showBuildingList:(id)sender {
    //show SearchOccupants
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    BuildingListViewController *viewController = (BuildingListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BuildingList"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)showMap:(id)sender {
    //show SearchOccupants
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Map"];
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
