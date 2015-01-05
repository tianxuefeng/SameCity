//
//  Record.h
//  samecity
//
//  Created by zengchao on 14-8-10.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Record : NSManagedObject

@property (nonatomic, retain) NSString * categoryID;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * createDate;
@property (nonatomic, retain) NSString * rID;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * qqSkype;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * sequence;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * images;

@end
