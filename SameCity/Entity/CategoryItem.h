//
//  CategoryItem.h
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "JSONModel.h"

@interface CategoryItem : JSONModel<NSCopying>

@property (nonatomic ,retain) NSString *ID;

@property (nonatomic ,retain) NSString *Title;

@property (nonatomic ,retain) NSString *Description;

@property (nonatomic ,retain) NSString *ParentID;

@property (nonatomic ,retain) NSString *CountryCode;

@property (nonatomic ,retain) NSString *Images;

@property (nonatomic ,retain) NSString *CreateUser;

@property (nonatomic ,strong) NSString *Sequence;

@end
