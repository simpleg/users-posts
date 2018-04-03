//
//  UsersManager.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "UsersManager.h"
#import "NSData+JSON.h"
#import "NetworkManager.h"
#import "User+Internal.h"

@interface UsersManager ()
@property (nonatomic, strong) NSMutableSet <User *> *usersList;
@property (nonatomic, strong) NetworkManager *networkManager;
@end

@implementation UsersManager
-(instancetype) init {
    self = [super init];
    if(self){
        _usersList = [NSMutableSet new];
        _networkManager = [[NetworkManager alloc] init];
    }
    return self;
}

-(void) dealloc {
    [_usersList removeAllObjects];
    _usersList = nil;
    _networkManager = nil;
}

-(NSArray <User *>*) users {
    return _usersList.allObjects;
}

-(void) fetchUsersWithCompletionHandler:(UsersManagerFetchUsersCompletionHandler) completionHandler {
    [_networkManager performGetRequestWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/users"] completionBlock:^(NSData *receivedData, NSError *error, NSURLResponse *response) {
        NSLog(@"Fetch users answer %@", error);
        if(error){
            NSLog(@"Error while fetching users %@", error);
            if(completionHandler)
                completionHandler(nil, error);
            return;
        }
        
        NSArray *users = [receivedData objectFromJSONData];
        for (NSDictionary *aUser in users) {
            User *user = [User createUserFromJson:aUser];
            [_usersList addObject:user];
        }
        
        if(completionHandler)
            completionHandler(self.users, error);
    }];
}

-(void) fetchAvatarForUser:(User *) user completionHandler:(UsersManagerFetchAvatarForUserCompletionHandler) completionHandler {
    __weak typeof(user) weakUser = user;
    [_networkManager performGetRequestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/photos?id=%@", user.userID]] completionBlock:^(NSData *receivedData, NSError *error, NSURLResponse *response) {
        NSLog(@"Fetch avatar info for user answer %@", error);
        if(error){
            NSLog(@"Error while fetching avatar info for users %@", error);
            if(completionHandler)
                completionHandler(weakUser , nil, error);
            return;
        }
        
        NSArray *avatarInfos = [receivedData objectFromJSONData];
        for (NSDictionary *avatarInfo in avatarInfos) {
            NSString *avatarURL = [avatarInfo objectForKey:@"thumbnailUrl"];
            // given url are not in HTTPS, avoid disabling ats policy
            NSURL *url = [NSURL URLWithString:[avatarURL stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"]];
            [_networkManager performGetRequestWithURL:url completionBlock:^(NSData *receivedData, NSError *error, NSURLResponse *response) {
                if(error){
                    NSLog(@"Error while fetching avatar for users %@", error);
                    if(completionHandler)
                        completionHandler(weakUser , nil, error);
                    return;
                }
                [weakUser addAvatarData:receivedData];
                if(completionHandler)
                    completionHandler(weakUser, weakUser.avatarData, error);
            }];
        }
    }];
}

-(void) fetchPostsForUser:(User *) user completionHandler:(UsersManagerFetchPostsForUserCompletionHandler) completionHandler {
    [_networkManager performGetRequestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/posts?userId=%@", user.userID]] completionBlock:^(NSData *receivedData, NSError *error, NSURLResponse *response) {
        NSLog(@"Fetch posts for user answer %@", error);
        if(error){
            NSLog(@"Error while fetching posts for users %@", error);
            if(completionHandler)
                completionHandler(user , nil, error);
            return;
        }
        
        NSArray *posts = [receivedData objectFromJSONData];
        for (NSDictionary *aPost in posts) {
            Post *post = [Post createPostFromJson:aPost];
            [user addPost:post];
        }
        if(completionHandler)
            completionHandler(user, user.posts, error);
    }];
}

@end
