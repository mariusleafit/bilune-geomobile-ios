//
//  InfoViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 04.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
- (IBAction)returnToMap:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *devInfoContainer;
@property (weak, nonatomic) IBOutlet UIView *appInfoContainer;
- (IBAction)changeInfoPage:(id)sender;

@end
