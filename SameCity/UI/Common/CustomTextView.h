//
//  CustomTextView.h
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UIView<UITextViewDelegate>
{
    UIImageView *imageView;
    
    UITextView *ctextView;
    
    UILabel *holderLb;
}

@property (nonatomic ,retain) NSString *placeholder;

@property (nonatomic, retain) NSString *text;

@end
