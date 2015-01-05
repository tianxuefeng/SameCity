//
//  CustomRegionItem.m
//  samecity
//
//  Created by zengchao on 14-9-28.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "CustomRegionItem.h"

@implementation CustomRegionItem

- (void)dealloc
{
    RELEASE_SAFELY(_ID);
    RELEASE_SAFELY(_ParentRegionName);
    RELEASE_SAFELY(_LanguageCode);
    RELEASE_SAFELY(_RegionName);
    
    [super dealloc];
}

@end
