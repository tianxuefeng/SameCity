//
//  UserLogin.h
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_UID                @"uid"
#define USER_PHONE              @"phone"
#define USER_EMAIL              @"email"
#define USER_QQSKPE             @"qqSkype"
#define USER_NAME               @"name"
#define USER_TYPE               @"MemType"

typedef void (^LoginVoidBlock)(void);

@interface UserLogin : NSObject<NSCoding,NSCopying>

@property (nonatomic ,assign) BOOL isLogin;

@property (nonatomic ,retain) NSString *uid;

@property (nonatomic ,retain) NSString *phone;

@property (nonatomic ,retain) NSString *email;

@property (nonatomic ,retain) NSString *qqSkype;

@property (nonatomic ,retain) NSString *name;

@property (nonatomic ,retain) NSString *MemType;

@property (nonatomic ,retain) NSMutableArray *categoryItems;

- (void)queryUserInfo;
- (void)saveUserInfo;
- (void)clearUserInfo;

+ (UserLogin *)instanse;

- (void)loginFrom:(UIViewController *)target succeed:(LoginVoidBlock)Succeed;

@end
