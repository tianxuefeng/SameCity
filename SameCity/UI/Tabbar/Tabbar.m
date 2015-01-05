//
//  Tabbar.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "Tabbar.h"
#import "UIImage+extend.h"

@implementation Tabbar

@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;
@synthesize titles = _titles;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray andButtonTitles:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = COLOR_BG;
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
        
        slideImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        slideImgView.backgroundColor = COLOR_THEME;
        slideImgView.image = [ImageWithName(@"tab_select.png") adjustSize];
        [self addSubview:slideImgView];
        
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
        self.titles = [NSMutableArray arrayWithCapacity:[titleArray count]];
		
        UIButton *btn;
        UILabel *titleLb;
		CGFloat width =kMainScreenWidth / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.showsTouchWhenHighlighted = NO;
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height+2);
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 12, 0)];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
        
        for (int i = 0; i < [titleArray count]; i++)
		{
            titleLb = [[UILabel alloc] initWithFrame:CGRectMake(width * i, frame.size.height-23, width, 23)];
            titleLb.tag = 10+i;
            titleLb.backgroundColor = [UIColor clearColor];
            titleLb.font = [UIFont boldSystemFontOfSize:11];
            titleLb.textAlignment = NSTextAlignmentCenter;
            titleLb.text = titleArray[i];
            titleLb.textColor = UIColorFromRGB(0xA1A09E);
            titleLb.highlightedTextColor = [UIColor whiteColor];
            [self.titles addObject:titleLb];
            [self addSubview:titleLb];
            [titleLb release];
        }
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
    if (img) {
        [_backgroundView setImage:[img adjustSize]];
    }
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
    NSLog(@"Select index: %d",btn.tag);
    if (_delegate && [_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
//		b.userInteractionEnabled = YES;
	}
    
    for (int i = 0; i < [self.titles count]; i++)
	{
		UILabel *l = [self.titles objectAtIndex:i];
		l.highlighted = NO;
	}
    
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
//	btn.userInteractionEnabled = NO;
    
    if (self.titles.count > index) {
        UILabel *lb = [self.titles objectAtIndex:index];
        lb.highlighted = YES;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        //
        slideImgView.frame = btn.frame;
    }];
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
    
    // Re-index the buttons
    CGFloat width = kMainScreenWidth / [self.buttons count];
    for (UIButton *btn in self.buttons)
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = kMainScreenWidth / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons)
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [slideImgView release];
    [_buttons release];
    [_titles release];
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
