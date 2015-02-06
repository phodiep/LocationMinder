//
//  LinkedList.swift
//  LocationMinder
//
//  Created by Pho Diep on 2/6/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import Foundation

class LinkedList {
    
    var headNode: Node?
    
    init() {
        self.headNode = nil
        
    }
    
    init(headNode: Node) {
        self.headNode = headNode
    }
    
    func setHead(node: Node) {
        if self.headNode == nil {
            self.headNode = node
        } else {
            node.nextnode = self.headNode
            self.headNode = node
        }
        
    }
    
    func setTail(node: Node) {
        if self.headNode == nil {
            self.headNode = node
        } else {
            var tailNode = headNode
            while (( tailNode?.nextnode) != nil) {
                tailNode = tailNode?.nextnode
            }
            tailNode?.nextnode = node
        }
    }
    
    func setTailRecursively(currentNode: Node, newNode: Node) {
        if currentNode.nextnode != nil {
            setTailRecursively(currentNode.nextnode!, newNode: newNode)
        }
    }
    
    func getHeadNode() -> Node? {
        return self.headNode?
    }
    
    func getTailNode() -> Node? {
        var tailNode = self.headNode?
        while tailNode?.nextnode != nil {
            tailNode = tailNode?.nextnode
        }
        return tailNode
    }
    
}