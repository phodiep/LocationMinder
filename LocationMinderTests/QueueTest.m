//
//  QueueTest.m
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Queue.h"

@interface QueueTest : XCTestCase

@property Queue *emptyQueue;
@property Queue *fullQueue;

@end

@implementation QueueTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.emptyQueue = [Queue new];
    NSMutableArray *fullArray = [NSMutableArray arrayWithArray:@[@"a",@"b"]];
    self.fullQueue = [[Queue alloc]initWithArray:fullArray];
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


- (void) testInit {
    XCTAssertEqual([self.emptyQueue size], 0);
    XCTAssertEqual([self.fullQueue size], 2);
}

- (void) testEnqueue {
    XCTAssertEqual([self.fullQueue size], 2);
    [self.fullQueue enqueue:@"c"];
    XCTAssertEqual([self.fullQueue size], 3);
}

- (void) testDequeue {
    XCTAssertEqual([self.fullQueue size], 2);
    XCTAssertEqual([self.fullQueue dequeue], @"a");
    XCTAssertEqual([self.fullQueue size], 1);
    
    XCTAssertNil([self.emptyQueue dequeue]);
}

@end
