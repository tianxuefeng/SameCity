//
//  RefreshTableView.h
//  LohasYangZhou
//
//  Created by zengchao on 14-8-25.
//  Copyright (c) 2014年 com.xweisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHRefreshControlHeader.h"

typedef NS_ENUM(NSInteger, XHPullDownRefreshViewStatus) {
    XHPullDownRefreshViewStatusNone = 0,
    XHPullDownRefreshViewStatusRefreshing = 1,
    XHPullDownRefreshViewStatusLoadingMore = 2,
};

@class MJRefreshTableView;

@protocol MJRefreshTableViewDelegate <NSObject>

- (void)MJRefreshTableViewStartRefreshing:(MJRefreshTableView *)target;
- (void)MJRefreshTableViewDidStartLoading:(MJRefreshTableView *)target;

@end

@interface MJRefreshTableView : UITableView
{
    BOOL fromHead;
}
@property (nonatomic ,assign ,readonly) XHPullDownRefreshViewStatus status;

@property (nonatomic ,weak) id<MJRefreshTableViewDelegate>mjdelegate;

/**
 *  是否支持下拉刷新
 */
@property (nonatomic, assign) BOOL pullDownRefreshed;

/**
 *  是否支持上拉刷新
 */
@property (nonatomic, assign) BOOL loadMoreRefreshed;

/**
 *  下拉刷新的样式
 */
@property (nonatomic, assign) XHPullDownRefreshViewType refreshViewType;

/**
 *  加载数据的页码
 */
@property (nonatomic, assign) NSInteger requestCurrentPage;


- (void)startPullDownRefreshing;

- (void)endRefreshingAndReloadData;

- (void)endRefreshingAndReloadDataNoMore;

- (void)endMoreOverWithMessage:(NSString *)message;

- (void)handleLoadMoreError;

@end
