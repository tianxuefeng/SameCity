//
//  FXZLocationManager.h
//  FXZ
//
//  Created by zengchao on 13-4-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


UIKIT_EXTERN NSString *const LocationManagerLocationChangedNotificationKey;

UIKIT_EXTERN NSString *const LocationManagerLocationGetAddressNotificationKey;

typedef void(^FXZLocationManagerLocationUpdateBlock)(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation);
typedef void (^FXZLocationManagerLocationUpdateFailBlock)(CLLocationManager *manager, NSError *error);

@interface FXZLocationManager : NSObject

/**
 * @discussion the most recently retrieved user location.
 */
@property (nonatomic ,retain) CLLocation *location;

@property (nonatomic ,retain) NSString *country;

@property (nonatomic ,retain) NSString *city;

@property (nonatomic ,retain) NSString *region;

@property (nonatomic ,retain) NSString *street;

+ (FXZLocationManager *)sharedManager;
+ (BOOL)locationServicesEnabled;

- (void)startUpdatingLocationWithBlock:(FXZLocationManagerLocationUpdateBlock)block errorBlock:(FXZLocationManagerLocationUpdateFailBlock)errorBlock; // USING BLOCKS
- (void)refreshUpdatingLocationWithBlock:(FXZLocationManagerLocationUpdateBlock)block errorBlock:(FXZLocationManagerLocationUpdateFailBlock)errorBlock;

+ (double)getDistanceFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to;

- (void)startUploadLocation;
//- (void)stopUploadLocation;

@end
