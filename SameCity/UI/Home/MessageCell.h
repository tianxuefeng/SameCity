//
//  MessageCell.h
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "MessageItem.h"

@interface MessageCell : CommonTableViewCell
{
    UILabel *replyLb;
    
    UILabel *messageLb;
    
    UILabel *levelLb;
}

@property (nonatomic ,assign) NSInteger row;

@property (nonatomic ,retain) NSString *replyString;

@property (nonatomic ,retain) MessageItem *item;

+ (CGFloat)getMessageCellHeight:(MessageItem *)mess;

@end
