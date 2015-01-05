//
//  NSData+JSONCategories.m
//  ELifes
//
//  Created by zengchao on 13-10-18.
//  Copyright (c) 2013年 zengchao. All rights reserved.
//

#import "NSData+JSONCategories.h"

@implementation NSData (JSONCategories)

//GET后，解析收到的JSON
- (id)fetchedData{
    //parse out the json data
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization
                          JSONObjectWithData:self //1
                          options:NSJSONReadingAllowFragments
                          error:&error];
    if (error != nil) return nil;
    return result;
}


@end
