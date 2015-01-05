//
//  HttpService.h
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"
#import "NSMutableDictionary+extend.h"
#import "NSData+JSONCategories.h"


@class HttpService;

@protocol HttpServiceDelegate <NSObject>

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response;
- (void)httpService:(HttpService *)target Failed:(NSError *)error;

@end

@interface HttpService : NSObject

typedef void (^ResponseSuccessBlock) (NSObject *response);
typedef void (^ResponseFailureBlock) (NSError *error);

@property (nonatomic ,assign) NSInteger tag;

@property (nonatomic ,assign) BOOL isLoading;

@property (nonatomic ,weak) id<HttpServiceDelegate>delegate;

- (void)PostAsync:(NSString *)url andParams:(NSDictionary *)params Success:(ResponseSuccessBlock)success falure:(ResponseFailureBlock)failure;

- (void)GetAsync:(NSString *)url andParams:(NSDictionary *)params Success:(ResponseSuccessBlock)success falure:(ResponseFailureBlock)failure;

@end
