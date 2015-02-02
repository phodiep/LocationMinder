//
//  StackTests.m
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Stack.h"

@interface StackTests : XCTestCase

@property Stack *emptyStack;
@property Stack *fullStack;

@end

@implementation StackTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    self.emptyStack = [Stack new];
    NSMutableArray *fullArray = [NSMutableArray arrayWithArray:@[@"a",@"b"]];
    self.fullStack = [[Stack alloc] initWithArray: fullArray];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)testInit {
    XCTAssertEqual([self.emptyStack size], 0);
    XCTAssertEqual([self.fullStack size], 2);
}

- (void)testPush {
    XCTAssertEqual([self.fullStack size], 2);
    [self.fullStack push:@"c"];
    XCTAssertEqual([self.fullStack size], 3);
}

- (void)testPop {
    XCTAssertEqual([self.fullStack size], 2);
    XCTAssertEqual([self.fullStack pop], @"b");
    XCTAssertEqual([self.fullStack size], 1);

    XCTAssertNil([self.emptyStack pop]);
}

- (void)testPeek {
    [self.fullStack push:@"c"];
    XCTAssertEqual([self.fullStack size], 3);
    XCTAssertEqual([self.fullStack peek], @"c");
    XCTAssertEqual([self.fullStack size], 3);
}



@end
