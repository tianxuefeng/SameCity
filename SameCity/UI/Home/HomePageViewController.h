//
//  IndexViewController.h
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "HttpService.h"
#import "CategoryData.h"

@interface HomePageViewController : CommonViewController<UICollectionViewDataSource,UICollectionViewDelegate,HttpServiceDelegate>
{
//    UIScrollView *functionBg;
    
    UICollectionView *collectView;
    
    UILabel *defaultCityLb;
    
    CategoryData *categoryData;
    
    BOOL isLoaded;
}

@end
