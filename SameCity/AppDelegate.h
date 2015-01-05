//
//  AppDelegate.h
//  SameCity
//
//  Created by zengchao on 14-4-22.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"

@class TabbarViewController;

#define DEFAULT_COUNTRY     @"defult_country"
#define DEFAULT_CITY        @"defult_city"
#define DEFAULT_CITY_ID      @"defult_city_ID"
#define DEFAULT_REGION      @"defult_region"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) TabbarViewController *tabBarCtl;

//@property (retain, nonatomic) UINavigationController *cityCtl;

@end
