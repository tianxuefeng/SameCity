//
//  IndexViewController.h
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "HttpService.h"
#import "IndexListCell.h"
#import "MJRefreshTableView.h"

@interface HomePageViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshTableViewDelegate>
{
    UILabel *defaultCityLb;
    
    MJRefreshTableView *indexTableView;
    
    BOOL isRefreshing;
}

@property (nonatomic ,retain) NSMutableArray *items;

@end
