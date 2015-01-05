//
//  HomePageListCell.h
//  SameCity
//
//  Created by zengchao on 14-5-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "HomePageItem.h"

@interface HomePageListCell : CommonTableViewCell
{
    UIImageView *iconImageView;
    
    UILabel *titleLb;
    
    UILabel *addressLb;
    
    UILabel *priceLb;
    
    UILabel *dateLb;
}

@property (nonatomic ,retain) HomePageItem *item;

@end
