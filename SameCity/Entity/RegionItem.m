
//
//  RegionItem.m
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "RegionItem.h"

@implementation RegionItem

- (void)dealloc
{
    RELEASE_SAFELY(_daima);
    RELEASE_SAFELY(_dengji);
    RELEASE_SAFELY(_diming);
    RELEASE_SAFELY(_zidi);
    
    [super dealloc];
}

@end
