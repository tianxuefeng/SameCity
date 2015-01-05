//
//  MessageData.m
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "MessageData.h"
#import "UserLogin.h"

@implementation MessageData

- (id)initWithItemId:(NSString *)ID
{
    if (self = [super init]) {
        self.itemId = ID;
    }
    return self;
}

- (void)getMessageList
{
    self.tag = WALL_LIST_DATA_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];

    [params addObject:self.itemId forKey:@"ItemID"];
    
    [self GetAsync:combineStr(WALL_SERVICE_URL, GET_WALL_LIST_URL) andParams:params Success:^(NSObject *response) {
        //
        
        NSMutableArray *items = [NSMutableArray array];
        
        for (NSDictionary *tmpDic in (NSArray *)response) {
            MessageItem *messageDto = [[MessageItem alloc] initWithDictionary:tmpDic error:nil];
            if (messageDto) {
                NSString *timeString = messageDto.PostTime;
                timeString = [timeString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
                timeString = [timeString stringByReplacingOccurrencesOfString:@")/" withString:@""];
                messageDto.PostTime = timeString;
                
                NSString *timeString2 = messageDto.ReplyTime;
                timeString2 = [timeString2 stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
                timeString2 = [timeString2 stringByReplacingOccurrencesOfString:@")/" withString:@""];
                messageDto.ReplyTime = timeString2;
              
                [items addObject:messageDto];
            }
            RELEASE_SAFELY(messageDto);
        }
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:items];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
    
}

- (void)sendMessage:(NSString *)message
{
    self.tag = WALL_INSERT_DATA_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params addObject:[UserLogin instanse].uid forKey:@"OwnerID"];
    [params addObject:self.itemId forKey:@"ItemID"];
    [params addObject:message forKey:@"Msg"];
    
    [self PostAsync:combineStr(WALL_SERVICE_URL, POST_ADD_WALL_URL) andParams:params Success:^(NSObject *response) {
        //
        
        NSMutableArray *items = [NSMutableArray array];
        
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:items];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)replyMessage:(NSString *)message toMessage:(MessageItem *)toMess
{
    self.tag = WALL_REPLY_DATA_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params addObject:[UserLogin instanse].uid forKey:@"OwnerID"];
    [params addObject:self.itemId forKey:@"ItemID"];
    [params addObject:message forKey:@"Msg"];
    [params addObject:toMess.OwnerID forKey:@"ReplierID"];
    [params addObject:toMess.ID forKey:@"ParentMessageID"];
    
    [self GetAsync:combineStr(WALL_SERVICE_URL, POST_ADD_FAV_URL) andParams:params Success:^(NSObject *response) {
        //
        
        NSMutableArray *items = [NSMutableArray array];
        
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:items];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

@end
