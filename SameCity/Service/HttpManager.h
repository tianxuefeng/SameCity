//
//  HttpManager.h
//  SameCity
//
//  Created by zengchao on 14-6-9.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

UIKIT_EXTERN NSString *const CateReloadNotificationKey;

UIKIT_EXTERN NSString *const CateObtainNotificationKey;

@interface HttpManager : NSObject

@property (nonatomic ,strong) AFHTTPRequestOperationManager *netManager;

+ (HttpManager *)instanse;

@end
