//
//  ReminderRowController.h
//  LocationMinder
//
//  Created by Pho Diep on 2/5/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface ReminderRowController : NSObject

@property (strong, nonatomic) IBOutlet WKInterfaceLabel *reminderLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceMap *map;

@end
