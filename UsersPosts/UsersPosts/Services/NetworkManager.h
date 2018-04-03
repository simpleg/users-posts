//
//  NetworkManager.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NetworkManagerCompletionHandler)(NSData *receivedData, NSError *error, NSURLResponse *response);
@interface NetworkManager : NSObject
-(NSURLSessionUploadTask *) performGetRequestWithURL:(NSURL *) url completionBlock:(NetworkManagerCompletionHandler) completionHandler;

@end
