//
//  MyFavData.m
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "MyFavData.h"
#import "UserLogin.h"
#import "HomePageItem.h"

@implementation MyFavData

- (void)getMyFavList
{
    self.tag = MYFAV_LIST_TAG;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params addObject:[UserLogin instanse].uid forKey:@"UserID"];
    
    [self GetAsync:combineStr(MY_FAV_URL, GET_FAV_LIST_URL) andParams:params Success:^(NSObject *response) {
        //
        
        NSMutableArray *items = [NSMutableArray array];
        
        if (response && [response isKindOfClass:[NSArray class]]) {
            for (NSDictionary *tmpDic in (NSArray *)response) {
                HomePageItem *indexDto = [[HomePageItem alloc] initWithDictionary:tmpDic error:nil];
                if (indexDto) {
                    NSString *timeString = indexDto.CreateDate;
                    timeString = [timeString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
                    timeString = [timeString stringByReplacingOccurrencesOfString:@")/" withString:@""];
                    indexDto.CreateDate = timeString;
                    [items addObject:indexDto];
                }
                RELEASE_SAFELY(indexDto);
            }
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

- (void)insertMyFav:(NSString *)itemID
{
    self.tag = MYFAV_INSERT_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params addObject:itemID forKey:@"ItemID"];
    [params addObject:[UserLogin instanse].uid forKey:@"UserID"];
    
    [self GetAsync:combineStr(MY_FAV_URL, POST_ADD_FAV_URL) andParams:params Success:^(NSObject *response) {
        //
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)deleteMyFav:(NSString *)itemID
{
    self.tag = MYFAV_DELETE_TAG;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params addObject:itemID forKey:@"ItemID"];
    [params addObject:[UserLogin instanse].uid forKey:@"UserID"];
    
    [self GetAsync:combineStr(MY_FAV_URL, POST_DEL_FAV_URL) andParams:params Success:^(NSObject *response) {
        //
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

@end
