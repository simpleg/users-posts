//
//  Address.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Address : NSObject
@property (nonatomic, readonly, nonnull) NSString *street;
@property (nonatomic, readonly, nonnull) NSString *suite;
@property (nonatomic, readonly, nonnull) NSString *city;
@property (nonatomic, readonly, nonnull) NSString *zipCode;
@property (nonatomic, readonly, nonnull) CLLocation *location;

@end
