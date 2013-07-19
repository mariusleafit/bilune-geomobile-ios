//
//  DownloadQueue.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 18.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Downloader.h"
#import "DownloaderDelegate.h"

@interface DownloadQueue : NSObject <DownloaderDelegate>
-(void)addDownloader:(Downloader *)downloader;
-(void)start;
@end
