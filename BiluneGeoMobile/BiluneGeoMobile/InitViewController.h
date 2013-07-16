//
//  InitViewController.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 09.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloaderDataDelegate.h"

@interface InitViewController : UIViewController<DownloaderDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *loaderImage;
@property (weak, nonatomic) IBOutlet UILabel *alertText;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;
- (IBAction)retryDownload:(id)sender;

@end
