//
//  CategoryData.h
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HttpService.h"
#import "CategoryItem.h"

@interface CategoryData : HttpService

- (void)getCategoryListParentID:(NSString *)parentID;

- (void)insertNewCategory:(CategoryItem *)newItem;

- (void)updateNewCategory:(CategoryItem *)newItem;

- (void)deleteNewCategoryID:(NSString *)ID;

@end
