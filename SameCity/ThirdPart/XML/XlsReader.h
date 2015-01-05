//
//  XlsReader.h
//  aiyou
//
//  Created by zengchao on 13-1-25.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XlsReader : NSObject

+ (void)traversingVector:(NSString *)Name withArr:(NSMutableArray *)xlsArr ofSet:(NSMutableSet *)xlsSet;

@end
