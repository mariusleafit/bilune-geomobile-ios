//
//  Downloader.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 09.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloaderDataDelegate.h"

@interface Downloader : NSObject <NSURLConnectionDelegate>

@property id downloadedData;
@property NSMutableData *responseData;
@property (nonatomic, weak)id<DownloaderDataDelegate> dataDelegate;
@property (nonatomic) NSString *downloadIdentifier;

-(id) initWidthDataDelegate:(id<DownloaderDataDelegate>) dataDelegate andDownloadIdentifier:(NSString *)identifier;
@end
