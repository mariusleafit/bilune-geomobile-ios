//
//  Downloader.m
//  BiluneGeoMobile
//
//  Created by Marius Gächter on 09.07.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "Downloader.h"
#import "Constants.h"


@interface Downloader()
@property NSMutableData *responseData;

@end
///abstract class
@implementation Downloader

@synthesize delegates;
@synthesize downloadUrl;
@synthesize identifier;
@synthesize responseData;

-(id) initWidthDelegate:(id<DownloaderDelegate>) delegate identifier:(NSString *)pIdentifier url:(NSURL *)url{
    self = [super init];
    if(self) {
        self.delegates = [[NSMutableArray alloc] init];
        [self addDelegate:delegate];
        self.identifier = pIdentifier;
        self.downloadUrl = url;
    }
    
    return(self);
}

-(void)addDelegate:(id<DownloaderDelegate>)delegate {
    [delegates addObject:delegate];
}

-(void)start {
    //download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.downloadUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:[Constants DOWNLOADTIMEOUT]];
    
    // Send an asyncronous request
    NSURLConnection* occupantsConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    [occupantsConnection start];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSError* jsonError;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
    
    responseData = nil;
    
    // If there was an error decoding the JSON
    if (jsonError) {
        for(id<DownloaderDelegate> delegate in self.delegates) {
            [delegate didFailWidthError:nil andDownloadIdentifier:self.identifier];
        } 
    }
    
    for(id<DownloaderDelegate> delegate in self.delegates) {
        [delegate finishedLoadingData:responseDict andDownloadIdentifier:self.identifier];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    for(id<DownloaderDelegate> delegate in self.delegates) {
        [delegate didFailWidthError:error andDownloadIdentifier:identifier];
    }
}


#pragma mark Handle SSL
// Accept Self Signed SSL Cert
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
