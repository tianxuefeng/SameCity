//
//  HomePageCell.h
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryItem.h"

@interface HomePageCell : UICollectionViewCell
{
    UIImageView *iconImageView;
    UILabel *titleLb;
    
}

@property (nonatomic ,retain) CategoryItem *cItem;

//@property (nonatomic ,retain) NSArray *
@end
