//
//  ReplyView.h
//  BBYT
//
//  Created by zengchao on 14-3-15.
//  Copyright (c) 2014年 babyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@class ReplyView;

@protocol ReplyViewDelegate <NSObject>

@optional
- (void)replyViewBeginEditing:(ReplyView *)target;
- (void)replyViewDidSend:(ReplyView *)target;
- (void)replyViewDidChanged:(ReplyView *)target;

@end

@interface ReplyView : UIView<HPGrowingTextViewDelegate>
{
    HPGrowingTextView *textView;
    
    BOOL isFirst;
    
    CGRect originalFrame;
    
//    NSString *saveString;
}

@property (nonatomic ,assign) id<ReplyViewDelegate>delegate;

@property (nonatomic ,retain) NSString *placeholder;

@property (nonatomic ,retain) NSString *text;

@property (nonatomic ,retain) UIButton *doneBtn;

- (void)becomeTextView;

- (void)resignTextView;

- (BOOL)isTextFirstResponder;

@end
