//
//  HomePageListViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "HomePageListCell.h"
#import "MJRefreshTableView.h"
#import "HomePageData.h"
#import "CategoryItem.h"
#import "HomePageListControllerProtocol.h"

@interface HomePageListViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate,HttpServiceDelegate,MJRefreshTableViewDelegate,HomePageListControllerProtocol>

{
    MJRefreshTableView *indexTableView;
    
    BOOL isRefreshing;
    
    HomePageData *listData;
    
    UIButton *addButton;
}

@property (nonatomic ,retain) CategoryItem *cateItem;

@property (nonatomic ,retain) NSMutableArray *items;

@end
