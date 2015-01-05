//
//  FXZLocationManager.m
//  FXZ
//
//  Created by zengchao on 13-4-28.
//
//

#import "FXZLocationManager.h"
#import <MapKit/MKGeometry.h>
#import "FXZLocationManager.h"
//#import "XMPPOperation.h"
//#import "XMPPLocationUpload.h"
//#import "FXZLogin.h"
#import "CityBarItemView.h"

#define MAX_MONITORING_REGIONS 20

NSString *const LocationManagerLocationChangedNotificationKey = @"LocationManagerLocationChangedNotificationKey";

NSString *const LocationManagerLocationGetAddressNotificationKey = @"LocationManagerLocationGetAddressNotificationKey";

//#define kDefaultUserDistanceFilter  kCLLocationAccuracyBest
//#define kDefaultUserDesiredAccuracy kCLLocationAccuracyBest

@interface FXZLocationManager()<CLLocationManagerDelegate>
{
    BOOL _isUpdatingUserLocation;
    BOOL _isOnlyOneRefresh;
    
//    XMPPLocationUpload *_xmppLocationUpload;
}

// Location Blocks
@property (copy) FXZLocationManagerLocationUpdateBlock locationBlock;
@property (copy) FXZLocationManagerLocationUpdateFailBlock errorLocationBlock;

@property (nonatomic, readonly) CLLocationManager *userLocationManager;

@end

@implementation FXZLocationManager

#pragma mark - CLLocationManagerDelegate

+ (FXZLocationManager *)sharedManager {
    static FXZLocationManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FXZLocationManager alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
//    NSLog(@"[%@] init:", NSStringFromClass([self class]));
    
    if (self = [super init]) {
        // Init
        [self _init];
    }
    
    return self;
}

- (void)_init
{
//    NSLog(@"[%@] _init:", NSStringFromClass([self class]));
    
    _isUpdatingUserLocation = NO;
    _isOnlyOneRefresh = YES;
    
    _userLocationManager = [[CLLocationManager alloc] init];
    _userLocationManager.distanceFilter = 1000.0;
    _userLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _userLocationManager.delegate = self;
    
    if ([_userLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_userLocationManager requestAlwaysAuthorization];
    }

}

- (void)dealloc
{
    RELEASE_SAFELY(_userLocationManager);
    self.locationBlock = nil;
    self.errorLocationBlock = nil;
    
    [super dealloc];
}

- (CLLocation *)location
{
//    NSLog(@"[%@] location:", NSStringFromClass([self class]));
    
    return self.userLocationManager.location;
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//	NSLog(@"[%@] locationManager:didFailWithError:%@", NSStringFromClass([self class]), error);
    
    if (_isOnlyOneRefresh) {
        [_userLocationManager stopUpdatingLocation];
    }
    
    // Call location block
    if (self.errorLocationBlock != nil) {
        self.errorLocationBlock(manager, error);
    }

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"[%@] locationManager:didUpdateToLocation:fromLocation: %@", NSStringFromClass([self class]), newLocation);
    
    if (!_isUpdatingUserLocation) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LocationManagerLocationChangedNotificationKey object:nil];
    }
    
    if (_isOnlyOneRefresh) {
        [self stopUpdatingLocation];
    }
    if (signbit(newLocation.horizontalAccuracy)) {
        //
    }
    else {
        // Call location block
        if (self.locationBlock != nil) {
            self.locationBlock(manager, newLocation, oldLocation);
        }
    }
}

- (void)startUpdatingLocationWithBlock:(FXZLocationManagerLocationUpdateBlock)block errorBlock:(FXZLocationManagerLocationUpdateFailBlock)errorBlock {
    
    self.locationBlock = block;
    self.errorLocationBlock = errorBlock;
    
     _isOnlyOneRefresh = NO;
    
    [self startUpdatingLocation];
}

- (void)refreshUpdatingLocationWithBlock:(FXZLocationManagerLocationUpdateBlock)block errorBlock:(FXZLocationManagerLocationUpdateFailBlock)errorBlock {
    
    self.locationBlock = block;
    self.errorLocationBlock = errorBlock;
    
    _isOnlyOneRefresh = YES;
    
    [self updateUserLocation];
}

- (void)startUpdatingLocation
{
//    NSLog(@"[%@] startUpdatingLocation:", NSStringFromClass([self class]));
    
    _isUpdatingUserLocation = YES;
    [self.userLocationManager startUpdatingLocation];
}


- (void)updateUserLocation
{
//    NSLog(@"[%@] updateUserLocation:", NSStringFromClass([self class]));
    
    [_userLocationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
//    NSLog(@"[%@] stopUpdatingLocation:", NSStringFromClass([self class]));
    
    _isUpdatingUserLocation = NO;
    [self.userLocationManager stopUpdatingLocation];
}



#pragma mark Method's

+ (BOOL)locationServicesEnabled
{
    [FXZLocationManager sharedManager] ;
    return [CLLocationManager locationServicesEnabled];
}

+ (double)getDistanceFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to
{
    MKMapPoint m_from  = MKMapPointForCoordinate(from);
    MKMapPoint m_to  = MKMapPointForCoordinate(to);
    
    CLLocationDistance distance = MKMetersBetweenMapPoints(m_from, m_to);
    
    return distance;
}

- (void)getGeocoder:(CLLocation *)location
{
    self.location = location;
    
//    103.9631831
//    CLLocation *haha = [[CLLocation   alloc] initWithLatitude:103.9631831     longitude:1.322597];
//    location.coordinate = CLLocationCoordinate2DMake(103.38, 1.09);
//    CLLocationDegrees latitude = location.coordinate.latitude;
//    CLLocationDegrees longitude = location.coordinate.longitude;
//    NSString *lat = [NSString stringWithFormat:@"%f",latitude];
//    NSString *lon = [NSString stringWithFormat:@"%f",longitude];
    __block CLGeocoder *cg = [[CLGeocoder alloc] init];
    [cg reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        
        
        if (!error && placemarks) {
            
            if (!cg.geocoding && placemarks.count > 0) {
                CLPlacemark *locationMark = [placemarks lastObject];
                NSDictionary *dic = locationMark.addressDictionary;
                
                NSLog(@"打印地理位置");
                for (NSString *allkey in dic.allKeys) {
                    NSLog(@"%@=%@",allkey,[dic objectForKey:allkey]);
                }
                
//                NSLog(@"地理位置字典%@",dic.description);
                //区名
                NSString *subLocality = [dic objectForKey:@"SubLocality"];
                NSString *city = [dic objectForKey:@"City"];
                NSString *state = [dic objectForKey:@"Country"];
                NSString *street = [dic objectForKey:@"Street"];
                
                self.country = state;
                self.city = city;
                self.region = subLocality;
                self.street = street;
//                [CityBarItemView shareInstance].cityLb.text = self.city;
            
                [[NSNotificationCenter defaultCenter] postNotificationName:LocationManagerLocationGetAddressNotificationKey object:nil];
            }
            
        }
        
        [cg release];
    }];
}

- (void)startUploadLocation
{
    FXZLocationManager *locationManager = [FXZLocationManager sharedManager];
    [locationManager refreshUpdatingLocationWithBlock:^(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation)
     {
         [self getGeocoder:newLocation];
         
         [locationManager stopUpdatingLocation];
         
     }errorBlock:^(CLLocationManager *manager, NSError *error)
     {
         
     }];
}

//- (NSString *)city
//{
//    if ([NSString isNotEmpty:_city]) {
//        return _city;
//    }
//    return @"";
//}


@end
