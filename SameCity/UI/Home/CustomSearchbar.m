//
//  CustomSearchbar.m
//  aiyou
//
//  Created by zengchao on 12-12-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomSearchbar.h"
#import "UIImage+extend.h"

@implementation CustomSearchbar

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //...
//       [[self.subviews objectAtIndex:0] removeFromSuperview];
//        UIView *segment = [self.subviews objectAtIndex:0];
        self.placeholder = NSLocalizedString(btn_search, nil);
        [self customApi:frame];
    }
    return self;
}

- (void)customApi:(CGRect)Frame
{
    for (UIView *view in self.subviews)   {
 
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
           [view removeFromSuperview];
            UIImageView *bgImage = [[UIImageView alloc] initWithFrame:Frame];
            bgImage.image = [[UIImage imageNamed:@"list.png"] adjustSize];
            [self addSubview: bgImage];
            [self sendSubviewToBack:bgImage];
            [bgImage release];
        }
    
    }
}

- (void)addSubview:(UIView *)view {
    
    [super addSubview:view];
    
    if ([view isKindOfClass:UIButton.class]) {
        
        UIButton *cancelButton = (UIButton *)view;
        [cancelButton setTitle:NSLocalizedString(btnNO, nil) forState:0];
        [cancelButton setBackgroundImage:[[UIImage imageNamed:@"navi_right1.png"] adjustSize] forState:UIControlStateNormal];
        
        [cancelButton setBackgroundImage:[[UIImage imageNamed:@"navi_right2.png"] adjustSize] forState:UIControlStateHighlighted];
        
    }
    else if ([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
        UITextField *textField = (UITextField *)view;
        textField.background = [[UIImage imageNamed:@"ipt_bg.png"] adjustSize];
        [self bringSubviewToFront:textField];
    }
    
}
@end
