//
//  LoginViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "MemberData.h"

@class LoginViewController;

@protocol LoginDelegate <NSObject>

- (void)LoginSucced:(LoginViewController *)target;

@end

@interface LoginViewController : CommonViewController<HttpServiceDelegate>
{
    CommonTextField *usernameText;
    
    CommonTextField *passwordText;
    
    MemberData *loginData;
    
    MemberData *userData;
    
    MemberData *userData2;
}

@property (nonatomic ,assign) id<LoginDelegate>delegate;

@end
