//
//  MyFavViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "MyFavData.h"

@interface MyFavViewController : CommonViewController<HttpServiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myFavTableView;
    
    MyFavData *myFavData;
}

@property (nonatomic ,retain) NSMutableArray *items;

@end
