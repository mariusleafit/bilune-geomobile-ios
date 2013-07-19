//
//  Downloader.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 09.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloaderDelegate.h"

@interface Downloader : NSObject <NSURLConnectionDelegate>

@property (nonatomic)NSMutableArray *delegates;
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSURL *downloadUrl;

-(id) initWidthDelegate:(id<DownloaderDelegate>) delegate identifier:(NSString *)pIdentifier url:(NSURL *)url;
-(void) addDelegate:(id<DownloaderDelegate>) delegate;
-(void) start;
@end