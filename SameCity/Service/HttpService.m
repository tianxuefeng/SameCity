//
//  HttpService.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HttpService.h"

@implementation HttpService

- (id)init
{
    if (self = [super init]) {
        
        self.isLoading = NO;
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
}

- (void)PostAsync:(NSString *)url andParams:(NSDictionary *)params Success:(ResponseSuccessBlock)success falure:(ResponseFailureBlock)failure
{
    __unsafe_unretained HttpService *weakSelf = self;
    
    self.isLoading = YES;
    
    AFHTTPRequestOperationManager *net = [HttpManager instanse].netManager;
    
    [net POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        weakSelf.isLoading = NO;
        
        NSObject *jsonObject = [operation.responseData fetchedData];
        
        if (success) {
             success(jsonObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        weakSelf.isLoading = NO;
        
        if (failure) {
            failure(error);
        }
    }];
}

- (void)GetAsync:(NSString *)url andParams:(NSDictionary *)params Success:(ResponseSuccessBlock)success falure:(ResponseFailureBlock)failure
{
    __unsafe_unretained HttpService *weakSelf = self;
    
    self.isLoading = YES;
    
    AFHTTPRequestOperationManager *net = [HttpManager instanse].netManager;
    
    [net GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        DLog(@"%@",operation.responseString);
        weakSelf.isLoading = NO;
    
        NSObject *jsonObject = [operation.responseData fetchedData];
        
        if (success) {
            success(jsonObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        weakSelf.isLoading = NO;
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
