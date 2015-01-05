//
//  NSMutableDictionary+extend.h
//  Wifi
//
//  Created by zengchao on 13-12-2.
//  Copyright (c) 2013年 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (extend)

- (void)addObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
