//
//  MemberItem.m
//  SameCity
//
//  Created by zengchao on 14-6-29.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "MemberItem.h"

@implementation MemberItem


- (void)dealloc
{
    RELEASE_SAFELY(_ID);
    RELEASE_SAFELY(_Name);
    RELEASE_SAFELY(_Email);
    RELEASE_SAFELY(_QQSkype);
    RELEASE_SAFELY(_Phone);

    [super dealloc];
}

@end
