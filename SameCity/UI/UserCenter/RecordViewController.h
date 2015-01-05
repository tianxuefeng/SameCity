//
//  RecordViewController.h
//  samecity
//
//  Created by zengchao on 14-8-10.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "CommonViewController.h"

@interface RecordViewController : CommonViewController<UITableViewDataSource ,UITableViewDelegate>
{
    UITableView *indexTableView;
}

@property (nonatomic ,retain) NSMutableArray *items;

@end
