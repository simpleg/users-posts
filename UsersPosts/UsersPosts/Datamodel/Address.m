//
//  Address.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "Address.h"

@interface Address ()
@property (nonatomic, readwrite, strong) NSString *street;
@property (nonatomic, readwrite, strong) NSString *suite;
@property (nonatomic, readwrite, strong) NSString *city;
@property (nonatomic, readwrite, strong) NSString *zipCode;
@property (nonatomic, readwrite, strong) CLLocation *location;
@end

@implementation Address
+(Address *) createAddressFromJson:(NSDictionary *) json {
    Address *address = [Address new];
    address.street = [json objectForKey:@"street"];
    address.suite = [json objectForKey:@"suite"];
    address.city = [json objectForKey:@"city"];
    address.zipCode = [json objectForKey:@"zipcode"];
    NSString *latitude = [[json objectForKey:@"geo"] objectForKey:@"lat"];
    NSString *longitude = [[json objectForKey:@"geo"] objectForKey:@"lng"];
    address.location = [[CLLocation alloc] initWithLatitude:latitude.doubleValue longitude:longitude.doubleValue];
    
    return address;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"<Address %p %@ %@ %@ %@ %@>",self, _street, _suite, _zipCode, _city, _location];
}
@end
