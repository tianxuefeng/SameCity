//
//  YLEditBottomView.h
//  YiLife
//
//  Created by zengchao on 14-7-30.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLEditBottomView;

@protocol YLEditBottomViewDelegate <NSObject>

- (void)YLEditBottomViewAdd:(YLEditBottomView *)target;

- (void)YLEditBottomViewAllSelect:(YLEditBottomView *)target;

- (void)YLEditBottomViewDelete:(YLEditBottomView *)target;

- (void)YLEditBottomViewStateChaneged:(YLEditBottomView *)target;

@end

@interface YLEditBottomView : UIView
{
    UIButton *addBtn;
    UIButton *editBtn;
    UIButton *allSelectBtn;
    UIButton *deleteBtn;
    UIButton *cancelBtn;
}

@property (nonatomic ,weak) id<YLEditBottomViewDelegate>delegate;

@property (nonatomic ,assign) BOOL isEditing;

@property (nonatomic ,assign) BOOL allSelected;

@end
