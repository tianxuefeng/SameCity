//
//  MessageData.h
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HttpService.h"
#import "MessageItem.h"

@interface MessageData : HttpService

@property (nonatomic ,retain) NSString *itemId;

- (id)initWithItemId:(NSString *)ID;

- (void)getMessageList;

- (void)sendMessage:(NSString *)message;

- (void)replyMessage:(NSString *)message toMessage:(MessageItem *)toMess;

@end
