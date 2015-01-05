//
//  WFIndexBanner.h
//  Wifi
//
//  Created by zengchao on 13-12-3.
//  Copyright (c) 2013年 zengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIPageControl.h"

#define TITLE_HEIGHT    0

#define ITEM_WIDTH      320.0

#define WFBANNER_HEIGHT 140+12+TITLE_HEIGHT

@interface WFIndexModel: NSObject

@property (nonatomic ,retain) NSURL *url;
@property (nonatomic ,retain) NSString *title;

@end

@class WFIndexBanner,WFIndexModel;

@protocol WFIndexBannerDelegate <NSObject>

@optional;
- (void)indexBanner:(WFIndexBanner *)target displayPage:(NSInteger)index;

//- (void)indexBanner:(WFIndexBanner *)target SelectPage:(NSInteger)index;

- (void)indexBanner:(WFIndexBanner *)target SelectPage:(NSInteger)index AndImageView:(UIImageView *)imageV;


@end

@protocol WFIndexBannerDataSourse <NSObject>

@required
- (NSInteger)numberOfIndexBanner:(WFIndexBanner *)target;
- (WFIndexModel *)indexBannerImageURL:(WFIndexBanner *)target ofIndex:(NSInteger)index;

@end

@interface WFIndexBanner : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl  *_pageControl;
    NSMutableArray *_slideImages;
//    NSMutableArray *_slideLabels;
    
//    NSTimer *timer;
}

@property (nonatomic ,assign) id<WFIndexBannerDelegate>delegate;
@property (nonatomic ,assign) id<WFIndexBannerDataSourse>dataSourse;

- (void)reloadData;

@end
