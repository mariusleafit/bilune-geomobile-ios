//
//  BuildingListViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "BuildingListViewController.h"

@interface BuildingListViewController ()

@end

@implementation BuildingListViewController

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

#pragma mark IBAction
- (IBAction)returnToMenu:(id)sender {
    //show SearchOccupants
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
    BuildingListViewController *viewController = (BuildingListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
