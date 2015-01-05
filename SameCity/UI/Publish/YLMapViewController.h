//
//  YLMapViewController.h
//  LohasYangZhou
//
//  Created by WhiZenBJ on 14-9-3.
//  Copyright (c) 2014年 com.xweisoft. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>

#import <MapKit/MapKit.h>

#import "CommonViewController.h"


@interface YLMapViewController : CommonViewController < MKMapViewDelegate > {

    MKMapView *mapView;
    
    MKPinAnnotationView *locationView;
}

//@property ( nonatomic ,strong) NSMutableArray

@property ( nonatomic, assign ) BOOL isLocation;

@property ( nonatomic, strong ) CLLocation *location;


@end
