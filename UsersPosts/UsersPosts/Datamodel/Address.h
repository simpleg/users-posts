//
//  Address.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 Class that represent an inmutable value of object for address properties, such as street, city, zipCode
 */
@interface Address : NSObject
/**
 Street of the address
 */
@property (nonatomic, readonly, nonnull) NSString *street;
/**
 Suite of the address
 */
@property (nonatomic, readonly, nonnull) NSString *suite;
/**
 City of the address
 */
@property (nonatomic, readonly, nonnull) NSString *city;
/**
 Zip code of the address
 */
@property (nonatomic, readonly, nonnull) NSString *zipCode;
/**
 `CLLocation` of the address
 */
@property (nonatomic, readonly, nonnull) CLLocation *location;

@end
