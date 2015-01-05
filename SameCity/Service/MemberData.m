//
//  LoginData.m
//  SameCity
//
//  Created by zengchao on 14-6-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "MemberData.h"
#import "UserLogin.h"

@implementation RegiserItem

- (void)dealloc
{
    RELEASE_SAFELY(_Email);
    RELEASE_SAFELY(_Name);
    RELEASE_SAFELY(_Password);
    RELEASE_SAFELY(_Phone);
    RELEASE_SAFELY(_QQSkype);
    RELEASE_SAFELY(_IC);
    
    [super dealloc];
}

@end

@implementation MemberData

- (id)init
{
    if (self = [super init]) {
   
        self.deviceToken = @"";
    }
    return self;
}


- (void)loginEmail:(NSString *)email andPassword:(NSString *)password
{
    self.tag = LOGIN_DATA_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [params addObject:email forKey:@"Email"];
    [params addObject:[password MD5Sum] forKey:@"Password"];
    
    [self GetAsync:combineStr(LOGIN_SERVICE_URL, POST_LOGIN_URL) andParams:params Success:^(NSObject *response) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)regiserEmail:(RegiserItem *)registerItem
{
    self.tag = REGISTER_DATA_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params addEntriesFromDictionary:[registerItem toDictionary]];
    [params addObject:self.deviceToken forKey:@"DeviceToken"];
    [params addObject:@"1" forKey:@"MemType"];
    
    [self PostAsync:combineStr(LOGIN_SERVICE_URL, POST_REGISTER_URL) andParams:params Success:^(NSObject *response) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)getMemberDetail:(NSString *)userID
{
    self.tag = MEMBER_DETIAL_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];

    [params addObject:userID forKey:@"ID"];
    
    [self PostAsync:combineStr(LOGIN_SERVICE_URL, GET_MEMBER_DETAIL_URL) andParams:params Success:^(NSObject *response) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)updatePassword:(NSString *)newPassword
{
    self.tag = MEMBER_PASSWORD_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    
    [params addObject:[UserLogin instanse].uid forKey:@"ID"];
    [params addObject:[newPassword MD5Sum] forKey:@"Password"];
    
    [self PostAsync:combineStr(LOGIN_SERVICE_URL, POST_PASSWORD_URL) andParams:params Success:^(NSObject *response) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

@end
