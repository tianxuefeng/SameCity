//
//  PublishCateViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "CategoryItem.h"
#import "CategoryData.h"

@class PublishCateViewController;

@protocol PublishCateViewControllerDelegate <NSObject>

@optional

- (void)publishCateViewControllerCitySelect:(CategoryItem *)selectedCateItem;

@end

@interface PublishCateViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate,HttpServiceDelegate>
{
    UITableView *cateTableView;
    
    CategoryData *categoryData;
}

@property (nonatomic ,assign) id<PublishCateViewControllerDelegate>delegate;

@property (nonatomic ,assign) int level;

@property (nonatomic ,retain) NSMutableArray *items;

@property (nonatomic ,retain) NSString *superCateID;

@end
