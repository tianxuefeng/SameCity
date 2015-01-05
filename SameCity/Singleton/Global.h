//
//  Global.h
//  samecity
//
//  Created by zengchao on 14-8-3.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Province.h"
#import "Record.h"
#import "HomePageItem.h"
#import "MainCate.h"
#import "CategoryItem.h"

UIKIT_EXTERN NSString *SystemDoc();

UIKIT_EXTERN NSString *UserPath();

@interface Global : NSObject
{
    NSMutableSet *citysSet;
    NSMutableArray *cityLists;
}
@property (nonatomic ,retain) NSMutableArray *firstArray;
@property (nonatomic ,retain) NSMutableArray *cityLists_sorted; //次数组含有2级数组
@property (nonatomic ,assign) BOOL isSorted;

@property (nonatomic ,assign) BOOL mustRefresh;

@property (nonatomic ,retain) NSString *country;

@property (nonatomic ,retain) NSString *city;

@property (nonatomic ,retain) NSString *region;

@property (nonatomic ,retain) NSString *publishedID;

+ (Global *)ShareCenter;

- (void)initCitys;

- (NSArray *)getRecordArray;

- (Record *)insertNewRecord:(HomePageItem *)item;

- (NSArray *)getMainCateArray;

- (MainCate *)insertNewCates:(CategoryItem *)item;

- (void)deleteAllCates;

@end
