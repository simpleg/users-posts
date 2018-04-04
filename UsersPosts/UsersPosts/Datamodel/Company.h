//
//  Company.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class that represents an inmutable value object for company properties, such as name, slogan
 */
@interface Company : NSObject
/**
 Name of the company
 */
@property (nonatomic, readonly, nonnull) NSString *name;
/**
 Slogan of the company
 */
@property (nonatomic, readonly, nonnull) NSString *slogan;
/**
 Business description of company
 */
@property (nonatomic, readonly, nonnull) NSString *business;
@end
