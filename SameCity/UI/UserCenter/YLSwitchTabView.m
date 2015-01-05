//
//  YLSwitchTabView.m
//  YiLife
//
//  Created by zengchao on 14-7-1.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "YLSwitchTabView.h"

@implementation YLSwitchTabView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame)-2, self.frame.size.width*0.5, 2)];
        line.backgroundColor = COLOR_THEME;
        [self addSubview:line];
    }
    return self;
}

- (void)reloadData
{
    for (UIView *tmpView in self.subviews) {
        if ([tmpView isKindOfClass:[UIButton class]]) {
            [tmpView removeFromSuperview];
        }
    }
    
    NSInteger max = [self.dataSourse numOfYLSwitchTabView:self];
    
    CGFloat width = ((int)(self.frame.size.width/max*100))/100.0;
    
    for (int i=0; i<max; i++) {
        
        NSString *title = [self.dataSourse YLSwitchTabViewTitle:self ofIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.frame = CGRectMake(width*i, 0, width, self.frame.size.height);
        
        if (i== max-1) {
            button.frame = CGRectMake(width*i+0.6, 0, width, self.frame.size.height);
        }
        if (title) {
            [button setTitle:title forState:UIControlStateNormal];
        }
        
        [self addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            
            [button setTitleColor:COLOR_THEME forState:UIControlStateNormal];
            [button setTitleColor:COLOR_THEME forState:UIControlStateHighlighted];

            [button setBackgroundImage:[ImageWithName(@"tab_btn_0") adjustSize] forState:UIControlStateNormal];
            [button setBackgroundImage:[ImageWithName(@"tab_btn_0") adjustSize] forState:UIControlStateHighlighted];

            CGRect frame = button.frame;
            frame.size.height = 2;
            frame.origin.y = self.frame.size.height-2;
            line.frame = frame;
            
            selectBtn = button;
        }
        else {
            
            [button setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
            [button setTitleColor:COLOR_TITLE forState:UIControlStateHighlighted];
          
            [button setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateNormal];
            [button setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateHighlighted];
        }
    }
    [self bringSubviewToFront:line];
}

- (void)buttonClick:(UIButton *)sender
{
    if (selectBtn && selectBtn.tag == sender.tag) {
        return;
    }
    
    if (selectBtn){
        [selectBtn setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
        [selectBtn setTitleColor:COLOR_TITLE forState:UIControlStateHighlighted];
    }
    
    CGRect frame = sender.frame;
    frame.size.height = 2;
    frame.origin.y = self.frame.size.height-2;
    
    [sender setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    [sender setTitleColor:COLOR_THEME forState:UIControlStateHighlighted];
    
    [UIView animateWithDuration:0.32 animations:^{
        //
        line.frame = frame;
    }];
    
    self.selectTag = sender.tag-100;
    selectBtn = sender;
}

- (void)selectBtnTag:(int)btnTag
{
    if (self.selectTag == btnTag) {
        return;
    }
    
    self.selectTag = btnTag;
    UIButton *sender = (UIButton *)[self viewWithTag:btnTag+100];
    
    if (!sender) {
        return;
    }
    
    if (selectBtn){
        [selectBtn setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
        [selectBtn setTitleColor:COLOR_TITLE forState:UIControlStateHighlighted];
    }
    
    
    CGRect frame = sender.frame;
    frame.size.height = 2;
    frame.origin.y = self.frame.size.height-2;
    
    [sender setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    [sender setTitleColor:COLOR_THEME forState:UIControlStateHighlighted];
    
    [UIView animateWithDuration:0.32 animations:^{
        //
        line.frame = frame;
    }];
    
    selectBtn = sender;
}

- (void)setSelectTag:(int)selectTag
{
    _selectTag = selectTag;
    
    if (_delegate && [_delegate respondsToSelector:@selector(yLSwitchTabView:ofIndex:)]) {
        [self.delegate yLSwitchTabView:self ofIndex:selectTag];
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
