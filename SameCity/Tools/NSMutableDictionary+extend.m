//
//  NSMutableDictionary+extend.m
//  Wifi
//
//  Created by zengchao on 13-12-2.
//  Copyright (c) 2013年 zengchao. All rights reserved.
//

#import "NSMutableDictionary+extend.h"

@implementation NSMutableDictionary (extend)

- (void)addObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
