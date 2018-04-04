//
//  Post+Internal.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 04/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "Post.h"

@interface Post (Internal)
+(Post *_Nonnull) createPostFromJson:(NSDictionary *_Nonnull) json;
@end
