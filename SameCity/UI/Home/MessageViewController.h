//
//  MessageViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "MessageData.h"
#import "ReplyView.h"

@interface MessageViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate,HttpServiceDelegate,ReplyViewDelegate>
{
    UITableView *wallTableView;
    
    MessageData *messageData;
    
    ReplyView *containerView;
}

@property (nonatomic ,copy) NSString *prepareString;

@property (nonatomic ,retain) NSString *itemID;

@property (nonatomic ,retain) NSMutableArray *items;

@end
