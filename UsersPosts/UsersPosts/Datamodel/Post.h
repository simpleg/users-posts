//
//  Post.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (nonatomic, readonly, nonnull) NSString *postID;
@property (nonatomic, readonly, nonnull) NSString *title;
@property (nonatomic, readonly, nonnull) NSString *body;

+(Post *_Nonnull) createPostFromJson:(NSDictionary *_Nonnull) json;
@end
