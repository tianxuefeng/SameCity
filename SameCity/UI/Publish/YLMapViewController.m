//
//  YLMapViewController.m
//  LohasYangZhou
//
//  Created by WhiZenBJ on 14-9-3.
//  Copyright (c) 2014年 com.xweisoft. All rights reserved.
//


#import "YLMapViewController.h"
#import "FXZLocationManager.h"
//#import "YLDisplayMap.h"


@interface YLMapViewController ()

@end


@implementation YLMapViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupNavi {

    [super setupNavi];

    self.title = NSLocalizedString(title_map, nil);
}

- (void)viewDidLoad {

    [super viewDidLoad];

    [[FXZLocationManager sharedManager] refreshUpdatingLocationWithBlock:^(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation) {
        //
    } errorBlock:^(CLLocationManager *manager, NSError *error) {
        //
    }];
    
    CGRect frame = CGRectMake( 0, 0, kMainScreenWidth, kMainScreenHeight - 64 );
    mapView = [[MKMapView alloc] initWithFrame:frame];
    mapView.delegate = self;
    [self.view addSubview:mapView];

    if (self.location) {
        [self locationTarget];
    }
    else {
        
        //MKAnnotationView
        
        locationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@"locationViewIdentifier"];
        [mapView addSubview:locationView];
        
        UIImageView *leftImageV = [[UIImageView alloc] initWithImage:ImageWithName(@"icon_paopao_middle_left")];
        locationView.leftCalloutAccessoryView = leftImageV;
        [leftImageV release];
        
        UIImageView *rightImageV = [[UIImageView alloc] initWithImage:ImageWithName(@"icon_paopao_middle_right")];
        locationView.rightCalloutAccessoryView = rightImageV;
        [rightImageV release];
    }
}

- (void)locationTarget {

    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = _location.coordinate.latitude;
    centerCoordinate.longitude = _location.coordinate.longitude;

    MKCoordinateRegion region;
    region.center = centerCoordinate;
    region.span = mapView.region.span;
    region.span.latitudeDelta = 0.005;
    region.span.longitudeDelta = 0.005;
    [mapView setRegion:region animated:YES];

//    YLDisplayMap *annotation = [[YLDisplayMap alloc] init];
//    annotation.coordinate = centerCoordinate;
//    [mapView addAnnotation:annotation];
//
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:_location
//        completionHandler:^( NSArray *placemark, NSError *error ) {
//
//            CLPlacemark *placeMark = [placemark objectAtIndex:0];
//            NSString *title = placeMark.subLocality;
//            if ( placeMark.thoroughfare ) {
//                title = [title stringByAppendingString:placeMark.thoroughfare];
//            }
//            if ( placeMark.subThoroughfare ) {
//                title = [title stringByAppendingString:placeMark.subThoroughfare];
//            }
//            [annotation setTitle:title];
//            [annotation setSubtitle:[NSString stringWithFormat:@"%@", placeMark.name]];
//            [mapView selectAnnotation:annotation animated:YES];
//        }
//    ];
}

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation {

    MKPinAnnotationView *pinView = nil;
    if ( annotation != _mapView.userLocation ) {

        static NSString *defaultPinID = @"MKAnnotationView";
        pinView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) {
            
            pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
        }
//        pinView.image=[UIImage imageNamed:@"bicycle_icon.png"];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    return pinView;
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
