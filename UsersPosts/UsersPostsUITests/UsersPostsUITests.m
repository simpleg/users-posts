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
        XCTAssertEqualObjects(cell.staticTexts[@"name"].value, name);
        XCTAssertEqualObjects(cell.staticTexts[@"username"].value, userName);
        XCTAssertEqualObjects(cell.staticTexts[@"email"].value, email);
        XCTAssertEqualObjects(cell.staticTexts[@"phone"].value, phone);
    }
}

-(void) testOpenPostsOfUserLeanneGraham {
    XCUIElementQuery *tablesQuery = _app.tables;
    XCUIElementQuery *childrens = [tablesQuery childrenMatchingType:XCUIElementTypeCell];
    XCUIElementQuery *element = [childrens containingType:XCUIElementTypeStaticText identifier:@"name"];
    [element.staticTexts[@"Leanne Graham"] tap];
    
    
    
    
//
//    XCUIElementQuery *tablesQuery = [[XCUIApplication alloc] init].tables;
//    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:4].staticTexts[@"phoneNumber"] swipeUp];
//    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:9].staticTexts[@"name"] tap];
    
    
}


-(NSData *) dataForFileName:(NSString *) fileName {
    NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"json"];
    return [NSData dataWithContentsOfFile:filePath];
}

@end
