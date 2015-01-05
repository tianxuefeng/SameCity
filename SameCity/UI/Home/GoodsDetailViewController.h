//
//  GoodsDetailViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "HomePageItem.h"
#import "MyFavData.h"
#import "WFIndexBanner.h"
#import <MessageUI/MessageUI.h>
#import "CustomInputTextField.h"
#import "YLSwitchTabView.h"
#import "MJRefreshTableView.h"
//#import "ReplyView.h"
#import "MessageData.h"
#import "CommonTextField.h"

@interface GoodsDetailViewController : CommonViewController<HttpServiceDelegate,WFIndexBannerDataSourse,WFIndexBannerDelegate,MFMessageComposeViewControllerDelegate,YLSwitchTabViewDataSourse,YLSwitchTabViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
//    UILabel *titleLabel;
    
    YLSwitchTabView *switchView;
    
    WFIndexBanner *indexBanner;
    
    UIScrollView *bgScrollView;
    UITableView *detailTableView;
    UITableView *commentTableView;
    
    MessageData *messageData;
    
//    ReplyView *containerView;

    MyFavData *myfavData;
    
    BOOL isRefreshing;
 
    UIView *replyView;
    CommonTextField *replyText;
    
    UIButton *locButton;
    
    UIWebView *callWebview;
}

@property (nonatomic ,retain) NSMutableArray *items;

@property (nonatomic ,retain) NSMutableArray *images;

@property (nonatomic ,retain) HomePageItem *item;

@property (nonatomic ,retain) NSString *prepareString;

@end
