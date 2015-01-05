//
//  PublishViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
//#import "CustomPickView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "HomePageData.h"
#import "CommonTextField.h"
#import "CustomTextView.h"
#import "FUISegmentedControl.h"
#import "PublishMediaView.h"

@class CategoryItem ,PublishViewController;

@protocol PublishViewControllerDelegate <NSObject>

- (void)publishedSuccceed:(PublishViewController *)target;

@end

@interface PublishViewController : CommonViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,HttpServiceDelegate,PublishMediaViewDelegate>
{
    IBOutlet CommonButton *imageBtn;
    
    IBOutlet CommonTextField *titleText;
    IBOutlet CustomTextView  *descText;
    IBOutlet CommonTextField *phoneText;
    IBOutlet CommonTextField *addressText;
    IBOutlet CommonTextField *priceText;
    
    IBOutlet TPKeyboardAvoidingScrollView *bgScrollView;
    IBOutlet CommonButton *cateBtn;
    
//    CustomPickView *catePickView;
    
    HomePageData *homepageData;
    
    IBOutlet FUISegmentedControl *isBuySeg;
    
    PublishMediaView *imgScrollView;
    
}

@property (nonatomic ,assign) id <PublishViewControllerDelegate> delegate;

@property (nonatomic ,assign) BOOL fromPush;

@property (nonatomic ,retain) CategoryItem *selectCate;

@property (nonatomic ,retain) NSMutableArray *uploadImageArr;

@end
