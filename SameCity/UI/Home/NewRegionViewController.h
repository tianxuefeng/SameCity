//
//  NewRegionViewController.h
//  samecity
//
//  Created by zengchao on 14-8-3.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonTextField.h"

@class NewRegionViewController;

@protocol NewRegionViewControllerDelegate <NSObject>

- (void)newRegionViewController:(NewRegionViewController *)target add:(NSString *)newText;

@end

@interface NewRegionViewController : CommonViewController
{
    CommonTextField *textField;
}

@property (nonatomic ,retain) NSString *originalText;

@property (nonatomic ,retain) NSString *ID;

@property (nonatomic ,assign) id<NewRegionViewControllerDelegate> delegate;

@end
