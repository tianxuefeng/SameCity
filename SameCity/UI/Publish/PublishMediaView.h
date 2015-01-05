//
//  PublishMediaView.h
//  BBYT
//
//  Created by zengchao on 14-3-8.
//  Copyright (c) 2014年 babyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH  80
#define HIGHT  80

#define TAGH  10

#define BTNWIDTH  WIDTH - TAGH
#define BTNHIGHT  HIGHT - TAGH

@class PublishMediaView;

@protocol PublishMediaViewDelegate <NSObject>

@optional
- (void)publishMediaViewAddBtnClick:(PublishMediaView *)target;

- (void)publishMediaViewImageBtnClick:(PublishMediaView *)target index:(int)index;

@end

@interface PublishMediaView : UIView
{
    UIButton *addBtn;
    UIScrollView *imagesScrollView;
    
    BOOL m_bTransform;
}

@property (nonatomic ,assign) id<PublishMediaViewDelegate>delegate;
@property (nonatomic ,assign) int maxNum;
@property (nonatomic ,retain) NSMutableArray *images;

- (void)addImage:(UIImage *)image;

- (void)deleteImage:(int)index;

- (void)replaceImage:(UIImage *)image index:(int)index;

- (void)deleteAll;

@end
