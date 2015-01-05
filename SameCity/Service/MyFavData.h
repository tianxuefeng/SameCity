//
//  MyFavData.h
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HttpService.h"

@interface MyFavData : HttpService

- (void)getMyFavList;

- (void)insertMyFav:(NSString *)itemID;

- (void)deleteMyFav:(NSString *)itemID;

@end
