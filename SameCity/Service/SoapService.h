//
//  SoapService.h
//  SameCity
//
//  Created by zengchao on 14-4-22.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionary+extend.h"
#import "SoapUtility.h"
#import "AFNetworking.h"
#import "DDXML.h"
#import "NSData+JSONCategories.h"

@class SoapService;

@protocol SoapServiceDelegate <NSObject>

- (void)soapService:(SoapService *)target Succeed:(NSObject *)response;
- (void)soapService:(SoapService *)target Failed:(NSError *)error;

@end

@interface ResponseData : NSObject

@property (nonatomic,assign) NSInteger StatusCode;
@property (nonatomic,strong) NSString *Content;

@end

typedef void (^SuccessBlock) (NSObject *response);
typedef void (^FailureBlock) (NSError *response);

@interface SoapService : NSObject

@property (nonatomic ,assign) BOOL isLoading;
@property (nonatomic,strong) NSString *SoapAction;
@property (nonatomic,strong) NSString *UserAgent;
@property (nonatomic,strong) NSString *ContentType;
@property (nonatomic,strong) NSString *PostUrl;
@property (nonatomic,strong) NSString *AcceptEncoding;
@property (nonatomic) NSInteger Timeout;

@property (nonatomic ,strong) NSString *soapMessage;

@property (nonatomic ,assign) id<SoapServiceDelegate>delegate;

@property (nonatomic,strong) SuccessBlock success;
@property (nonatomic,strong) FailureBlock failure;

-(id)initWithPostUrl:(NSString *)url SoapAction:(NSString *)soapAction;

//-(ResponseData *)PostSync:(NSString *)postData;
//-(void)PostAsync:(NSString *)postData Success:(SuccessBlock)success falure:(FailureBlock)falure;

-(void)postAsyncSuccess:(SuccessBlock)success falure:(FailureBlock)falure;

-(NSMutableURLRequest *)CreatRequest:(NSString *)postData;

@end
