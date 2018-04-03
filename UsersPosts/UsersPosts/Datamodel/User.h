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

@interface User : NSObject
@property (nonatomic, readonly, nonnull) NSString *userID;
@property (nonatomic, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSString *username;
@property (nonatomic, readonly, nonnull) NSString *email;
@property (nonatomic, readonly, nonnull) Address *address;
@property (nonatomic, readonly, nonnull) NSString *phone;
@property (nonatomic, readonly, nonnull) NSString *website;
@property (nonatomic, readonly, nonnull) Company *company;
@property (nonatomic, readonly) NSArray <Post *> * _Nonnull posts;

+(User * _Nonnull) createUserFromJson:(NSDictionary * _Nonnull) json;
@end
