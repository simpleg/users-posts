//
//  Post.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "Post.h"

@interface Post ()
@property (nonatomic, readwrite, strong) NSString *postID;
@property (nonatomic, readwrite, strong) NSString *title;
@property (nonatomic, readwrite, strong) NSString *body;
@end

@implementation Post
+(Post *) createPostFromJson:(NSDictionary *) json {
    Post *post = [Post new];
    post.postID = [json objectForKey:@"id"];
    post.title = [json objectForKey:@"title"];
    post.body = [json objectForKey:@"body"];
    return post;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"<Post %p %@ %@>", self, _title, _body];
}
@end
