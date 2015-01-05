//
//  RegisterViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonTextField.h"
#import "MemberData.h"

@class RegisterViewController;

@protocol RegisterViewDelegate <NSObject>

- (void)registerViewSucceed:(RegisterViewController *)target;

@end

@interface RegisterViewController : CommonViewController<HttpServiceDelegate>
{
    CommonTextField *emailText;
    CommonTextField *nameText;
    CommonTextField *passwordText;
    CommonTextField *confirmText;
    
//    CommonTextField *ICText;
    CommonTextField *phoneText;
    CommonTextField *qqText;
//    CommonTextField *Text;
    
    MemberData *registerData;
}

@property (nonatomic ,assign) id<RegisterViewDelegate>delegate;

@end
