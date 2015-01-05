//
//  PublishMediaView.m
//  BBYT
//
//  Created by zengchao on 14-3-8.
//  Copyright (c) 2014年 babyun. All rights reserved.
//

#import "PublishMediaView.h"

@implementation PublishMediaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _images = [[NSMutableArray alloc] init];
        
        imagesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imagesScrollView.showsHorizontalScrollIndicator = NO;
        imagesScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:imagesScrollView];
        
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(TAGH, TAGH*0.5, BTNWIDTH, BTNHIGHT);
        [addBtn setBackgroundImage:ImageWithName(@"input_add_icon") forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [imagesScrollView addSubview:addBtn];
    }
    return self;
}

- (void)dealloc
{
//    [self.layer removeAllAnimations];
    self.delegate = nil;
    RELEASE_SAFELY(_images);
    RELEASE_SAFELY(imagesScrollView);
    _maxNum = 0;
    [super dealloc];
}

- (void)addClick:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(publishMediaViewAddBtnClick:)]) {
        [_delegate publishMediaViewAddBtnClick:self];
    }
}

- (void)btnClicked:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(publishMediaViewImageBtnClick:index:)]) {
        [_delegate publishMediaViewImageBtnClick:self index:tap.view.tag-100];
    }
}

- (void)deleteImage:(int)index
{
    if (index < self.images.count) {
        
        [self.images removeObjectAtIndex:index];
        
        if (self.images.count < self.maxNum) {
            addBtn.hidden = NO;
            //        return;
        }
        
        UIView *deleteView = [imagesScrollView viewWithTag:index+100];
        if (deleteView) {
            [deleteView removeFromSuperview];
        }
        
        imagesScrollView.contentSize = CGSizeMake(TAGH+(BTNWIDTH+TAGH)*self.images.count, HIGHT);
        
        
        [UIView animateWithDuration:0.1 animations:^{
            
            int i = 0;
            
            for (UIView *tempView in imagesScrollView.subviews) {

                if ([tempView isKindOfClass:[UIImageView class]]) {
                    [tempView setFrame:CGRectMake(TAGH + (BTNWIDTH+TAGH)*i, TAGH*0.5, BTNWIDTH, BTNHIGHT)];
                    tempView.tag = i+100;
                    i++;
                }
            }
            [addBtn setFrame:CGRectMake(TAGH+(BTNWIDTH+TAGH)*i, TAGH*0.5, BTNWIDTH, BTNHIGHT)];
        }];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    [imagesScrollView setBackgroundColor:backgroundColor];
}

- (void)replaceImage:(UIImage *)image index:(int)index
{
    if (index < self.images.count) {
        UIImageView *replayView = (UIImageView *)[self viewWithTag:index+100];
        replayView.image = image;
    }
}

//- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr
//{
//    if (gr.state == UIGestureRecognizerStateBegan)
//    {
//        if (m_bTransform)
//            return;
//        
//        for (UIView *view in self.subviews)
//        {
//            //            view.userInteractionEnabled = YES;
//            for (UIView *v in view.subviews)
//            {
//                if ([v isMemberOfClass:[UIButton class]])
//                    [v setHidden:NO];
//            }
//        }
//        m_bTransform = YES;
////        [self BeginWobble];
//    }
//}
//
//-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
//{
//    if(m_bTransform==NO)
//        return;
//    
//    for (UIView *view in self.subviews)
//    {
//        //        view.userInteractionEnabled = NO;
//        for (UIView *v in view.subviews)
//        {
//            if ([v isMemberOfClass:[UIButton class]])
//                [v setHidden:YES];
//        }
//    }
//    m_bTransform = NO;
//    [self EndWobble];
//}


- (void)addImage:(UIImage *)image
{
//    [self EndWobble];
    
    if (!image) {
        return;
    }
    
    [self.images addObject:image];
    
    if (self.images.count >= self.maxNum) {
        addBtn.hidden = YES;
    }
    
    int i = self.images.count-1;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [imageView setFrame:CGRectMake(TAGH+(BTNWIDTH+TAGH)*i, TAGH*0.5, BTNWIDTH, BTNHIGHT)];
    imageView.tag = 100+i;
    imageView.image = [image scaleToSize:imageView.frame.size];
    [imagesScrollView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClicked:)];
    [imageView addGestureRecognizer:tap];
    [tap release];

    [imageView release];
    

    imagesScrollView.contentSize = CGSizeMake(TAGH*2+(BTNWIDTH+TAGH)*(i+2), HIGHT);
    
    [UIView animateWithDuration:0.1 animations:^{
        addBtn.frame = CGRectMake(TAGH+(BTNWIDTH+TAGH)*(i+1), TAGH*0.5, BTNWIDTH, BTNHIGHT);
        [imagesScrollView scrollRectToVisible:addBtn.frame animated:NO];
    }];
}

- (void)deleteAll
{
//    UIView *deleteView = [imagesScrollView viewWithTag:index+100];
    for (UIView *deleteView in imagesScrollView.subviews) {
        if ([deleteView isKindOfClass:[UIImageView class]]) {
            [deleteView removeFromSuperview];
        }
    }
    
    [self.images removeAllObjects];
    
    imagesScrollView.contentSize = CGSizeMake(TAGH+(BTNWIDTH+TAGH)*self.images.count, HIGHT);
    
    [UIView animateWithDuration:0.1 animations:^{

        [addBtn setFrame:CGRectMake(TAGH+(BTNWIDTH+TAGH)*0, TAGH*0.5, BTNWIDTH, BTNHIGHT)];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)BeginWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]]) {
            srand([[NSDate date] timeIntervalSince1970]);
            float rand=(float)random();
            CFTimeInterval t=rand*0.0000000001;
            [UIView animateWithDuration:0.1 delay:t options:0  animations:^
             {
                 view.transform=CGAffineTransformMakeRotation(-0.05);
             } completion:^(BOOL finished)
             {
                 [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
                  {
                      view.transform=CGAffineTransformMakeRotation(0.05);
                  } completion:^(BOOL finished) {}];
             }];
        }
    }
    [pool drain];
}

-(void)EndWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]]) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
             {
                 view.transform=CGAffineTransformIdentity;
//                 for (UIView *v in view.subviews)
//                 {
//                     if ([v isMemberOfClass:[UIButton class]]){
//                         [v setHidden:YES];
//                         break;
//                     }
//                 }
             } completion:^(BOOL finished) {}];
        }
    }
    [pool drain];
}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    
//    [self EndWobble];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
