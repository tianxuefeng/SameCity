//
//  MyPublishedViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-29.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "HomePageData.h"

@interface MyPublishedViewController : CommonViewController<HttpServiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myPublishedTableView;
    
    HomePageData *myPublishedData;
}

@property (nonatomic ,retain) NSMutableArray *items;

@end
