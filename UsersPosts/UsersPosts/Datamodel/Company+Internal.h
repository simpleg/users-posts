//
//  Company+Internal.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 04/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "Company.h"

@interface Company (Internal)
+(Company *_Nonnull) createCompanyFromJson:(NSDictionary *_Nonnull) json;
@end
