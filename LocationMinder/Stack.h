//
//  Stack.h
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

-(instancetype) initWithArray:(NSMutableArray*) stack;
-(void) push:(NSObject*) item;
-(NSObject*) pop;
-(NSObject*) peek;
-(NSInteger) size;

@end
