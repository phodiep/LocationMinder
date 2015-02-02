//
//  Queue.m
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Queue.h"

@interface Queue()

@property (strong, nonatomic) NSMutableArray* items;

@end


@implementation Queue

-(instancetype) initWithArray:(NSMutableArray*) items {
    if (self = [super init]) {
        self.items = items;
    }
    return self;
}

-(void) enqueue: (NSObject*) item {
    [self.items addObject:item];
}

-(NSObject*) dequeue {
    if ([self.items count] > 0) {
        NSObject* item = [self.items firstObject];
        [self.items removeObjectAtIndex:0];
        return item;
    }
    return nil;
}

-(NSInteger) size {
    return [self.items count];
}

@end
