//
//  CityBarItemView.h
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityBarItemView : UIView

@property (nonatomic ,retain)  UILabel *cityLb;

@property (nonatomic ,retain) UIButton *acButton;

+ (instancetype)shareInstance;

@end
