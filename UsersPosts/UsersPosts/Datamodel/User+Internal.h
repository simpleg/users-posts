//
//  User+Internal.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//
#import "User.h"

@interface User (PrivateMethods)
@property (nonatomic, readwrite, strong) NSData * _Nonnull avatarData;
-(void) addPost:(Post *_Nonnull) post;
+(User * _Nonnull) createUserFromJson:(NSDictionary * _Nonnull) json;
@end
