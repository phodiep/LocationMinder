//
//  AddReminderDetailViewController.m
//  LocationMinder
//
//  Created by Pho Diep on 2/3/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "AddReminderDetailViewController.h"

@interface AddReminderDetailViewController () <UITextFieldDelegate>

- (IBAction)addReminderPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *nameReminder;
@property (strong, nonatomic) IBOutlet UITextField *radiusText;

@end

@implementation AddReminderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Add Reminder";
    
    self.nameReminder.delegate = self;
    
    self.nameReminder.text = self.annotation.title;
    self.radiusText.text = @"200";
    
//    NSLog(self.annotation.title);

}

- (void) textFieldDidEndEditing:(UITextField *)textField {

//    self.annotation.title = textField.text;
}


#pragma mark - Button Actions
- (IBAction)addReminderPressed:(UIButton *)sender {
    
    self.annotation.title = self.nameReminder.text;
    
    NSInteger radius = @200;
    if (self.radiusText.text != nil) {
        radius = [self.radiusText.text integerValue];
    }
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        //if monitoring is available, create Region w/ specified radius
        CLCircularRegion *region = [[CLCircularRegion alloc]
                                    initWithCenter:self.annotation.coordinate
                                    radius:radius
                                    identifier:@"Reminder"];
        
        //start monitoring region, and add to notificationCenter
        [self.locationManager startMonitoringForRegion:region];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderAdded" object:self userInfo:@{@"notificationRegion":region}];
        
        
    }

    
}
@end
