//
//  Address+Internal.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 04/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "Address.h"
@interface Address (Internal)
+(Address *_Nonnull) createAddressFromJson:(NSDictionary *_Nonnull) json;
@end
