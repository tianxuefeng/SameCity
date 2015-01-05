//
//  CategoryViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "CategoryItem.h"
#import "CategoryData.h"
#import "SUNSlideSwitchView.h"

@interface CategoryViewController : CommonViewController<HttpServiceDelegate,SUNSlideSwitchViewDelegate>
{
//    UIScrollView *functionBg;
    CategoryData *categoryData;
    CategoryData *categoryData2;
    
    UIButton *addButton;
}

@property (nonatomic ,retain) SUNSlideSwitchView *slideSwitchView;

@property (nonatomic ,retain) CategoryItem *cItem;

@property (nonatomic ,retain) NSMutableArray *items;

@end
