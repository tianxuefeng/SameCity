//
//  UIBarButtonItem+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIBarButtonItem+FlatUI.h"

@implementation UIBarButtonItem (FlatUI)


+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [NSString calculateTextHeight:[UIFont systemFontOfSize:14] givenText:title givenWidth:100];
    
    button.frame = CGRectMake(0, 0, size.width+10, 26);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setBackgroundImage:ImageWithName(@"navi_bar_btn") forState:UIControlStateNormal];
    [button setBackgroundImage:ImageWithName(@"navi_bar_btn_s") forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}

+ (UIBarButtonItem *)createBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(0, 0, 34, 44);
    //    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}

+ (UIBarButtonItem *)createBackBarButtonItemTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(0, 0, 45, 31);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [button setImage:ImageWithName(@"navi_back.png") forState:UIControlStateNormal];
    [button setImage:ImageWithName(@"navi_back_press.png") forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    [barItem setBackgroundVerticalPositionAdjustment:30 forBarMetrics:UIBarMetricsDefault];
    
    return barItem;
}

//+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
//{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
//    return [item autorelease];
//
//}

@end
