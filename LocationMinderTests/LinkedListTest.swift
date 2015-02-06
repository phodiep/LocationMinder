//
//  LinkedListTest.swift
//  LocationMinder
//
//  Created by Pho Diep on 2/6/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit
import XCTest

class LinkedListTest: XCTestCase {

    var emptyList: LinkedList!
    var fullList: LinkedList!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.emptyList = LinkedList()
        self.fullList = LinkedList(headNode: Node(data: 2))
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testAddHead() {
        XCTAssert(self.emptyList.getHeadNode()?.data == nil)
        
        self.emptyList.setHead(Node(data: 1))
        XCTAssert(self.emptyList.getHeadNode()?.data == 1)
        
        self.fullList.setHead(Node(data: 1))
        XCTAssert(self.fullList.getHeadNode()?.data == 1)
        
    }
    
    func testAddTail() {
        XCTAssert(self.emptyList.getTailNode()?.data == nil)

        self.emptyList.setTail(Node(data: 3))
        XCTAssert(self.emptyList.getTailNode()?.data == 3)

        self.fullList.setTail(Node(data: 3))
        XCTAssert(self.fullList.getTailNode()?.data == 3)
    }
    

}
