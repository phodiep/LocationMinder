//
//  MapViewController.m
//  LocationMinder
//
//  Created by Pho Diep on 2/2/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)seattleButtonPressed:(UIButton *)sender;
- (IBAction)bostonButtonPressed:(UIButton *)sender;
- (IBAction)newYorkButtonPressed:(UIButton *)sender;

@end

@implementation MapViewController

#pragma mark - UIViewController Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Button Actions
- (void) goToCoordinates:(MKMapView*)map latitude:(NSNumber *)lat longitude:(NSNumber *)lng {
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
