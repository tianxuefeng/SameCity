//
//  MessageItem.h
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "JSONModel.h"

@interface MessageItem : JSONModel

@property (nonatomic ,retain) NSString *ID;

@property (nonatomic ,retain) NSString *Msg;

@property (nonatomic ,retain) NSString *PostTime;

@property (nonatomic ,retain) NSString *OwnerID;

@property (nonatomic ,retain) NSString *ReplierID;

@property (nonatomic ,retain) NSString *ParentID;

@property (nonatomic ,retain) NSString *ReplyTime;

@property (nonatomic ,retain) NSString *ItemID;

@end
