//
//  MapViewController.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureMap];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.navigationItem.leftBarButtonItem setTarget: self.revealViewController];
        [self.navigationItem.leftBarButtonItem setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

- (void) configureMap {
    self.mapView.mapType = MKMapTypeHybrid;
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(53.9045404, 27.5616074);
    
    
    MKCoordinateRegion reg = MKCoordinateRegionMakeWithDistance(loc, 20000, 20000);
    self.mapView.region = reg;
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"plist"];
    NSArray *annotations = [[NSDictionary dictionaryWithContentsOfFile: path] objectForKey: @"Annotations"];
    for (NSDictionary *dict in annotations) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([dict[@"longtitude"] doubleValue], [dict[@"latitude"] doubleValue]);
        annotation.title = dict[@"title"];
        annotation.subtitle = dict[@"subtitle"];
        NSLog(@"Added annotation");
        [self.mapView addAnnotation: annotation];
    }
    self.mapView.showsUserLocation = YES;
    
    self.locationManager = [CLLocationManager new];
    
    [self.locationManager requestWhenInUseAuthorization];
}



@end
