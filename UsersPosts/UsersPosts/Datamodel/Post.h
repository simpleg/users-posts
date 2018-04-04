//
//  Post.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class that represents an inmutable value of object for post properties, such as title, body
 */
@interface Post : NSObject
/**
 Unique identifier of the post
 */
@property (nonatomic, readonly, nonnull) NSString *postID;
/**
 Title of the post
 */
@property (nonatomic, readonly, nonnull) NSString *title;
/**
 Boby of the post
 */
@property (nonatomic, readonly, nonnull) NSString *body;
@end
