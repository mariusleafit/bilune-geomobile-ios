//
//  DownloadQueue.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 18.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "DownloadQueue.h"

@interface DownloadQueue()
@property NSMutableArray *downloaders;
@property NSMutableDictionary *schedule;
@end

@implementation DownloadQueue

@synthesize downloaders;

-(id)init {
    self = [super init];
    if(self) {
        self.downloaders = [[NSMutableArray alloc] init];
        self.schedule = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)addDownloader:(Downloader *)downloader {
    [self.schedule setValue:[NSNumber numberWithBool:NO] forKey:downloader.identifier];
    [self.downloaders addObject:downloader];
    [downloader addDelegate:self];
}

-(void)start {
    [self startDownloaderWithID:0];
}

-(void)startDownloaderWithID:(int) downloaderID{
    Downloader *tmpDownloader = self.downloaders[downloaderID];
    if(tmpDownloader != nil) {
        if([(NSNumber *)[self.schedule valueForKey:tmpDownloader.identifier] isEqual:[NSNumber numberWithBool:NO]]) {
            [self.schedule setValue:[NSNumber numberWithBool:YES] forKey:tmpDownloader.identifier];
            [tmpDownloader start];
        }
    }
}

///starts next download in schedule
-(void)startNextDownload {
    int i = 0;
    BOOL started = false;
    while(!started && i < [self.downloaders count]) {
        Downloader *tmpDownloader = self.downloaders[i];
        if([(NSNumber *)[self.schedule valueForKey:tmpDownloader.identifier] isEqual:[NSNumber numberWithBool:NO]]) {
            started = true;
            [self startDownloaderWithID:i];
        }
        i++;
    }
}

#pragma mark DownloaderDelegate
-(void)finishedLoadingData:(NSDictionary *)data andDownloadIdentifier:(NSString *)identifier {
    [self startNextDownload];
}

-(void)didFailWidthError:(NSError *)error andDownloadIdentifier:(NSString *)identifier {
    [self startNextDownload];
}
@end
