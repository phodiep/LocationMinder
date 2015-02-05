//
//  MapViewController.m
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "MapViewController.h"
#import "AddReminderDetailViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#pragma mark - interface
@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKPointAnnotation *selectedAnnotation;
@property (strong, nonatomic) NSArray *monitoredRegions;

- (IBAction)seattleButtonPressed:(UIButton *)sender;
- (IBAction)bostonButtonPressed:(UIButton *)sender;
- (IBAction)newYorkButtonPressed:(UIButton *)sender;

@end

#pragma mark - implementation
@implementation MapViewController

#pragma mark - UIViewController Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.mapView.delegate = self;
    
    //make current vc an observer of specific notification (name) and fire action (@selector) if selected by user
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderAdded:) name:@"ReminderAdded" object:nil];

    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // request authorization
        [self.locationManager requestAlwaysAuthorization];
    } else {
        self.mapView.showsUserLocation = true;
        [self.locationManager startUpdatingLocation];
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPressed:)];
    [self.mapView addGestureRecognizer:longPress];
    
}

-(void)dealloc {
    //cleanup on closing of app
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:@"SHOW_DETAIL"]) {
        AddReminderDetailViewController *addReminderVC = (AddReminderDetailViewController *)segue.destinationViewController;
        addReminderVC.annotation = self.selectedAnnotation;
        addReminderVC.locationManager = self.locationManager;
        
    }
}

#pragma mark - NSNotification
-(void)reminderAdded:(NSNotification *)notification {
    //get info from notification selected
    NSDictionary *userInfo = notification.userInfo;
    CLCircularRegion *region = userInfo[@"notificationRegion"];  //was named 'notificationRegion' in addReminderVC
    
    //make overlay circle and add to mapView
    MKCircle *circleOverlay = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
    [self.mapView addOverlay:circleOverlay];
    
    self.monitoredRegions = [[self.locationManager monitoredRegions] allObjects];
    NSLog(@"%i", (int)[self.monitoredRegions count]);
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // location services disabled... alert user to enable in settings
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Services Disabled" message:@"To continue, go to settings and set Location to ALWAYS for this app." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okOption = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //close alertView
    }];
    
    [alertController addAction:okOption];
    [self presentViewController:alertController animated:true completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    //create localNotification to alert user, and present it
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"region entered"; //text shown in notification alert
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}


#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // annotation init'd
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    annotationView.animatesDrop = true;
    annotationView.pinColor = MKPinAnnotationColorGreen;
    annotationView.canShowCallout = true;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    // annotation is selected
    self.selectedAnnotation = view.annotation;
    [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    // overlay about to come on screen
    MKCircleRenderer *circle = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    
    circle.fillColor = [UIColor blueColor];
    circle.strokeColor = [UIColor blueColor];
    circle.alpha = 0.25;
    
    return circle;
}

#pragma mark - Gestures
- (void)mapLongPressed:(id)sender {
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;

    if (longPress.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [longPress locationInView:self.mapView];
        CLLocationCoordinate2D coordinates = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = coordinates;
        annotation.title = @"New location";
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark - Button Actions
- (void)goToCoordinates:(MKMapView*)map latitude:(NSNumber *)lat longitude:(NSNumber *)lng {
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
    
    MKCoordinateRegion region = [map regionThatFits:MKCoordinateRegionMakeWithDistance(coordinates, 1000, 1000)];
    [map setRegion:region animated:true];
}

- (IBAction)bostonButtonPressed:(UIButton *)sender {
    //42.3581° N, 71.0636° W
    [self goToCoordinates:self.mapView latitude:@42.3581 longitude:@(-71.0636)];
}

- (IBAction)seattleButtonPressed:(UIButton *)sender {
    //47.6097° N, 122.3331° W
    [self goToCoordinates:self.mapView latitude:@47.6097 longitude:@(-122.3331)];
}

- (IBAction)newYorkButtonPressed:(UIButton *)sender {
    //40.7127° N, 74.0059° W
    [self goToCoordinates:self.mapView latitude:@40.7127 longitude:@(-74.0059)];
}
    
@end
