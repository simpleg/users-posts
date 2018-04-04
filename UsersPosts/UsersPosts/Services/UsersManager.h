//
//  UsersManager.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

/**
 Completion block used to return users fetch on server

 @param users List of `User` fetched, `nil` in case of error
 @param error `NSError` got during fetch action, `nil` if no error
 */
typedef void (^UsersManagerFetchUsersCompletionHandler)(NSArray <User*> * _Nullable users, NSError* _Nullable error);

/**
 Completion block used to return list of `Post` fetch on server for a `User`

 @param user `User` for whom the request was made
 @param posts List of `Post` fetch for the given `User`, `nil` in case of error
 @param error `NSError` got during fetch action, `nil` if no error
 */
typedef void (^UsersManagerFetchPostsForUserCompletionHandler)(User * _Nonnull user, NSArray <Post*> * _Nullable posts, NSError * _Nullable error);

/**
 Completion block used to return the avatar data fetch on server for a `User`

 @param user `User` for whom the request was made
 @param avatarData `NSData` fetch on server for the given user, `nil` in case of error
 @param error `NSError` got during fetch action, `nil` if no error
 */
typedef void (^UsersManagerFetchAvatarForUserCompletionHandler)(User * _Nonnull user, NSData * _Nullable avatarData, NSError * _Nullable error);

/*
 Class that specialized in managing `User`
 */
@interface UsersManager : NSObject

/**
 List of fetched users
 */
@property (nonatomic, readonly) NSArray <User *>* _Nullable users;

/**
 Fetch the users list from server

 @param completionHandler block of code invoked when the operation is done
 */
-(void) fetchUsersWithCompletionHandler:(UsersManagerFetchUsersCompletionHandler _Nullable ) completionHandler;

/**
 Fetch all posts for the given user

 @param user `User` for whom the request will be made
 @param completionHandler block of code invoked when the operation is done
 */
-(void) fetchPostsForUser:(User *_Nonnull) user completionHandler:(UsersManagerFetchPostsForUserCompletionHandler _Nullable) completionHandler;

/**
 Fetch avatar on server for the given user

 @param user `User` for whom the request will be made
 @param completionHandler block of code invoked when the operation is done
 */
-(void) fetchAvatarForUser:(User *_Nonnull) user completionHandler:(UsersManagerFetchAvatarForUserCompletionHandler _Nullable) completionHandler;
@end
