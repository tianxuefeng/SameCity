//
//  CitysViewController.h
//  aiyou
//
//  Created by zengchao on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DataManagerCenter.h"
#import "Province.h"
#import "CommonViewController.h"
#import "CustomSearchbar.h"
#import "RegionData.h"

@protocol CitysViewControllerDelegate <NSObject>

- (void)CityDidSelect:(CityDto *)Dto;

@end

@interface CitysViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,HttpServiceDelegate>
{
    UIImageView *_tableIndexTitleView;
    UILabel     *_tableIndexTitleLabel;
    NSTimer     *_tableIndexTitleTimer;
    
    BOOL bIsSearching;
    int searchTextLength;                //搜索长度
    NSString *_oldSearchStr;
}

@property (nonatomic ,assign) id<CitysViewControllerDelegate>delegate;

@property (nonatomic ,assign) NSMutableArray *sectionArray;             //section集合     所有联系人
//@property (nonatomic ,assign) NSMutableArray *sectionArray;         //section数目     所有联系人
@property (nonatomic ,assign) NSMutableArray *sectionDataArray;     //分组的联系人数据   所有联系人

@property (nonatomic ,retain) NSMutableArray *filterContactArray;   //存放搜索的联系人数组
@property (nonatomic ,retain) NSMutableArray *searchSectionArray;   //搜索之后的section数组

@property (nonatomic ,retain) UITableView *cityTable;
@property (nonatomic ,retain) CustomSearchbar *searchBar;
@property (nonatomic ,retain) UISearchDisplayController *searchDisplayControl;

@end

//@interface CityNaviController : UINavigationController
//
//@property (nonatomic ,retain) CitysViewController *cityVC;
//@end
