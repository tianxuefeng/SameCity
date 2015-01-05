//
//  CustomPickView.h
//  LYGInformationport
//
//  Created by zengchao on 14-3-28.
//  Copyright (c) 2014年 xweisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomPickView;

@protocol CustomPickViewDelegate <NSObject>

@optional
- (void)customPickView:(CustomPickView *)pick didSelect:(int)index;

@end

@interface CustomPickView : UIView
{
    UIPickerView *pickview;
    
    UIView *pickBg;
}
@property (nonatomic , readonly) BOOL isShow;
//@property (nonatomic ,assign) id<CustomPickViewDelegate>

@property (nonatomic ,assign) id<UIPickerViewDataSource>datasourse;

@property (nonatomic ,assign) id<UIPickerViewDelegate,CustomPickViewDelegate>delegate;

- (void)show;

- (void)hide;

- (void)reloadData;

@end
