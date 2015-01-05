//
//  NSDictionary+JSONCategories.m
//  ELifes
//
//  Created by zengchao on 13-10-18.
//  Copyright (c) 2013年 zengchao. All rights reserved.
//

#import "NSDictionary+JSONCategories.h"

@implementation NSDictionary (JSONCategories)

- (NSData *)toJSON
{
    NSError *error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

- (NSString *)toJSONString
{
    NSMutableString *mString = [NSMutableString string];
    for (int i=0; i<self.allKeys.count; i++) {
        NSString *key = self.allKeys[i];
        NSString *value = self[key];
        if (i==0) {
            [mString appendFormat:@"%@=%@",key,value];
        }
        else {
            [mString appendFormat:@"&%@=%@",key,value];
        }
    }
    return mString;
}

- (NSString *)toXMLString
{
    NSMutableString *mString = [NSMutableString string];
    for (int i=0; i<self.allKeys.count; i++) {
        NSString *key = self.allKeys[i];
        NSString *value = self[key];
    
        [mString appendFormat:@"<%@>%@</%@>",key,value,key];
    }
    return mString;
}

@end
