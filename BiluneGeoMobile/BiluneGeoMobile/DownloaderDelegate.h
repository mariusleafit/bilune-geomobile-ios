//
//  DownloaderDataUserDelegate.h
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 10.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloaderDelegate <NSObject>

-(void)finishedLoadingData:(NSDictionary *)data andDownloadIdentifier:(NSString *)identifier;
-(void)didFailWidthError:(NSError *)error andDownloadIdentifier:(NSString *)identifier;

@end
