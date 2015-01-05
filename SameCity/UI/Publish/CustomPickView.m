//
//  CustomPickView.m
//  LYGInformationport
//
//  Created by zengchao on 14-3-28.
//  Copyright (c) 2014年 xweisoft. All rights reserved.
//

#import "CustomPickView.h"

@implementation CustomPickView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        pickBg = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame), kMainScreenWidth, 200)];
        pickBg.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [self addSubview:pickBg];
        
        pickview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kMainScreenWidth, 200-40)];
        pickview.backgroundColor = UIColorFromRGB(0xe3e3e3);
        pickview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        pickview.layer.borderWidth = 0.5;
        pickview.autoresizingMask = UIViewAutoresizingNone;
        pickview.frame = CGRectMake(0, 40, kMainScreenWidth, 20);
        pickview.showsSelectionIndicator = YES;
        [pickBg addSubview:pickview];
        
        UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
        toolBar.backgroundColor = UIColorFromRGB(0xe3e3e3);
        toolBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        toolBar.layer.borderWidth = 0.5;
        [pickBg addSubview:toolBar];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(kMainScreenWidth-80, 0, 60, 40);
        [toolBar addSubview:finishBtn];
        [finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.tag  = 101;
        leftBtn.frame = CGRectMake(20, 0, 40, 40);
        leftBtn.transform = CGAffineTransformMakeRotation(M_PI);
        [leftBtn setImage:ImageWithName(@"cell_arrows") forState:UIControlStateNormal];
        [toolBar addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag  = 102;
        rightBtn.frame = CGRectMake(80, 0, 40, 40);
        [rightBtn setImage:ImageWithName(@"cell_arrows") forState:UIControlStateNormal];
        [toolBar addSubview:rightBtn];
        [rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [toolBar release];
        self.hidden = YES;
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 101) {
        //

        int select = [pickview selectedRowInComponent:0];
        
        if (select > 0) {
            [pickview selectRow:select-1 inComponent:0 animated:YES];
        }
    }
    else if (sender.tag == 102) {
        int sum = [pickview.dataSource pickerView:pickview numberOfRowsInComponent:0];
        int select = [pickview selectedRowInComponent:0];
        if (select < sum) {
            [pickview selectRow:select+1 inComponent:0 animated:YES];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

- (void)finishBtnClick:(id)sender
{
    [self hide];
    
    if (_delegate && [_delegate respondsToSelector:@selector(customPickView:didSelect:)]) {
        
        int select = [pickview selectedRowInComponent:0];
        
        [self.delegate customPickView:self didSelect:select];
    }
}

- (void)show
{
    _isShow = YES;
    self.hidden = NO;
    
    [UIView animateWithDuration:0.32 animations:^{
        //
        pickBg.frame = CGRectMake(0, CGRectGetHeight(self.frame)-200, kMainScreenWidth, 200);
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)hide
{
    _isShow = NO;
    
    [UIView animateWithDuration:0.32 animations:^{
        pickBg.frame = CGRectMake(0, CGRectGetHeight(self.frame), kMainScreenWidth, 200);
    } completion:^(BOOL finished) {
        //
        self.hidden = YES;
    }];
}

- (void)setDatasourse:(id<UIPickerViewDataSource>)datasourse
{
    pickview.dataSource = datasourse;
}

- (void)setDelegate:(id<UIPickerViewDelegate,CustomPickViewDelegate>)delegate
{
    _delegate = delegate;
    pickview.delegate = delegate;
}

- (void)reloadData
{
    [pickview reloadAllComponents];
}

- (void)dealloc
{
    pickview.delegate = nil;
    RELEASE_SAFELY(pickview);
    RELEASE_SAFELY(pickBg);
    self.delegate = nil;
    self.datasourse = nil;
    
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
