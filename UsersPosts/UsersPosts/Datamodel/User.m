//
//  User.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "User.h"
#import "User+Internal.h"
#import "Address+Internal.h"
#import "Company+Internal.h"

@interface User ()
@property (nonatomic, readwrite, strong) NSString *userID;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *username;
@property (nonatomic, readwrite, strong) NSString *email;
@property (nonatomic, readwrite, strong) Address *address;
@property (nonatomic, readwrite, strong) NSString *phone;
@property (nonatomic, readwrite, strong) NSString *website;
@property (nonatomic, readwrite, strong) Company *company;
@property (nonatomic, readwrite, strong) NSMutableSet <Post *> *userPosts;

@end

@implementation User

-(instancetype) init {
    self = [super init];
    if(self){
        _userPosts = [NSMutableSet new];
    }
    return self;
}

+(User*) createUserFromJson:(NSDictionary *) json {
    User *user = [User new];
    user.userID = [json objectForKey:@"id"];
    user.name = [json objectForKey:@"name"];
    user.username = [json objectForKey:@"username"];
    user.email = [json objectForKey:@"email"];
    user.address = [Address createAddressFromJson:[json objectForKey:@"address"]];
    user.phone = [json objectForKey:@"phone"];
    user.website = [json objectForKey:@"website"];
    user.company = [Company createCompanyFromJson:[json objectForKey:@"company"]];
    return user;
}

-(void) setAvatarData:(NSData *)avatarData{
    _avatarData = nil;
    _avatarData = [NSData dataWithData:avatarData];
}

-(NSArray <Post *> *) posts {
    return _userPosts.allObjects;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"<User : %p %@ %@ %@ %@ %@  %@ %@>", self, _userID, _name, _username, _email, _phone, _address, _company];
}
-(void) addPost:(Post *)post {
    [_userPosts addObject:post];
}


@end
