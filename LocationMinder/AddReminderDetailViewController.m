//
//  AddReminderDetailViewController.m
//  LocationMinder
//
//  Created by Pho Diep on 2/3/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "AddReminderDetailViewController.h"

#pragma mark - Interface
@interface AddReminderDetailViewController ()

- (IBAction)addReminderPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *nameReminder;
@property (strong, nonatomic) IBOutlet UITextField *radiusText;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITextField *locationText;
@property (strong, nonatomic) IBOutlet UILabel *LongLabel;
@property (strong, nonatomic) IBOutlet UILabel *Latlabel;

@end

#pragma mark - Implementation
@implementation AddReminderDetailViewController

#pragma mark - ViewController Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Add Reminder";

    self.LongLabel.text = [NSString stringWithFormat:@"Longitude: %0.03f", self.annotation.coordinate.longitude ];
    self.Latlabel.text = [NSString stringWithFormat:@"Latitude: %0.03f", self.annotation.coordinate.latitude ];
    
    // set defaults
    self.locationText.text = self.annotation.title;
    self.radiusText.text = @"200";

    // make mapView
    MKCoordinateRegion mkCoordinates = MKCoordinateRegionMake(self.annotation.coordinate, MKCoordinateSpanMake(.02, .02));
    [self.mapView setRegion:mkCoordinates];
    [self.mapView addAnnotation:self.annotation];
    
}

#pragma mark - Button Actions
- (IBAction)addReminderPressed:(UIButton *)sender {
    
    if ([self.nameReminder.text isEqual:@""]) {
        //prompt user for name of reminder
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Name of Reminder Required" message:@"To set a reminder, please provide a name for it." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okOption = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //close alertView
        }];
        
        [alertController addAction:okOption];
        [self presentViewController:alertController animated:true completion:nil];
        
        
    } else {
        self.annotation.title = self.locationText.text;
        
        NSInteger radius = @200;
        if (self.radiusText.text != @"") {
            radius = [self.radiusText.text integerValue];
        }
        
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            //if monitoring is available, create Region w/ specified radius
            CLCircularRegion *region = [[CLCircularRegion alloc]
                                        initWithCenter:self.annotation.coordinate
                                        radius:radius
                                        identifier:self.nameReminder.text];
            
            //start monitoring region, and add to notificationCenter
            [self.locationManager startMonitoringForRegion:region];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderAdded" object:self userInfo:@{@"notificationRegion":region}];
            
            // return to previous view controller
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}

@end
