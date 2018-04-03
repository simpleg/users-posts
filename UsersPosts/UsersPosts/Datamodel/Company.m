//
//  Company.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "Company.h"
@interface Company ()
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *slogan;
@property (nonatomic, readwrite, strong) NSString *business;
@end

@implementation Company
+(Company *) createCompanyFromJson:(NSDictionary *) json {
    Company *company = [Company new];
    company.name = [json objectForKey:@"name"];
    company.slogan = [json objectForKey:@"catchPhrase"];
    company.business = [json objectForKey:@"bs"];
    return company;
}


-(NSString *) description {
    return [NSString stringWithFormat:@"<Company %p %@ %@ %@>", self, _name, _slogan, _business];
}
@end
