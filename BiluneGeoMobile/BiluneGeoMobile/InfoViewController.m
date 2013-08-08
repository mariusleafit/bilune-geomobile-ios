//
//  InfoViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
	
    //hide devInfo and show appInfo
    self.devInfoContainer.hidden = true;
    self.appInfoContainer.hidden = false;
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

- (IBAction)returnToMap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)changeInfoPage:(id)sender {
    if(self.devInfoContainer.hidden) {
        self.devInfoContainer.hidden = false;
        self.appInfoContainer.hidden = true;
    } else {
        self.devInfoContainer.hidden = true;
        self.appInfoContainer.hidden = false;
    }
}
@end
