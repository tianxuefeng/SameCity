//
//  SettingViewController.h
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"

@interface SettingViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *settingTableView;
}

@property (nonatomic ,retain) NSMutableArray *items;

@end
