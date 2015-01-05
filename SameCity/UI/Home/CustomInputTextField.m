
//
//  CustomInputTextField.m
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CustomInputTextField.h"

@implementation CustomInputTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.font = [UIFont systemFontOfSize:16];
        
        self.enabled = NO;
        
        self.background = [ImageWithName(@"input_bg_2") adjustSize];
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)];
        self.tipLb.textAlignment = NSTextAlignmentCenter;
        self.tipLb.backgroundColor = [UIColor clearColor];
        self.tipLb.font = [UIFont systemFontOfSize:16];
        self.tipLb.textColor = COLOR_THEME;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = self.tipLb;

        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_tipLb);
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
