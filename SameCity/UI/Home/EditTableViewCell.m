//
//  EditTableViewCell.m
//  samecity
//
//  Created by zengchao on 14-10-13.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "EditTableViewCell.h"

@interface EditTableViewCell ()

//flag
@property (nonatomic,retain) UIPanGestureRecognizer *panGesture;
@property (nonatomic,assign) CGFloat initialHorizontalCenter;
@property (nonatomic,assign) CGFloat initialTouchPositionX;
@property (nonatomic,retain) UIView *bottomView;
@property (nonatomic,assign) CGFloat originalCenter;
@property (nonatomic,assign) FeedCellDirection lastDirection;

@end

@implementation EditTableViewCell

//@synthesize bottomView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, DEFAULT_CELL_HEIGHT)];
        bottom.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottom];
        
//        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
//        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
//        iconImageView.image = ImageWithName(@"checked_btn_off");
//        [bottom addSubview:iconImageView];
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
        _panGesture.delegate = self;
        [bottom addGestureRecognizer:_panGesture];
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kMainScreenWidth-20, DEFAULT_CELL_HEIGHT-10)];
        self.titleLb.font = [UIFont systemFontOfSize:16];
        self.titleLb.backgroundColor = [UIColor clearColor];
        self.titleLb.textColor = COLOR_TITLE;
        [bottom addSubview:self.titleLb];
        
        _originalCenter = kMainScreenWidth*0.5;
        _currentStatus = kFeedStatusNormal;
        
//        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 100)];
//        bottomView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:bottomView];
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, DEFAULT_CELL_HEIGHT-1, kMainScreenWidth, 1)];
        line.image = ImageWithName(@"cell_foot_lb_bg");
        [self.contentView addSubview:line];
        [line release];
    
    }
    return self;
}

-(void)layoutBottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, DEFAULT_CELL_HEIGHT)];
        _bottomView.backgroundColor = COLOR_BG;
        [self.contentView insertSubview:_bottomView atIndex:0];
        
//        shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        shareBtn.tag = 200;
//        shareBtn.exclusiveTouch = YES;
//        shareBtn.translatesAutoresizingMaskIntoConstraints = NO;
//        //        shareBtn.frame = CGRectMake(kMainScreenWidth*0.5+10, 0, 50, self.bounds.size.height);
//        [shareBtn setImage:ImageWithName(@"down_share_icon") forState:UIControlStateNormal];
//        [_bottomView addSubview:shareBtn];
//        [shareBtn addTarget:self action:@selector(fuctionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        updateBtn.tag = 201;
        updateBtn.exclusiveTouch = YES;
//        updateBtn.translatesAutoresizingMaskIntoConstraints = NO;
        updateBtn.frame = CGRectMake(kMainScreenWidth*0.5, 0, 80, self.bounds.size.height);
//        [updateBtn setImage:ImageWithName(@"down_collect_icon") forState:UIControlStateNormal];
        
        updateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [updateBtn setImage:ImageWithName(@"edit_button") forState:UIControlStateNormal];
        [updateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [updateBtn setTitle:NSLocalizedString(btn_edit, nil) forState:UIControlStateNormal];
        updateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [_bottomView addSubview:updateBtn];
        [updateBtn addTarget:self action:@selector(fuctionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.tag = 202;
        deleteBtn.exclusiveTouch = YES;
//        deleteBtn.translatesAutoresizingMaskIntoConstraints = NO;
        deleteBtn.frame = CGRectMake(kMainScreenWidth*0.5+80, 0, 80, self.bounds.size.height);
//        [deleteBtn setImage:ImageWithName(@"down_delete_icon") forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleteBtn setImage:ImageWithName(@"delete_btn_icon") forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deleteBtn setTitle:NSLocalizedString(title_delete, nil) forState:UIControlStateNormal];
        deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [_bottomView addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(fuctionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    }
}

- (void)fuctionBtnClick:(UIButton *)sender
{
    if (sender.tag == 200) {

    }
    else if (sender.tag == 201) {

        if (_delegate && [_delegate respondsToSelector:@selector(EditCellUpdate:)]) {
            [self.delegate EditCellUpdate:self];
        }
    }
    else if (sender.tag == 202) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(EditCellDelete:)]) {
            [self.delegate EditCellDelete:self];
        }
    }
}

//#define kMinimumVelocity  self.contentView.frame.size.width*1.5
#define kMinimumPan       60.0
#define kBOUNCE_DISTANCE  10.0

#pragma mark -- Ges
- (void)panGestureHandle:(UIPanGestureRecognizer *)recognizer
{
    //begin pan...
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _initialTouchPositionX = [recognizer locationInView:self].x;
        _initialHorizontalCenter = bottom.center.x;
        if(_currentStatus==kFeedStatusNormal){
            [self layoutBottomView];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(EditCellShowMenu:)]) {
            [self.delegate EditCellShowMenu:self];
        }
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged) { //status change
        
        CGFloat panAmount  = _initialTouchPositionX - [recognizer locationInView:self].x;
        CGFloat newCenterPosition     = _initialHorizontalCenter - panAmount;
        CGFloat centerX               = bottom.center.x;
        
        
        if(centerX>_originalCenter && _currentStatus!=kFeedStatusLeftExpanding){
            _currentStatus = kFeedStatusLeftExpanding;
            [self togglePanelWithFlag];
        }
        
        if (panAmount > 0){
            _lastDirection = FeedCellDirectionLeft;
            
            if (newCenterPosition > self.bounds.size.width + _originalCenter){
                newCenterPosition = self.bounds.size.width + _originalCenter;
            }
            else if (newCenterPosition < -_originalCenter){
                newCenterPosition = _originalCenter;
            }
        }
        else{
            _lastDirection = FeedCellDirectionRight;
            
            if (newCenterPosition >  _originalCenter){
                newCenterPosition =  _originalCenter;
            }
            else if (newCenterPosition < -_originalCenter){
                newCenterPosition = _originalCenter;
            }
        }
        
        CGPoint center = bottom.center;
        center.x = newCenterPosition;
        bottom.layer.position = center;
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
             recognizer.state == UIGestureRecognizerStateCancelled){
        
        if (fabsf(bottom.center.x - _originalCenter) > kMinimumPan) {
            //
            [self _slideOutContentViewInDirection];
        }
        else {
            [self _slideInContentViewFromDirection];
        }
    }
}

- (void)togglePanelWithFlag{
    switch (_currentStatus) {
        case kFeedStatusNormal:{
            [_bottomView removeFromSuperview];
            RELEASE_SAFELY(_bottomView);
        }
        default:
            break;
    }
    
}

#pragma mark
#pragma mark - ContentView Sliding
- (void)_slideInContentViewFromDirection
{
    CGFloat bounceDistance = 0;
    
    if (bottom.center.x == _originalCenter)
        return;
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         bottom.frame = self.contentView.frame;
                     }
                     completion:^(BOOL f) {
                         _currentStatus=kFeedStatusNormal;
                         [self togglePanelWithFlag];
                     }];
}



- (void)_slideOutContentViewInDirection
{
    CGFloat newCenterX;
    CGFloat bounceDistance;
    
    newCenterX = kMainScreenWidth*0.5-160;
    bounceDistance = -kBOUNCE_DISTANCE;
    _currentStatus=kFeedStatusLeftExpanded;
    
    //    CGRect rect = self.contentView.frame;
    //         bottom.frame = CGRectOffset(rect, -20, 0);
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         bottom.center = CGPointMake(newCenterX, bottom.center.y);
                     }
                     completion:^(BOOL f) {
                         //                        NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
                         
                         [UIView animateWithDuration:0.1 delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              bottom.frame = CGRectOffset(bottom.frame, -bounceDistance, 0);
                                          }
                                          completion:^(BOOL f) {
                                              [UIView animateWithDuration:0.1 delay:0
                                                                  options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   bottom.frame = CGRectOffset(bottom.frame, bounceDistance, 0);
                                                               }
                                                               completion:NULL];
                                          }];
                     }];
}


#pragma mark
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == _panGesture) {
        UIScrollView *superview = (UIScrollView *)self.superview;
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:superview];
        // Make it scrolling horizontally
        return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO &&
                (superview.contentOffset.y == 0.0 && superview.contentOffset.x == 0.0));
    }
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
