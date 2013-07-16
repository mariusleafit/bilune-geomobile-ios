//
//  InitViewController.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 09.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "InitViewController.h"
#import "Downloader.h"
#import "AppDelegate.h"
#import "Occupant.h"
#import "MainMenuViewController.h"
#import "Constants.h"


@interface InitViewController ()

@end

@implementation InitViewController

bool downloadedBuildings = false;
bool downloadedOccupants = false;
bool errorOccured = false;


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
	// Do any additional setup after loading the view.
    
    [self startDownload];
}

- (void)startDownload {
    //reset error
    errorOccured = false;
    
    //hide alertText
    self.alertText.hidden  = true;
    
    //hide retry button
    self.retryButton.hidden = true;
    
    //start loading animation
    self.loaderImage.hidden = false;
    self.loaderImage.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"loader1.tiff"],
                                        [UIImage imageNamed:@"loader2.tiff"],
                                        [UIImage imageNamed:@"loader3.tiff"],
                                        [UIImage imageNamed:@"loader4.tiff"],
                                        [UIImage imageNamed:@"loader5.tiff"],
                                        [UIImage imageNamed:@"loader6.tiff"],
                                        [UIImage imageNamed:@"loader7.tiff"],
                                        [UIImage imageNamed:@"loader8.tiff"],
                                        [UIImage imageNamed:@"loader9.tiff"],
                                        [UIImage imageNamed:@"loader10.tiff"],
                                        [UIImage imageNamed:@"loader11.tiff"],
                                        [UIImage imageNamed:@"loader12.tiff"],nil];
    self.loaderImage.animationRepeatCount = 0;
    self.loaderImage.animationDuration = 1.5;
    [self.loaderImage startAnimating];
    
    //download occupants
    Downloader *occupantsDownloader = [[Downloader alloc] initWidthDataDelegate:self andDownloadIdentifier:@"occupants"];
    
    //load content from venus server
    // Create the connection
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[Constants OCCUPANTSURL]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:[Constants DOWNLOADTIMEOUT]];
    
    // Send an asyncronous request on the queue
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:occupantsDownloader];
    [connection start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DownloadDataDelegste

-(void)finishedLoadingData:(NSDictionary *)data andDownloadIdentifier:(NSString *)identifier {
    
    //downloads
    AppDelegate *delegate = GetAppDelegate();
    delegate.occupants = [NSMutableArray arrayWithCapacity:1000];
    
    //occupants download
    if([identifier isEqual: @"occupants"]) {
        for(NSDictionary *item in data) {
            [delegate.occupants addObject:[Occupant occupantWidthDictionary:item]];
        }
        downloadedOccupants = true;
        /*for(Occupant *item in delegate.occupants) {
            NSLog(@"%@", item.locTypeDesignation);
        }*/
    }
    
    //building  data download
    
    
    //stop loading animation
    if(!errorOccured && downloadedOccupants /*&& downloadedBuildings*/) {
        [self.loaderImage stopAnimating];
        //show main menu
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiluneGeoMobile" bundle:nil];
        MainMenuViewController *viewController = (MainMenuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
        [self presentViewController:viewController animated:NO completion:nil];
    }
}


-(void)didFailWidthError:(NSError *)error andDownloadIdentifier:(NSString *)identifier{
    errorOccured = true;
    [self.loaderImage stopAnimating];
    self.loaderImage.hidden = true;
    self.alertText.hidden = false;
    self.retryButton.hidden = false;
}

#pragma mark IBActions
- (IBAction)retryDownload:(id)sender {
    [self startDownload];
}
@end
