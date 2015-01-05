//
//  MemberItem.h
//  SameCity
//
//  Created by zengchao on 14-6-29.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "JSONModel.h"

@interface MemberItem : JSONModel

@property (nonatomic ,retain) NSString *ID;

@property (nonatomic ,retain) NSString *Name;

@property (nonatomic ,retain) NSString *Email;

@property (nonatomic ,retain) NSString *Phone;

@property (nonatomic ,retain) NSString *QQSkype;

@property (nonatomic ,retain) NSString *MemType;

@end
