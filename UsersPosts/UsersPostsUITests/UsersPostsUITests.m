//
//  UsersPostsUITests.m
//  UsersPostsUITests
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+JSON.h"

@interface UsersPostsUITests : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation UsersPostsUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    _app = [[XCUIApplication alloc] init];
    [_app launch];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAllUsersExists {
    XCTAssertEqual(_app.tables.cells.count, 10);
    
    NSData *usersData = [self dataForFileName:@"users"];
    NSArray *allUsers = [usersData objectFromJSONData];
    for (NSDictionary *aUser in allUsers) {
        NSString *name = [aUser objectForKey:@"name"];
        NSString *userName = [aUser objectForKey:@"username"];
        NSString *email = [aUser objectForKey:@"email"];
        NSString *phone = [aUser objectForKey:@"phone"];
        XCUIElementQuery *cell = [_app.tables.cells containingType:XCUIElementTypeStaticText identifier:name];
        XCTAssertNotNil(cell);
        XCTAssertEqualObjects(cell.staticTexts[@"name"].label, name);
        XCTAssertEqualObjects(cell.staticTexts[@"username"].label, userName);
        XCTAssertEqualObjects(cell.staticTexts[@"email"].label, email);
        XCTAssertEqualObjects(cell.staticTexts[@"phone"].label, phone);
        XCTAssert([cell.images containingType:XCUIElementTypeImage identifier:@"avatar"]);
    }
}

-(void) testAllPostsExistsForEachUsers {
    NSData *usersData = [self dataForFileName:@"users"];
    NSArray *allUsers = [usersData objectFromJSONData];
    
    NSData *postsData = [self dataForFileName:@"posts"];
    NSArray *allPosts = [postsData objectFromJSONData];
    
    XCUIElementQuery *tablesQuery = _app.tables;
    XCUIElementQuery *childrens = [tablesQuery childrenMatchingType:XCUIElementTypeCell];
    XCUIElementQuery *element = [childrens containingType:XCUIElementTypeStaticText identifier:@"name"];
    
    
    for (NSDictionary *aUser in allUsers) {
        NSString *userId = [aUser objectForKey:@"id"];
        NSString *name = [aUser objectForKey:@"name"];
        NSArray *filteredPosts = [allPosts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(userId == %ld)", userId.longLongValue]];
        [element.staticTexts[name] tap];
        XCTAssertEqualObjects(_app.navigationBars[name].identifier, name);
        XCTAssertEqual(_app.tables.cells.count, filteredPosts.count);
        for (NSDictionary *aPost in filteredPosts) {
            NSString *title = [aPost objectForKey:@"title"];
            NSString *body = [aPost objectForKey:@"body"];
            XCUIElementQuery *cell = [_app.tables.cells containingType:XCUIElementTypeStaticText identifier:title];
            XCTAssertNotNil(cell);
            XCTAssertEqualObjects(cell.staticTexts[@"title"].label, title);
            XCTAssertFalse([cell.staticTexts[@"body"].label isEqualToString:body]);
        }
        
        [_app.navigationBars[name].buttons[@"Users"] tap];
    }
}


-(NSData *) dataForFileName:(NSString *) fileName {
    NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"json"];
    return [NSData dataWithContentsOfFile:filePath];
}

@end
