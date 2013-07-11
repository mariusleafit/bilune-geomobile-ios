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


@interface InitViewController ()

@end

@implementation InitViewController


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
    
    Downloader *occupantsDownloader = [[Downloader alloc] initWidthDataDelegate:self andDownloadIdentifier:@"occupants"];
    
    //load content from venus server
    // Create the connection
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://biluneapp.unine.ch/IGeomobileAccessServices/occupants"]];
    
    
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
    
    AppDelegate *delegate = GetAppDelegate();
    delegate.occupants = [NSMutableArray arrayWithCapacity:1000];
    
    NSLog(@"%@",identifier);
    if([identifier isEqual: @"occupants"]) {
        for(NSDictionary *item in data) {
            [delegate.occupants addObject:[Occupant occupantWidthDictionary:item]];
        }
        
        /*for(Occupant *item in delegate.occupants) {
            NSLog(@"%@", item.locTypeDesignation);
        }*/
    }
}


-(void)didFailWidthError:(NSError *)error andDownloadIdentifier:(NSString *)identifier{
    NSLog(@"Error");
}
@end
