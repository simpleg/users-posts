//
//  UsersManagerTests.m
//  UsersPostsTests
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UsersManager.h"
#import "User+Internal.h"

@interface UsersManagerTests : XCTestCase
@property (nonatomic, strong) UsersManager *usersManager;
@end

@implementation UsersManagerTests

- (void)setUp {
    [super setUp];
    _usersManager = [UsersManager new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchUsers {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UsersFetched"];
    
    [_usersManager fetchUsersWithCompletionHandler:^(NSArray<User *> *users, NSError *error) {
        XCTAssertEqual(users.count, 10);
        for (User *aUser in users) {
            XCTAssertNotNil(aUser.userID);
            XCTAssertNotNil(aUser.name);
            XCTAssertNotNil(aUser.username);
            XCTAssertNotNil(aUser.email);
            XCTAssertNotNil(aUser.address);
            XCTAssertNotNil(aUser.phone);
            XCTAssertNotNil(aUser.website);
            XCTAssertNotNil(aUser.company);
        }
        if(!error){
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if(error)
            NSLog(@"Timeout Error %@", error);
    }];
}

-(void) testFetchPostsForUser1 {
    User *user1 = [User createUserFromJson:@{@"id":@"1"}];
    XCTestExpectation *expectation = [self expectationWithDescription:@"FetchPostsForUser1"];
    
    [_usersManager fetchPostsForUser:user1 completionHandler:^(User *user, NSArray<Post *> *posts, NSError *error) {
        NSLog(@"Fetch posts");
        XCTAssertEqual(user1, user);
        XCTAssertEqual(posts.count, 10);
        for (Post *post in posts) {
            XCTAssertNotNil(post.postID);
            XCTAssertNotNil(post.title);
            XCTAssertNotNil(post.body);
        }
        if(!error){
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if(error)
            NSLog(@"Timeout Error %@", error);
    }];
}

-(void) testFetchAvatarForUser1 {
    User *user1 = [User createUserFromJson:@{@"id":@"1"}];
    XCTestExpectation *expectation = [self expectationWithDescription:@"FetchAvatarForUser1"];
    
    [_usersManager fetchAvatarForUser:user1 completionHandler:^(User *user, NSData *avatarData, NSError *error) {
        NSLog(@"Fetch avatar");
        XCTAssertNotNil(avatarData);
        if(!error){
            [expectation fulfill];
        }
        
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if(error)
            NSLog(@"Timeout Error %@", error);
    }];
}


@end
