//
//  CategoryItem.m
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CategoryItem.h"

@implementation CategoryItem

- (void)dealloc
{
    RELEASE_SAFELY(_ID);
    RELEASE_SAFELY(_Title);
    RELEASE_SAFELY(_Description);
    RELEASE_SAFELY(_ParentID);
    RELEASE_SAFELY(_CountryCode);
    RELEASE_SAFELY(_Images);
    
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    CategoryItem *item = [[CategoryItem allocWithZone:zone] init];
    
    item.ID = self.ID;
    item.Title = self.Title;
    item.Description = self.Description;
    item.ParentID = self.ParentID;
    item.CountryCode = self.CountryCode;
    item.Images = self.Images;
    
    return item;
}

@end
