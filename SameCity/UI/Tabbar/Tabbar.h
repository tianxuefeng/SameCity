//
//  Tabbar.h
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tabbar;

@protocol TabbarDelegate<NSObject>
@optional
- (void)tabBar:(Tabbar *)tabBar didSelectIndex:(NSInteger)index;

@end

@interface Tabbar : UIView
{
	UIImageView *_backgroundView;
	id<TabbarDelegate> _delegate;
	NSMutableArray *_buttons;
    NSMutableArray *_titles;
    
    UIImageView *slideImgView;
}
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, assign) id<TabbarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) NSMutableArray *titles;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray andButtonTitles:(NSArray *)titleArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;
- (void)setBackgroundImage:(UIImage *)img;

@end
