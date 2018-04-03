//
//  NetworkManager.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager () <NSURLSessionDelegate>
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation NetworkManager

-(instancetype) init {
    self = [super init];
    if(self){
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        __weak typeof(self) weakSelf = self;
        _session = [NSURLSession sessionWithConfiguration:config delegate:weakSelf delegateQueue:nil];
    }
    return self;
}

-(void) dealloc {
    _session = nil;
}

-(NSURLSessionDownloadTask *) performGetRequestWithURL:(NSURL *) url completionBlock:(NetworkManagerCompletionHandler) completionHandler {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    NSURLSessionDownloadTask *downloadTask = [_session downloadTaskWithRequest:request completionHandler:^(NSURL * location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        if(completionHandler)
            completionHandler(data, error, response);
    }];
    
    [downloadTask resume];
    return downloadTask;
}
@end
