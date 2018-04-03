//
//  Company.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
@property (nonatomic, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSString *slogan;
@property (nonatomic, readonly, nonnull) NSString *business;
+(Company *_Nonnull) createCompanyFromJson:(NSDictionary *_Nonnull) json;
@end
