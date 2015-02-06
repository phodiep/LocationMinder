//
//  InterfaceController.m
//  LocationMinder WatchKit Extension
//
//  Created by Pho Diep on 2/5/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "InterfaceController.h"
#import "ReminderRowController.h"
#import <CoreLocation/CoreLocation.h>
#import <WatchKit/WatchKit.h>


@interface InterfaceController()

@property (strong, nonatomic) IBOutlet WKInterfaceTable *table;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    NSArray *regions = [locationManager.monitoredRegions allObjects];
    
    //set identifier in storyboard!!!
    [self.table setNumberOfRows: regions.count withRowType:@"ReminderRowController"];
    
    
    NSInteger index = 0;
    for (CLCircularRegion *region in regions) {
        ReminderRowController *rowController = [self.table rowControllerAtIndex:index];
   
        [rowController.reminderLabel setText:region.identifier];
        MKCoordinateRegion mkCoordinates = MKCoordinateRegionMake(region.center, MKCoordinateSpanMake(.02, .02));
        
        [rowController.map setRegion:mkCoordinates];
        [rowController.map addAnnotation:region.center withPinColor:WKInterfaceMapPinColorPurple];

        index++;
    }
    
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



