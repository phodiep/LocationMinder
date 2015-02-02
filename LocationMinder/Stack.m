//
//  Stack.m
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Stack.h"

@interface Stack()

@property (strong, nonatomic) NSMutableArray* items;

@end

@implementation Stack

-(instancetype) initWithArray:(NSMutableArray*) items {
    if (self = [super init]) {
        self.items = items;
    }
    return self;
}

-(void) push:(NSObject*) item {
    [self.items addObject:item];
}

-(NSObject*) pop {
    if ([self.items count] > 0) {
        NSObject* item = [self.items lastObject];
        [self.items removeLastObject];
        return item;
    }
    return nil;
}

-(NSObject*) peek {
    return [self.items lastObject];
}

-(NSInteger) size {
    return [self.items count];
}



@end
