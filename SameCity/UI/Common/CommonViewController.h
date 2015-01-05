//
//  CommonViewController.h
//  BBYT
//
//  Created by zengchao on 14-1-15.
//  Copyright (c) 2014年 babyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMutableDictionary+extend.h"
#import "UIBarButtonItem+FlatUI.h"
#import "NSString+Time.h"
//#import "Soap.h"
#import "CommonLabel.h"
#import "CommonButton.h"
#import "CommonTextField.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AppDelegate.h"
//#import "MBProgressHUD.h"
//#import "MBProgressHUD+Add.h"
#import "LeafNotification.h"
#import "YYAnimationIndicator.h"
#import "Constant.h"
#import "HttpConstant.h"
#import "NSString+extend.h"
#import "UIImage+extend.h"

@interface CommonViewController : UIViewController
{
    CGFloat statusBar_Top;
}

//@property (nonatomic ,assign) BOOL needForceReload;

@property (nonatomic ,retain) YYAnimationIndicator *loadingView;

- (void)setupNavi;

- (void)back:(id)sender;

- (void)startLoading;

- (void)startLoadingWithTitle:(NSString *)title;

- (void)stopLoading;

- (void)stopLoadingWithError:(NSString *)error;

- (void)showTips:(NSString *)tips;

- (void)slideViewDidLoad;

@end
