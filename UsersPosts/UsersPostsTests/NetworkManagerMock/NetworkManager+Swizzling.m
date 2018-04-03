//
//  NetworkManager+Swizzling.m
//  UsersPostsTests
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "NetworkManager.h"
#import "NSData+JSON.h"
#import <UIKit/UIKit.h>

@implementation NetworkManager (Swizzling)
+(void) load {
    [NetworkManager swizzle_method:@selector(performGetRequestWithURL:completionBlock:) with:@selector(swizzled_performGetRequestWithURL:completionBlock:)];
}

+(void) swizzle_method:(SEL) originalSelector with:(SEL) overridedSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method overrideMethod = class_getInstanceMethod(self, overridedSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(self, overridedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

-(NSURLSessionDownloadTask *) swizzled_performGetRequestWithURL:(NSURL *) url completionBlock:(NetworkManagerCompletionHandler) completionHandler {
    // Parse the url and find the good file to return
    NSLog(@"URL %@", url.pathComponents);
    NSData *dataToReturn = nil;
    if([url.pathComponents containsObject:@"users"]){
        // return the users.json data
         dataToReturn = [self dataForFileName:@"users"];
        
    }
    if([url.pathComponents containsObject:@"posts"]){
        // Check if there is a query
        NSURLQueryItem *item = [self containsQueryItem:@"userId" fromURL:url];
        if(item){
            NSString *userID = item.value;
            NSData *data = [self dataForFileName:@"posts"];
            NSArray *allPosts = [data objectFromJSONData];
            if(userID){
            NSArray *filteredPosts = [allPosts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(userId == %ld)", userID.longLongValue]];
                dataToReturn = [NSData dataFromObject:filteredPosts]; 
            } else {
                dataToReturn = [NSData dataFromObject:allPosts];
            }
        }
    }
    
    if([url.pathComponents containsObject:@"photos"]){
        NSURLQueryItem *specificIdItem = [self containsQueryItem:@"id" fromURL:url];
        NSString *specificId = specificIdItem.value;
        NSData *data = [self dataForFileName:@"photos"];
        NSArray *allPhotos = [data objectFromJSONData];
        if(specificIdItem){
            NSArray *filteredPhotos = [allPhotos filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %ld)",specificId.longLongValue]];
            dataToReturn = [NSData dataFromObject:filteredPhotos];
        } else {
            dataToReturn = data;
        }
    }
    
    if([url.absoluteString containsString:@"placehold.it"]){
        // Return a fake image data for the asked size
        NSString *readSize = [url.pathComponents objectAtIndex:1];
        CGSize size = CGSizeMake(readSize.intValue, readSize.intValue);
        UIGraphicsBeginImageContextWithOptions(size, NO, 1);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [UIColor colorWithHue:drand48() saturation:1.0 brightness:1.0 alpha:1.0].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        
        UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dataToReturn = UIImagePNGRepresentation(snapshot);
    }
    
    if(completionHandler)
        completionHandler(dataToReturn, nil, nil);
    return nil;
}

-(NSData *) dataForFileName:(NSString *) fileName {
    NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"json"];
    return [NSData dataWithContentsOfFile:filePath];
}

- (NSURLQueryItem *)containsQueryItem:(NSString *)key fromURL:(NSURL *)url {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray *queryItems = urlComponents.queryItems;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", key];
    NSURLQueryItem *queryItem = [[queryItems filteredArrayUsingPredicate:predicate] firstObject];
    return queryItem;
}

@end
