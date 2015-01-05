//
//  ComponentsFactory.h
//  linphone
//
//  Created by wqy on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComponentsFactory : NSObject


+ (UILabel *)labelWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                           tag:(NSInteger)tag
                     hasShadow:(Boolean)hasShadow;

+ (UILabel *)sectionLabelWithText:(NSString *)text;

@end
