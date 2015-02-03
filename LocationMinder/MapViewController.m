//
//  MapViewController.m
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#pragma mark - interface
@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

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
    
    
    if (![CLLocationManager locationServicesEnabled]) {
        // user has disabled location services
        // TODO prompt user to enable location to continue
    } else {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            // request authorization
            [self.locationManager requestAlwaysAuthorization];
        } else {
            self.mapView.showsUserLocation = true;
            [self.locationManager startUpdatingLocation];
        }
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPressed:)];
    [self.mapView addGestureRecognizer:longPress];
    
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.firstObject;
    NSLog(@"lat: %f and long: %f", location.coordinate.latitude, location.coordinate.longitude);
    
}


#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    annotationView.animatesDrop = true;
    annotationView.pinColor = MKPinAnnotationColorGreen;
    annotationView.canShowCallout = true;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    MKPointAnnotation *annotation = view.annotation;
    [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];
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
