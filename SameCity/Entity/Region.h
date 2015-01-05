//
//  Region.h
//  samecity
//
//  Created by zengchao on 14-8-3.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Region : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * identify;
@property (nonatomic, retain) NSString * name;

@end
