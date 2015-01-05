//
//  WFIndexBanner.m
//  Wifi
//
//  Created by zengchao on 13-12-3.
//  Copyright (c) 2013年 zengchao. All rights reserved.
//

#import "WFIndexBanner.h"
#import "UIImageView+WebCache.h"



@implementation WFIndexModel

- (void)dealloc
{
    RELEASE_SAFELY(_url);
    RELEASE_SAFELY(_title);
    
    [super dealloc];
}

@end

@implementation WFIndexBanner

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    if (timer && [timer isValid]) {
//        [timer invalidate];
//    }
//    RELEASE_SAFELY(timer);
    RELEASE_SAFELY(_slideImages);
//    RELEASE_SAFELY(_slideLabels);
    RELEASE_SAFELY(_scrollView);
    RELEASE_SAFELY(_pageControl);
    self.dataSourse = nil;
    self.delegate = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, frame.origin.y, kMainScreenWidth, WFBANNER_HEIGHT)];
    if (self) {
        // Initialization code
        self.backgroundColor = COLOR_BG;
        self.clipsToBounds = YES;
        
        _slideImages = [[NSMutableArray alloc] init];
//        _slideLabels = [[NSMutableArray alloc] init];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 155+12+TITLE_HEIGHT)];
//        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.bounces = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
//        _scrollView.decelerationRate = 0.2;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
//        [_scrollView.panGestureRecognizer addTarget:self action:@selector(gesTouched:)];
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10,self.frame.size.height-16,kMainScreenWidth-20,16)]; // 初始化mypagecontrol
//        _pageControl.alignment = SMPageControlAlignmentRight;
//        _pageControl.pageIndicatorImage = ImageWithName(@"banner_n.png");
//        _pageControl.currentPageIndicatorImage = ImageWithName(@"banner_s.png");
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPageIndicatorTintColor = COLOR_THEME;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
        [self addSubview:_pageControl];
        
        [self reloadData];
    }
    return self;
}

- (void)reloadData
{
    _pageControl.numberOfPages = [self.dataSourse numberOfIndexBanner:self];
    if (_pageControl.numberOfPages > 5) {
        _pageControl.numberOfPages = 5;
    }
    for (UIView *tView in _scrollView.subviews) {
        if ([tView isKindOfClass:[UIImageView class]]) {
            [tView removeFromSuperview];
        }
    }
    [_slideImages removeAllObjects];
//    [_slideLabels removeAllObjects];
    
    for (int i=0; i<_pageControl.numberOfPages; i++) {
        
//        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake((320 * i)+320, 0, TITLE_HEIGHT, TITLE_HEIGHT)];
//        star.image = ImageWithName(@"star_tag");
//        [_scrollView addSubview:star];
//        [star release];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((320 * i) + 320+TITLE_HEIGHT, 0, 320-TITLE_HEIGHT, TITLE_HEIGHT)];
//        label.font = [UIFont systemFontOfSize:15];
//        [_slideLabels addObject:label];
//        [_scrollView addSubview:label];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth * i) + kMainScreenWidth, TITLE_HEIGHT, kMainScreenWidth, 155+12)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.userInteractionEnabled = YES;
        [_slideImages addObject:imgView];
        [_scrollView addSubview:imgView];
        
        WFIndexModel *wfModel = [self.dataSourse indexBannerImageURL:self ofIndex:i];
        
        if (wfModel) {
            //标题
//            label.text = wfModel.title;
            //图片
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouch:)];
            [imgView addGestureRecognizer:tap];
            [tap release];

            __unsafe_unretained UIImageView *weak_imgView = imgView;
            
            [imgView sd_setImageWithURL:wfModel.url placeholderImage:ImageWithName(@"test_image") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //
                if (cacheType == SDImageCacheTypeNone) {
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.32;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = kCATransitionFade;
                    animation.removedOnCompletion = YES;
                    [[weak_imgView layer] addAnimation:animation forKey:@"animation"];
                }
            }];
        }
//        [label release];
        [imgView release];
    }
    
    _scrollView.scrollEnabled = NO;
    if (_pageControl.numberOfPages > 1) {
        
        _scrollView.scrollEnabled = YES;
        // 取数组最后一张图片 放在第0页
        UIImageView *imageViewL = [[UIImageView alloc] init];
        imageViewL.clipsToBounds = YES;
        imageViewL.contentMode = UIViewContentModeScaleAspectFill;
        imageViewL.userInteractionEnabled = YES;
        // 取数组第一张图片 放在最后1页
        UIImageView *imageViewR = [[UIImageView alloc] init];
        imageViewR.userInteractionEnabled = YES;
        imageViewR.contentMode = UIViewContentModeScaleAspectFill;
        imageViewR.clipsToBounds = YES;
        
        //    UILabel *labelL = [[UILabel alloc] init];
        //    UILabel *labelR = [[UILabel alloc] init];
        //
        //    UIImageView *starL = [[UIImageView alloc] init];
        //    UIImageView *starR = [[UIImageView alloc] init];
        
        
        
        if (_pageControl.numberOfPages > 0) {
            
            //        starL.frame = CGRectMake(0, 0, TITLE_HEIGHT, TITLE_HEIGHT);
            //        starL.image = ImageWithName(@"star_tag");
            //        [_scrollView addSubview:starL];
            
            imageViewL.frame = CGRectMake(0, TITLE_HEIGHT, kMainScreenWidth, 155+12); // 添加最后1页在首页 循环
            [_scrollView addSubview:imageViewL];
            
            //        labelL.font = [UIFont systemFontOfSize:15];
            //        labelL.frame = CGRectMake(TITLE_HEIGHT, 0, 320-TITLE_HEIGHT, TITLE_HEIGHT);
            //        [_scrollView addSubview:labelL];
            
            WFIndexModel *model1 = [self.dataSourse indexBannerImageURL:self ofIndex:_pageControl.numberOfPages-1];
            
            if (model1) {
                //标题
                //             labelL.text = model1.title;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouch:)];
                [imageViewL addGestureRecognizer:tap];
                [tap release];
                
                __unsafe_unretained UIImageView *weak_imageViewL = imageViewL;
                
                [imageViewL sd_setImageWithURL:model1.url placeholderImage:ImageWithName(@"test_image") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    //
                    if (cacheType == SDImageCacheTypeNone) {
                        CATransition *animation = [CATransition animation];
                        animation.duration = 0.32;
                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
                        animation.type = kCATransitionFade;
                        animation.removedOnCompletion = YES;
                        [[weak_imageViewL layer] addAnimation:animation forKey:@"animation"];
                    }
                }];
                
//                //图片
//                [imageViewL setImageWithURL:model1.url placeholderImage:ImageWithName(@"test_image") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                    if (cacheType == SDImageCacheTypeNone) {
//                        CATransition *animation = [CATransition animation];
//                        animation.duration = 0.32;
//                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//                        animation.type = kCATransitionFade;
//                        animation.removedOnCompletion = YES;
//                        [[imageViewL layer] addAnimation:animation forKey:@"animation"];
//                    }
//                }];
            }
            
            //        starR.frame = CGRectMake((320 * ([_slideImages count] + 1)), 0, TITLE_HEIGHT, TITLE_HEIGHT);
            //        starR.image = ImageWithName(@"star_tag");
            //        [_scrollView addSubview:starR];
            
            imageViewR.frame = CGRectMake((kMainScreenWidth * ([_slideImages count] + 1)) , TITLE_HEIGHT, kMainScreenWidth, 155+12); // 添加第1页在最后 循环
            [_scrollView addSubview:imageViewR];
            
            //        labelR.font = [UIFont systemFontOfSize:15];
            //        labelR.frame = CGRectMake((320 * ([_slideImages count] + 1)) +TITLE_HEIGHT, 0, 320-TITLE_HEIGHT, TITLE_HEIGHT);
            //        [_scrollView addSubview:labelR];
            
            WFIndexModel *model2 = [self.dataSourse indexBannerImageURL:self ofIndex:0];
            
            if (model2) {
                
                //            labelR.text = model2.title;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouch:)];
                [imageViewR addGestureRecognizer:tap];
                [tap release];
                
                __unsafe_unretained UIImageView *weak_imageViewR = imageViewR;
                
                [imageViewR sd_setImageWithURL:model2.url placeholderImage:ImageWithName(@"test_image") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    //
                    if (cacheType == SDImageCacheTypeNone) {
                        CATransition *animation = [CATransition animation];
                        animation.duration = 0.32;
                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
                        animation.type = kCATransitionFade;
                        animation.removedOnCompletion = YES;
                        [[weak_imageViewR layer] addAnimation:animation forKey:@"animation"];
                    }
                }];
                
//                [imageViewR setImageWithURL:model2.url placeholderImage:ImageWithName(@"test_image") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                    if (cacheType == SDImageCacheTypeNone) {
//                        CATransition *animation = [CATransition animation];
//                        animation.duration = 0.32;
//                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//                        animation.type = kCATransitionFade;
//                        animation.removedOnCompletion = YES;
//                        [[imageViewR layer] addAnimation:animation forKey:@"animation"];
//                    }
//                }];
            }
        }
        
        [imageViewL release];
        [imageViewR release];

    }
   //    [labelL release];
//    [labelR release];
//    [starL release];
//    [starR release];
    
    [_scrollView setContentSize:CGSizeMake(kMainScreenWidth * ([_slideImages count] + 2), CGRectGetHeight(_scrollView.frame))]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [_scrollView setContentOffset:CGPointMake(kMainScreenWidth, 0) animated:NO];
//    [_scrollView scrollRectToVisible:CGRectMake(320,0,320,155) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    
    [self updateLabelAnimation];

//    if (timer && [timer isValid]) {
//        [timer invalidate];
//    }
//    RELEASE_SAFELY(timer);
//    timer = [[NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES] retain];
}

//- (void)gesTouched:(UIPanGestureRecognizer *)ges
//{
//    if (ges.state == UIGestureRecognizerStateBegan) {
//        //
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
////        [self pauseTimer];
//    }
//    else if (ges.state == UIGestureRecognizerStateEnded) {
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
////        [self performSelector:@selector(resumeTimer) withObject:nil afterDelay:6];
//    }
//    else if (ges.state == UIGestureRecognizerStateCancelled) {
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
////        [self performSelector:@selector(resumeTimer) withObject:nil afterDelay:6];
//    }
//    else if (ges.state == UIGestureRecognizerStateFailed) {
//        
//    }
//}

//-(void)pauseTimer{
//    
//    if (!timer) {
//        return ;
//    }
//    
//    if (![timer isValid]) {
//        return;
//    }
////    [timer invalidate];
//    NSLog(@"暂停");
//    
//   [timer setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
//}


//-(void)resumeTimer{
//    
//    if (!timer) {
//        return ;
//    }
//    
//    if (![timer isValid]) {
//        return;
//    }
//    
//    NSLog(@"开始");
////    [timer fire];
//    [timer setFireDate:[NSDate date]];
//}


// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDecelerating) {
        CGPoint point = _scrollView.contentOffset;
        point.y = 0;
        if (_pageControl.numberOfPages > 0)
        {
            if (point.x >= ITEM_WIDTH * (_pageControl.numberOfPages+1)) {
                  [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH, 0) animated:NO];
            }
            else if (point.x <= 0)
            {
                [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH*(_pageControl.numberOfPages), 0) animated:NO];
            }
        }
        
//        if (_delegate && [_delegate respondsToSelector:@selector(indexBanner:displayPage:)]) {
//            [self.delegate indexBanner:self displayPage:_pageControl.currentPage];
//        }
    }
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f...%f",_scrollView.contentOffset.x,ITEM_WIDTH * (_pageControl.numberOfPages));
    
    int page = floor(_scrollView.contentOffset.x/ITEM_WIDTH);
    if (page == 0) {
        _pageControl.currentPage = _pageControl.numberOfPages-1;
    }
    else if (page == _pageControl.numberOfPages+1) {
        _pageControl.currentPage = 0;
    }
    else {
        _pageControl.currentPage = page-1;
    }
    
    NSLog(@"%d",_pageControl.currentPage);
    
     [self updateLabelAnimation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(indexBanner:displayPage:)]) {
        [self.delegate indexBanner:self displayPage:_pageControl.currentPage];
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}

- (void)imageTouch:(UIGestureRecognizer *)ges
{
    if (_delegate && [_delegate respondsToSelector:@selector(indexBanner:SelectPage:AndImageView:)]) {
        [self.delegate indexBanner:self SelectPage:_pageControl.currentPage AndImageView:ges.view];
    }
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)_pageControl.currentPage; // 获取当前的page
    
    [UIView animateWithDuration:0.32 animations:^{
          [_scrollView setContentOffset:CGPointMake(kMainScreenWidth*(page+1),0) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
    }];
    
    [self updateLabelAnimation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(indexBanner:displayPage:)]) {
        [self.delegate indexBanner:self displayPage:_pageControl.currentPage];
    }
}

- (void)updateLabelAnimation
{
//    for (UILabel *tmp in _slideLabels) {
//        [tmp.layer removeAllAnimations];
//    }
    
//    if (_pageControl.currentPage < _slideLabels.count) {
//        UILabel *labelShow = _slideLabels[_pageControl.currentPage];
//        
//        CGRect frame = labelShow.frame;
//        frame.origin.x = 350;
//        labelShow.frame = frame;
//        
//        [UIView beginAnimations:@"testAnimation" context:NULL];
//        [UIView setAnimationDuration:8.8f];
//        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//        [UIView setAnimationRepeatAutoreverses:NO];
//        [UIView setAnimationRepeatCount:999999];
//        frame = labelShow.frame;
//        frame.origin.x = -180;
//        labelShow.frame = frame;
//        [UIView commitAnimations];
//    }
}

//// 定时器 绑定的方法
//- (void)runTimePage
//{
//    int page = (int)_pageControl.currentPage; // 获取当前的page
//    page++;
//    page = page >= _pageControl.numberOfPages ? 0 : page ;
//    
//    CGPoint point = _scrollView.contentOffset;
//    point.y = 0;
//    if (_pageControl.numberOfPages > 0)
//    {
////        NSLog(@"%f...%f",point.x,ITEM_WIDTH * (_pageControl.numberOfPages));
//        if (point.x >= ITEM_WIDTH * (_pageControl.numberOfPages)) {
//            [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH*(_pageControl.numberOfPages+1), 0) animated:YES];
//            [self performSelector:@selector(scrollTohaha) withObject:nil afterDelay:1.5];
//        }
//        else
//        {
//            [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH*(page+1), 0) animated:YES];
//        }
//      
//    }
//    
//    _pageControl.currentPage = page;
//}

- (void)scrollTohaha
{
      [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH, 0) animated:NO];
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
