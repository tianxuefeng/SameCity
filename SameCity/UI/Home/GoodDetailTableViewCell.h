//
//  GoodDetailTableViewCell.h
//  samecity
//
//  Created by zengchao on 14-8-3.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDetailTableViewCell : UITableViewCell

@property (nonatomic ,retain) UILabel *contentLb;

- (void)reloadUI;

+ (CGFloat)getCellheight:(NSString *)contentStr;

@end

@interface GoodDetailTableViewCell2 : UITableViewCell

@property (nonatomic ,retain) UILabel *titleLb;

@property (nonatomic ,retain) UILabel *contentLb;

@property (nonatomic ,retain) UILabel *titleLb2;

@property (nonatomic ,retain) UILabel *contentLb2;

@end
