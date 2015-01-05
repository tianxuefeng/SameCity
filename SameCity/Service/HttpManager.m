//
//  HttpManager.m
//  SameCity
//
//  Created by zengchao on 14-6-9.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HttpManager.h"

NSString *const CateReloadNotificationKey = @"CateReloadNotificationKey";

NSString *const CateObtainNotificationKey = @"CateObtainNotificationKey";

@implementation HttpManager

+ (HttpManager *)instanse {
    static HttpManager *_sharedClient = nil;
    static dispatch_once_t onceTokens;
    dispatch_once(&onceTokens, ^{
        _sharedClient = [[HttpManager alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    if (self = [super init]) {
        
        NSString *url = [NSString stringWithFormat:@"http://%@/",HOST];
        _netManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
        
        AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager managerForDomain:HOST];
        _netManager.reachabilityManager = reachability;
        [_netManager.reachabilityManager startMonitoring];
        _netManager.requestSerializer.timeoutInterval = 60;
        _netManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _netManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"text/plain",@"text/html", nil];
//        _netManager.requestSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"text/plain", nil];
//        NSLog(@"%@",_netManager.requestSerializer.acceptableContentTypes);
    }
    return self;
}

@end
