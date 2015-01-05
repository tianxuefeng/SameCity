//
//  MessageItem.m
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "MessageItem.h"

@implementation MessageItem

- (void)dealloc
{
    RELEASE_SAFELY(_ID);
    RELEASE_SAFELY(_Msg);
    RELEASE_SAFELY(_PostTime);
    RELEASE_SAFELY(_OwnerID);
    RELEASE_SAFELY(_ReplierID);
    RELEASE_SAFELY(_ParentID);
    RELEASE_SAFELY(_ReplyTime);
    RELEASE_SAFELY(_ItemID);
    
    [super dealloc];
}

@end
