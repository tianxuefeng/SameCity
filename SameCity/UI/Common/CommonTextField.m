//
//  CommonTextField.m
//  SameCity
//
//  Created by zengchao on 14-6-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonTextField.h"

@implementation CommonTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.font = [UIFont systemFontOfSize:16];
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        imageV.backgroundColor = [UIColor clearColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = imageV;
        [imageV release];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return self;
}

- (void)awakeFromNib
{
    self.font = [UIFont systemFontOfSize:16];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
    imageV.backgroundColor = [UIColor clearColor];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = imageV;
    [imageV release];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
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
