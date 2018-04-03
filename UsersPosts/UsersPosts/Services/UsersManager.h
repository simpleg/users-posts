//
//  UsersManager.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
typedef void (^UsersManagerFetchUsersCompletionHandler)(NSArray <User*> *users, NSError *error);
typedef void (^UsersManagerFetchPostsForUserCompletionHandler)(User *user, NSArray <Post*> *posts, NSError *error);

@interface UsersManager : NSObject
@property (nonatomic, readonly) NSArray <User *>* users;
-(void) fetchUsersWithCompletionHandler:(UsersManagerFetchUsersCompletionHandler) completionHandler;
-(void) fetchPostsForUser:(User *) user completionHandler:(UsersManagerFetchPostsForUserCompletionHandler) completionHandler;
@end
