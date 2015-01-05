//
//  MainCate.h
//  samecity
//
//  Created by zengchao on 14-8-10.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MainCate : NSManagedObject

@property (nonatomic, retain) NSString * cID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * images;

@end
