//
//  AddReminderDetailViewController.m
//  LocationMinder
//
//  Created by Pho Diep on 2/3/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "AddReminderDetailViewController.h"

@interface AddReminderDetailViewController ()
- (IBAction)addReminderPressed:(UIButton *)sender;

@end

@implementation AddReminderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Add Reminder";
    
    NSLog(self.annotation.title);

}


#pragma mark - Button Actions
- (IBAction)addReminderPressed:(UIButton *)sender {

    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        //if monitoring is available, create Region w/ 200 radius
        CLCircularRegion *region = [[CLCircularRegion alloc]
                                    initWithCenter:self.annotation.coordinate
                                    radius:200
                                    identifier:@"Reminder"];
        
        //start monitoring region, and add to notificationCenter
        [self.locationManager startMonitoringForRegion:region];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderAdded" object:self userInfo:@{@"notificationRegion":region}];
        
        
    }

    
}
@end
