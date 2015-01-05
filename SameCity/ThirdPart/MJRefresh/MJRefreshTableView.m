//
//  RefreshTableView.m
//  LohasYangZhou
//
//  Created by zengchao on 14-8-25.
//  Copyright (c) 2014年 com.xweisoft. All rights reserved.
//

#import "MJRefreshTableView.h"
#import "XHRefreshControl.h"
#import "NSDate+TimeAgo.h"

@interface MJRefreshTableView()<XHRefreshControlDelegate>

@property (nonatomic, strong) XHRefreshControl *refreshControl;

@end

@implementation MJRefreshTableView

- (void)startPullDownRefreshing {
    
    fromHead = YES;
    [self.refreshControl startPullDownRefreshing];
}

- (void)endRefreshingAndReloadData {
    
    if ([NSThread isMainThread]) {
        [self reloadData];
        
        if (self.status == XHPullDownRefreshViewStatusRefreshing) {
            
            [self.refreshControl endPullDownRefreshing];
            [self.refreshControl endLoadMoreRefresing];
            
        }
        else {
            [self.refreshControl endLoadMoreRefresing];
        }
        _status = XHPullDownRefreshViewStatusNone;
    }
    else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self reloadData];
            
            if (self.status == XHPullDownRefreshViewStatusRefreshing) {
                
                [self.refreshControl endPullDownRefreshing];
                [self.refreshControl endLoadMoreRefresing];
                
            }
            else {
                [self.refreshControl endLoadMoreRefresing];
            }
            _status = XHPullDownRefreshViewStatusNone;
            
        });
    }
    fromHead = NO;
}


- (void)endRefreshingAndReloadDataNoMore
{
    if ([NSThread isMainThread]) {
        [self reloadData];
        
        if (self.status == XHPullDownRefreshViewStatusRefreshing) {
            
            [self.refreshControl endPullDownRefreshing];
            [self.refreshControl endMoreOverWithMessage:@""];
            
        }
        else {
            [self.refreshControl endMoreOverWithMessage:@""];
        }
        _status = XHPullDownRefreshViewStatusNone;
    }
    else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self reloadData];
            
            if (self.status == XHPullDownRefreshViewStatusRefreshing) {
                
                [self.refreshControl endPullDownRefreshing];
                [self.refreshControl endMoreOverWithMessage:@""];
                
            }
            else {
                [self.refreshControl endMoreOverWithMessage:@""];
            }
            _status = XHPullDownRefreshViewStatusNone;
            
        });
    }
    fromHead = NO;
}

- (void)endMoreOverWithMessage:(NSString *)message {
    [self.refreshControl endMoreOverWithMessage:message];
}

- (void)handleLoadMoreError {
    [self.refreshControl handleLoadMoreError];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        
        self.backgroundColor = COLOR_BG;
        
        self.pullDownRefreshed = YES;
        self.loadMoreRefreshed = YES;
        //        self.refreshViewType = XHPullDownRefreshViewTypeCircle;
        _status = XHPullDownRefreshViewStatusNone;
        
        [self setupRefreshControl];
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = COLOR_BG;
    
    self.pullDownRefreshed = YES;
    self.loadMoreRefreshed = YES;
    
    _status = XHPullDownRefreshViewStatusNone;
    
    [self setupRefreshControl];
}

- (void)setupRefreshControl {
    if (!_refreshControl) {
        
        _refreshControl = [[XHRefreshControl alloc] initWithScrollView:self delegate:self];
        _refreshControl.circleColor = COLOR_THEME;
        _refreshControl.circleLineWidth = 1;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
}

- (void)removeFromSuperview
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.refreshControl = nil;
    self.mjdelegate = nil;
    [super removeFromSuperview];
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.refreshControl = nil;
    self.mjdelegate = nil;
}

#pragma mark - XHRefreshControl Delegate

- (void)beginPullDownRefreshing {
    
    self.requestCurrentPage = 0;
    
    _status = XHPullDownRefreshViewStatusRefreshing;
    
    if (fromHead) {
        [self performSelector:@selector(pullDownDelay) withObject:nil afterDelay:0.5];
    }
    else {
        [self pullDownDelay];
    }
}

- (void)pullDownDelay
{
    if (_mjdelegate && [_mjdelegate respondsToSelector:@selector(MJRefreshTableViewStartRefreshing:)]) {
        [self.mjdelegate MJRefreshTableViewStartRefreshing:self];
    }
}

- (void)beginLoadMoreRefreshing {
    
    _status = XHPullDownRefreshViewStatusLoadingMore;
    
    if (_mjdelegate && [_mjdelegate respondsToSelector:@selector(MJRefreshTableViewDidStartLoading:)]) {
        [self.mjdelegate MJRefreshTableViewDidStartLoading:self];
    }
}

- (NSString *)lastUpdateTimeString {
    
    NSDate *nowDate = [NSDate date];
    
    NSString *destDateString = [nowDate timeAgo];
    
    return destDateString;
}

- (NSInteger)autoLoadMoreRefreshedCountConverManual {
    return 999;
}

- (BOOL)isPullDownRefreshed {
    return self.pullDownRefreshed;
}

- (BOOL)isLoadMoreRefreshed {
    return self.loadMoreRefreshed;
}

- (XHRefreshViewLayerType)refreshViewLayerType {
    return XHRefreshViewLayerTypeOnScrollViews;
}

- (XHPullDownRefreshViewType)pullDownRefreshViewType {
    return self.refreshViewType;
}

- (NSString *)displayAutoLoadMoreRefreshedMessage {
    return @"点击加载更多";
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
