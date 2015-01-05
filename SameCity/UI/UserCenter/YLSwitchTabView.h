//
//  YLSwitchTabView.h
//  YiLife
//
//  Created by zengchao on 14-7-1.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLSwitchTabView;

@protocol YLSwitchTabViewDataSourse <NSObject>

@required
- (NSInteger)numOfYLSwitchTabView:(YLSwitchTabView *)target;

- (NSString *)YLSwitchTabViewTitle:(YLSwitchTabView *)target ofIndex:(NSInteger)index;
@end

@protocol YLSwitchTabViewDelegate <NSObject>

@optional
- (void)yLSwitchTabView:(YLSwitchTabView *)target ofIndex:(NSInteger)index;

@end

@interface YLSwitchTabView : UIView
{
    UIImageView *line;
    
    UIButton *selectBtn;
}

@property (nonatomic ,assign) int selectTag;

@property (nonatomic ,weak) id <YLSwitchTabViewDataSourse> dataSourse;
@property (nonatomic ,weak) id <YLSwitchTabViewDelegate> delegate;

- (void)selectBtnTag:(int)btnTag;

- (void)reloadData;

@end
