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
#import "DownloadQueue.h"
#import "LegendEntry.h"


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
    [self setTitle:@"UNINE"];
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
    
    //download
    // create the DownloadQueue
    DownloadQueue *downloadQueue = [[DownloadQueue alloc] init];
    
    //download occupants
    Downloader *occupantsDownloader = [[Downloader alloc] initWithDelegate:self identifier:@"occupants" url:[NSURL URLWithString:[Constants OCCUPANTSURL]]];
    
    Downloader *buildingsDownloader = [[Downloader alloc] initWithDelegate:self identifier:@"buildings" url:[NSURL URLWithString:[Constants BUILDINGSURL]]];
    
    [downloadQueue addDownloader:occupantsDownloader];
    [downloadQueue addDownloader:buildingsDownloader];
    
    [downloadQueue start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DownloadDataDelegste

-(void)finishedLoadingData:(NSDictionary *)data andDownloadIdentifier:(NSString *)identifier {
    if(!errorOccured) {
        //downloads
        AppDelegate *delegate = GetAppDelegate();
        
        
        //occupants download
        if([identifier isEqual: @"occupants"] && data != nil) {
            delegate.occupants = [NSMutableArray arrayWithCapacity:1000];
            for(NSDictionary *item in data) {
                [delegate.occupants addObject:[Occupant occupantWithDictionary:item]];
            }
            downloadedOccupants = true;
        }

        //building  data download
        if([identifier isEqual: @"buildings"] && data != nil) {
            //parse building
            NSDictionary *buildingsDict = [data valueForKey:@"Buildings"];
            if(buildingsDict != nil) {
                delegate.buildingstack = [BuildingStack createWithData:buildingsDict];
            }
            
            //parse Legend
            delegate.legendEntries = [NSMutableArray arrayWithCapacity:30];
            NSDictionary *legendDict = (NSDictionary *)[data valueForKey:@"Legend"];
            for (NSDictionary *legendEntryDict in legendDict) {
                [delegate.legendEntries addObject:[[LegendEntry alloc] initWithDictionary:legendEntryDict]];
            }
            
            
            downloadedBuildings = true;
        }
        
        //stop loading animation
        if(!errorOccured && downloadedOccupants && downloadedBuildings) {
            [self.loaderImage stopAnimating];
            //show main menu
            [delegate.navigationController pushViewController:[[MainMenuViewController alloc] initWithNibName:@"MainMenu" bundle:nil] animated:NO];
        }
    }
}


-(void)didFailWithError:(NSError *)error andDownloadIdentifier:(NSString *)identifier{
    errorOccured = true;
    [self.loaderImage stopAnimating];
    self.loaderImage.hidden = true;
    self.alertText.hidden = false;
    self.retryButton.hidden = false;
}

#pragma mark DeviceOrientation
-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark IBActions
- (IBAction)retryDownload:(id)sender {
    [self startDownload];
}
@end
