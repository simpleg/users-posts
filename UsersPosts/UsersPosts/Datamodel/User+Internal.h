//
//  User+Internal.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//
#import "User.h"

@interface User (PrivateMethods)
-(void) addPost:(Post *) post;
@end
