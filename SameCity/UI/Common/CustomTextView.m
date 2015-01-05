//
//  CustomTextView.m
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        ctextView = [[UITextView alloc] init];
        imageView = [[UIImageView alloc] init];
        
        [self addSubview:imageView];
        [self addSubview:ctextView];
        
        ctextView.font = [UIFont systemFontOfSize:16];
        ctextView.delegate = self;
        ctextView.backgroundColor = [UIColor clearColor];
        ctextView.text = @"";
        imageView.image = [ImageWithName(@"input_bg_1") adjustSize];
        ctextView.frame = CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6);
        imageView.frame = CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6);
        
        holderLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 25)];
        holderLb.font = [UIFont systemFontOfSize:16];
        holderLb.backgroundColor = [UIColor clearColor];
        holderLb.textColor = UIColorFromRGB(0xd6d6d6);
        [self addSubview:holderLb];
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    
    ctextView = [[UITextView alloc] init];
    imageView = [[UIImageView alloc] init];
    
    [self addSubview:imageView];
    [self addSubview:ctextView];

    ctextView.font = [UIFont systemFontOfSize:16];
    ctextView.delegate = self;
    ctextView.backgroundColor = [UIColor clearColor];
    ctextView.text = @"";
    imageView.image = [ImageWithName(@"input_bg_1") adjustSize];
    ctextView.frame = CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6);
    imageView.frame = CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6);
    
    holderLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 25)];
    holderLb.font = [UIFont systemFontOfSize:16];
    holderLb.backgroundColor = [UIColor clearColor];
    holderLb.textColor = UIColorFromRGB(0xd6d6d6);
    [self addSubview:holderLb];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    holderLb.text = placeholder;
}

- (NSString *)placeholder
{
    return holderLb.text;
}

- (void)setText:(NSString *)text
{
    ctextView.text = text;
}

- (NSString *)text
{
    return ctextView.text;
}

- (void)dealloc
{
    RELEASE_SAFELY(ctextView);
    RELEASE_SAFELY(imageView);
    RELEASE_SAFELY(holderLb);
    
    [super dealloc];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([NSString isNotEmpty:textView.text]) {
        //
        holderLb.hidden = YES;
    }
    else {
        holderLb.hidden = NO;
    }
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
