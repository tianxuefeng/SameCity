//
//  HomePageItem.m
//  SameCity
//
//  Created by zengchao on 14-5-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HomePageItem.h"

@implementation HomePageItem

- (void)dealloc
{
    RELEASE_SAFELY(_CategoryID);
    RELEASE_SAFELY(_City);
    RELEASE_SAFELY(_CountryCode);
    RELEASE_SAFELY(_CreateDate);
    RELEASE_SAFELY(_Description);
    RELEASE_SAFELY(_ID);
    RELEASE_SAFELY(_Phone);
    RELEASE_SAFELY(_Price);
    RELEASE_SAFELY(_QQSkype);
    RELEASE_SAFELY(_Region);
    RELEASE_SAFELY(_Sequence);
    RELEASE_SAFELY(_Title);
    RELEASE_SAFELY(_UserID);
    RELEASE_SAFELY(_Images);
    RELEASE_SAFELY(_Address);
    
    [super dealloc];
}

@end
