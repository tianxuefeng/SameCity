//
//  RegionViewController.h
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "RegionData.h"
#import "CustomRegionItem.h"
#import "YLEditBottomView.h"

@class RegionViewController;

@protocol RegionViewControllerDelegate <NSObject>

- (void)region:(RegionViewController *)target select:(CustomRegionItem *)region;

@end

@interface RegionViewController : CommonViewController<HttpServiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    RegionData *regionData;
    RegionData *regionData2;
    RegionData *addRegionRequest;
    
    UITableView *regionTableView;
    
//    YLEditBottomView *editBottomView;
}

@property (nonatomic ,retain) NSString *cityName;

@property (nonatomic ,retain) NSString *cityId;

@property (nonatomic ,assign) id<RegionViewControllerDelegate>delegate;

@property (nonatomic ,retain) NSMutableArray *items;

@property (nonatomic ,retain) NSMutableArray *items1;
@property (nonatomic ,retain) NSMutableArray *items2;

@end
