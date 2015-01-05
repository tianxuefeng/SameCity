//
//  CustomRegionItem.h
//  samecity
//
//  Created by zengchao on 14-9-28.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "JSONModel.h"

@interface CustomRegionItem : JSONModel

@property (nonatomic ,retain) NSString *ID;

@property (nonatomic ,retain) NSString *ParentRegionName;

@property (nonatomic ,retain) NSString *LanguageCode;

@property (nonatomic ,retain) NSString *RegionName;

//@property (nonatomic ,assign) BOOL isSelect;

@property (nonatomic ,assign) BOOL isCustom;

@end
