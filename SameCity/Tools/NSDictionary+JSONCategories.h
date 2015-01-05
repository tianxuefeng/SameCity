//
//  NSDictionary+JSONCategories.h
//  ELifes
//
//  Created by zengchao on 13-10-18.
//  Copyright (c) 2013年 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONCategories)

- (NSData*)toJSON;

- (NSString *)toJSONString;

- (NSString *)toXMLString;

@end
