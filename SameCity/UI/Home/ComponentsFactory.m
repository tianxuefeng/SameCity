//
//  ComponentsFactory.m
//  linphone
//
//  Created by wqy on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ComponentsFactory.h"
//#import "UI"

@implementation ComponentsFactory

+ (UILabel *)labelWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                           tag:(NSInteger)tag
                     hasShadow:(Boolean)hasShadow
{
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.text = text;
	label.textColor = textColor;
	label.backgroundColor = [UIColor clearColor];
	if( hasShadow )
    {
		label.shadowColor = [UIColor blackColor];
		label.shadowOffset = CGSizeMake(1,1);
	}
	label.textAlignment = NSTextAlignmentLeft;
	label.font = font;
	label.tag = tag;
	
	return [label autorelease];
}

+ (UILabel *)sectionLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 24)];
    label.text = [NSString stringWithFormat:@"  %@",text];
//    label.textColor = [UIColor getColor:@"1EA9E6"];
    label.textColor = COLOR_THEME;
    label.backgroundColor = UIColorFromRGB(0xeeeeee);
    label.font = [UIFont systemFontOfSize:18];
    label.shadowColor = [UIColor lightGrayColor];
    label.shadowOffset = CGSizeMake(1,1);
    label.textAlignment = NSTextAlignmentLeft;
//    label.alpha = 0.5;
    return [label autorelease];
}


@end
