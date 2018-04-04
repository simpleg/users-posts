//
//  User.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "Company.h"
#import "Post.h"

/**
 Class that represent inmutable value object for user properties, such as name, username
 */
@interface User : NSObject

/**
 Unique user identifier
 */
@property (nonatomic, readonly, nonnull) NSString *userID;
/**
 Name of the user
 */
@property (nonatomic, readonly, nonnull) NSString *name;
/**
 Username of the user
 */
@property (nonatomic, readonly, nonnull) NSString *username;
/**
 Email of the user
 */
@property (nonatomic, readonly, nonnull) NSString *email;
/**
 `Address` of the User
 */
@property (nonatomic, readonly, nonnull) Address *address;
/**
 Phone of the User
 */
@property (nonatomic, readonly, nonnull) NSString *phone;
/**
 WebSite of the User
 */
@property (nonatomic, readonly, nonnull) NSString *website;
/**
 `Company` of the User
 */
@property (nonatomic, readonly, nonnull) Company *company;
/**
 List of `Post` of the User
 */
@property (nonatomic, readonly, nullable) NSArray <Post *> * posts;
/**
 `NSData`representing the avatar of the user
 */
@property (nonatomic, readonly, nullable) NSData *avatarData;
@end
