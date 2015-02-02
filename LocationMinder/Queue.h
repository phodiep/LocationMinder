//
//  Queue.h
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

-(instancetype) initWithArray:(NSMutableArray*) items;
-(void) enqueue: (NSObject*) item;
-(NSObject*) dequeue;
-(NSInteger) size;

@end
