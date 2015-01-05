//
//  GoodsDetailViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "AppDelegate.h"
#import "MessageViewController.h"
#import "UIImageView+WebCache.h"
#import "UserLogin.h"
#import "GoodDetailTableViewCell.h"
#import "MessageCell.h"
#import "Global.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import <MapKit/Mapkit.h>

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [callWebview stopLoading];
    RELEASE_SAFELY(callWebview);
    
    self.prepareString = nil;
    
    RELEASE_SAFELY(_items);
    RELEASE_SAFELY(_item);
    RELEASE_SAFELY(_images);
    
//    RELEASE_SAFELY(containerView);
    RELEASE_SAFELY(replyView);
    RELEASE_SAFELY(replyText);
    
    RELEASE_SAFELY(bgScrollView);
    RELEASE_SAFELY(detailTableView);
    RELEASE_SAFELY(commentTableView);
    

    RELEASE_SAFELY(myfavData);
    RELEASE_SAFELY(messageData);

//    RELEASE_SAFELY(titleLabel);
    RELEASE_SAFELY(locButton);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(lab_detail_info, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [UIBarButtonItem createBarButtonItemWithTitle:NSLocalizedString(btn_favorites, nil) target:self action:@selector(favBarItemAvtion:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)favBarItemAvtion:(id)sender
{
    if (!_item) {
        return;
    }
    if (!myfavData.isLoading) {
        [[UserLogin instanse] loginFrom:self succeed:^{
            //
            [self startLoading];
            
            [myfavData insertMyFav:self.item.ID];
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _images = [[NSMutableArray alloc] init];
    _items = [[NSMutableArray alloc] init];
    
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kMainScreenWidth-30, 30)];
//    titleLabel.font = [UIFont systemFontOfSize:18];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textColor = COLOR_TITLE;
//    [self.view addSubview:titleLabel];
//    if (_item) {
//        titleLabel.text = self.item.Title;
//    }
    
    
    switchView = [[YLSwitchTabView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
    switchView.dataSourse = self;
    switchView.delegate = self;
    [self.view addSubview:switchView];
    [switchView reloadData];
    
    bgScrollView = [[UIScrollView alloc] init];
    bgScrollView.backgroundColor = COLOR_BG;
    bgScrollView.bounces = NO;
    bgScrollView.scrollsToTop = NO;
    bgScrollView.scrollEnabled = YES;
    bgScrollView.pagingEnabled = YES;
    bgScrollView.delegate = self;
    bgScrollView.userInteractionEnabled = YES;
    //        _scrollView.decelerationRate = 0.2;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    bgScrollView.contentSize = CGSizeMake(kMainScreenWidth*2, kMainScreenHeight-64-44-40);
    bgScrollView.frame = CGRectMake(0, 44, kMainScreenWidth, kMainScreenHeight-64-44-40);
    
    indexBanner = [[WFIndexBanner alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, WFBANNER_HEIGHT)];
    indexBanner.dataSourse = self;
    indexBanner.delegate = self;
    indexBanner.clipsToBounds = YES;
    
    detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-44-40) style:0];
    detailTableView.dataSource = self;
    detailTableView.delegate = self;
    detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgScrollView addSubview:detailTableView];
    
    
    if (_item && [NSString isNotEmpty:_item.Images]) {
        NSArray *imageIds = [_item.Images componentsSeparatedByString:@"|"];
        
        for (NSString *idStr in imageIds) {
            [self.images addObject:[NSString stringWithFormat:@"http://%@/userImages/%@",HOST,idStr]];
        }
        detailTableView.tableHeaderView = indexBanner;
    }
    [indexBanner reloadData];
    
    commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, kMainScreenHeight-64-44-40) style:0];
    commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    commentTableView.dataSource = self;
    commentTableView.delegate = self;
//    commentTableView.mjdelegate = self;
    [bgScrollView addSubview:commentTableView];
    [commentTableView.panGestureRecognizer addTarget:self action:@selector(tableViewClick:)];
//    containerView = [[ReplyView alloc] initWithFrame:CGRectMake(kMainScreenWidth, kMainScreenHeight-64-44-30-40, 320, 40)];
//    [containerView.doneBtn setTitle:@"发 送" forState:UIControlStateNormal];
//    containerView.delegate = self;
//    containerView.placeholder = @"说点什么吧...";
//    [bgScrollView addSubview:containerView];
    
    [self setupReplyUI];
    
    messageData = [[MessageData alloc] initWithItemId:self.item.ID];
    messageData.delegate = self;
    
    myfavData = [[MyFavData alloc] init];
    myfavData.delegate = self;
    
    locButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    locButton.frame = CGRectMake(kMainScreenWidth-40, 3, 30, 30);
    locButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [locButton setImage:ImageWithName(@"location_icon") forState:UIControlStateNormal];
    [locButton addTarget:self action:@selector(findIt) forControlEvents:UIControlEventTouchUpInside];
    
    callWebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:callWebview];
    
    UIButton *tabBtn1= [UIButton buttonWithType:UIButtonTypeCustom];
    tabBtn1.tag = 101;
    tabBtn1.frame = CGRectMake(0, kMainScreenHeight-64-40, kMainScreenWidth*0.5, 40);
    [tabBtn1 setBackgroundImage:ImageWithName(@"tab_btn_0") forState:UIControlStateNormal];
    [tabBtn1 setTitle:NSLocalizedString(title_call, nil) forState:UIControlStateNormal];
    [tabBtn1 setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    [self.view addSubview:tabBtn1];
    [tabBtn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *tabBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    tabBtn2.tag = 102;
    tabBtn2.frame = CGRectMake(kMainScreenWidth*0.5, kMainScreenHeight-64-40, kMainScreenWidth*0.5, 40);
    [tabBtn2 setBackgroundImage:ImageWithName(@"tab_btn_1") forState:UIControlStateNormal];
    [tabBtn2 setTitle:NSLocalizedString(title_message, nil) forState:UIControlStateNormal];
    [tabBtn2 setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    [self.view addSubview:tabBtn2];
    [tabBtn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)findIt
{
    if (!_item) {
        [self showTips:NSLocalizedString(msg_loading_error_reset, nil)];
        return;
    }
    
    NSString *qString = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@+%@+%@",self.item.City,self.item.Region,self.item.Address];
    qString = [qString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:qString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[Global ShareCenter] insertNewRecord:self.item];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [replyText resignFirstResponder];
}

- (void)tableViewClick:(id)sender
{
    [replyText resignFirstResponder];
}

- (void)setupReplyUI
{
    replyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 80)];
    
    UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
    nameLb.backgroundColor = [UIColor clearColor];
    nameLb.textColor = COLOR_TITLE;
    nameLb.text = NSLocalizedString(title_I_review, nil);
    [replyView addSubview:nameLb];
    [nameLb release];
    
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.frame = CGRectMake(kMainScreenWidth-80, 10, 70, 30);
    [postBtn setTitle:NSLocalizedString(btn_send_msg, nil) forState:UIControlStateNormal];
    postBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postBtn setBackgroundImage:ImageWithName(@"btn_normal") forState:UIControlStateNormal];
    [postBtn setBackgroundImage:ImageWithName(@"btn_press") forState:UIControlStateHighlighted];
    [replyView addSubview:postBtn];
    [postBtn addTarget:self action:@selector(addMessButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    replyText = [[CommonTextField alloc] initWithFrame:CGRectMake(20, 50, kMainScreenWidth-40, 30)];
    replyText.background = ImageWithName(@"input_bg_1");
    [replyView addSubview:replyText];
    
    commentTableView.tableHeaderView = replyView;
}

- (void)addMessButtonClick:(id)sender
{
    [self postNew];
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        
        MessageViewController *next = [[MessageViewController alloc] init];
        if (_item) {
            next.itemID = self.item.ID;
        }
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (sender.tag == 101) {
        
        if (_item) {
            if ([NSString isNotEmpty:self.item.Phone]) {
                NSString *telUrl = [NSString stringWithFormat:@"tel:%@",self.item.Phone];
                NSURL *telURL = [NSURL URLWithString:telUrl];
                [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            }
            else {
                AlertMessage(NSLocalizedString(history_NoInfo, nil));
            }
        }
    }
    else if (sender.tag == 102) {
        
        if ([NSString isNotEmpty:self.item.Phone]) {
            [self sendSMS];
        }
        else {
            AlertMessage(NSLocalizedString(history_NoInfo, nil));
        }
    }
}

- (NSInteger)numberOfIndexBanner:(WFIndexBanner *)target
{
    return self.images.count;
}

- (WFIndexModel *)indexBannerImageURL:(WFIndexBanner *)target ofIndex:(NSInteger)index
{
    NSString *imageUrl = self.images[index];
    
    WFIndexModel *model = [[WFIndexModel alloc] init];
    model.title = @"";
    model.url = [NSURL URLWithString:imageUrl];
    
    return [model autorelease];
}

- (void)indexBanner:(WFIndexBanner *)target SelectPage:(NSInteger)index AndImageView:(UIImageView *)imageV
{
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0; i<self.images.count; i++) {
        // 替换为中等尺寸图片
        NSString *url = self.images[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = imageV; // 来源于哪个UIImageView
        [photos addObject:photo];
        [photo release];
    }
    
    // 2.显示相册
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.delegate = nil;
    brower.currentPhotoIndex = index; // 弹出相册时显示的第一张图片是？
    brower.photos = photos; // 设置所有的图片
    [brower show];
    [brower release];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    //Notifies users about errors associated with the interface
    
    switch (result) {
            
        case MessageComposeResultCancelled:
            
            //            if (DEBUG) NSLog(@"Result: canceled");
            
            break;
            
        case MessageComposeResultSent:
        {
            //            if (DEBUG) NSLog(@"Result: Sent");
            AlertMessage(@"短信发送成功");
        }
            break;
            
        case MessageComposeResultFailed:
        {
            //            if (DEBUG) NSLog(@"Result: Failed");
            AlertMessage(@"短信发送失败");
        }
            break;
            
        default:
            
            break;
            
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)sendSMS {
    
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    
    NSLog(@"can send SMS [%d]",canSendSMS);
    
    if (canSendSMS) {
        
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        
        picker.messageComposeDelegate = self;
        
        picker.navigationBar.tintColor = [UIColor whiteColor];
        
        if (_item && [NSString isNotEmpty:self.item.Phone]) {
            picker.recipients = [NSArray arrayWithObject:self.item.Phone];
        }
        
        NSString *body = @"";
        picker.body = body;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        [picker release];
        
    }
}

- (NSInteger)numOfYLSwitchTabView:(YLSwitchTabView *)target
{
    return 2;
}

- (NSString *)YLSwitchTabViewTitle:(YLSwitchTabView *)target ofIndex:(NSInteger)index
{
    if (index == 0) {
        return NSLocalizedString(lab_detail_info, nil);
    }
    else {
        return NSLocalizedString(btn_send_msg, nil);
    }
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    NSLog(@"%f...%f",_scrollView.contentOffset.x,ITEM_WIDTH * (_pageControl.numberOfPages));
    
    int page = floor(bgScrollView.contentOffset.x/kMainScreenWidth);
    [switchView selectBtnTag:page];
//    NSLog(@"%d",page);
    
    if (page == 0) {
        [replyText resignFirstResponder];
    }
}

- (void)yLSwitchTabView:(YLSwitchTabView *)target ofIndex:(NSInteger)index
{
    [bgScrollView setContentOffset:CGPointMake(kMainScreenWidth*index, 0) animated:YES];
    [replyText resignFirstResponder];
    if (index == 1) {
        if (self.items.count == 0) {
            [messageData getMessageList];
        }
    }
}

- (void)loadData
{
    [messageData getMessageList];
}

- (void)MJRefreshTableViewStartRefreshing:(MJRefreshTableView *)target
{
    isRefreshing = YES;
    //    [self startLoading];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];
}

- (void)MJRefreshTableViewDidStartLoading:(MJRefreshTableView *)target
{
    isRefreshing = YES;
    //    [self startLoading];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self stopLoading];
    
    if (target.tag == WALL_LIST_DATA_TAG) {
        
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:(NSArray *)response];
        [commentTableView reloadData];
    }
    else if (target.tag == WALL_INSERT_DATA_TAG) {
        
        [messageData getMessageList];
    }
    else if (target.tag == MYFAV_INSERT_TAG) {
        if (response && [response isKindOfClass:[NSString class]]) {
            if ([(NSString *)response containsString:@"true"]) {
                //
//                [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
                [self showTips:NSLocalizedString(msg_add_favorite_success, nil)];
            }
            
        }
    }
    else if (target.tag == MYFAV_DELETE_TAG) {
        if (response && [response isKindOfClass:[NSString class]]) {
            
            if ([(NSString *)response containsString:@"true"]) {
                //
                [self showTips:NSLocalizedString(msg_cancel_favorite_success, nil)];
            }
        }
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self stopLoading];
    
    if (target.tag == WALL_LIST_DATA_TAG) {
        [commentTableView reloadData];
    }
    
}

//- (void)replyViewDidSend:(ReplyView *)target
//{
//    if (![NSString isNotEmpty:target.text]) {
//        //
//        return;
//    }
//    
//    [[UserLogin instanse] loginFrom:self succeed:^{
//        //
//        [self postNew];
//        
//        self.prepareString = nil;
//        
//        [replyText resignFirstResponder];
//    }];
//}

- (void)postNew
{
    [replyText resignFirstResponder];
    
    if (![NSString isNotEmpty:replyText.text]) {
        
        AlertMessage(NSLocalizedString(msg_send_not_msg, nil));
        return;
    }
    
    [[UserLogin instanse] loginFrom:self succeed:^{
        //
        if (!messageData.isLoading) {
            //
            [messageData sendMessage:replyText.text];
        }
        
        self.prepareString = nil;
    }];
}

- (void)replyViewDidChanged:(ReplyView *)target
{
    self.prepareString = target.text;
    //    NSLog(@"log:%@",self.prepareString);
}

- (void)replyViewBeginEditing:(ReplyView *)target
{
    //    NSLog(@"%@",self.prepareString);
    target.text = self.prepareString;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == commentTableView) {
        return 0;
    }
    else {
        if (section == 0) {
            return 36;
        }
        else {
            return 36;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == detailTableView) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 36)];
        headView.clipsToBounds = YES;
        headView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kMainScreenWidth-20, 36)];
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = COLOR_TITLE;
        titleLb.font = [UIFont systemFontOfSize:17];
        [headView addSubview:titleLb];
        [titleLb release];
        
        if (section == 0) {
            //
            titleLb.text = NSLocalizedString(lab_send_title, nil);
            //            headView.frame = CGRectMake(0, 0, kMainScreenWidth, 5);
        }
        else if (section == 1) {
            //
            titleLb.text = [NSString stringWithFormat:@"%@ & %@",NSLocalizedString(lab_price, nil),NSLocalizedString(lab_sendTime, nil)];
//            headView.frame = CGRectMake(0, 0, kMainScreenWidth, 5);
        }
        else if (section == 2) {
            titleLb.text = NSLocalizedString(lab_send_desc, nil);
        }
        else if (section == 3) {
            titleLb.text = NSLocalizedString(lab_phone, nil);
        }
        else if (section == 4) {
            titleLb.text = @"QQ/Skype";
        }
        else {
            
            [headView addSubview:locButton];
            
            titleLb.text = NSLocalizedString(lab_address, nil);
            
        }
        
        return [headView autorelease];
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == commentTableView) {
        MessageItem *item = self.items[indexPath.row];
        return [MessageCell getMessageCellHeight:item];
    }
    else {
        
        if (indexPath.section == 0 || indexPath.section == 2) {
            return 40;
        }
        else
        {
            NSString *content = nil;
            
            if (_item) {
                if (indexPath.section == 1) {
                    content = self.item.Description;
                }
                else if(indexPath.section == 3) {
                    content = self.item.QQSkype;
                }
                else {
                    content = self.item.Address;
                }
            }
      
            return [GoodDetailTableViewCell getCellheight:content];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == commentTableView) {
        return 1;
    }
    else {
        return 6;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == commentTableView) {
          return self.items.count;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == commentTableView) {
        static NSString *reuseIdetify = @"WallCell";
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify] autorelease];
        }
        cell.row = indexPath.row;
        cell.item = self.items[indexPath.row];
        return cell;
    }
    else {
        static NSString *reuseIdetify = @"DetailCell";
        static NSString *reuseIdetify2 = @"DetailCell2";
        if (indexPath.section == 1 || indexPath.section == 3) {
            
            GoodDetailTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
            if (!cell) {
                cell = [[[GoodDetailTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify] autorelease];
            }
            if (indexPath.section == 1) {
                cell.titleLb.text = NSLocalizedString(lab_price, nil);
                cell.contentLb.text = self.item.Price;
                cell.titleLb2.text = NSLocalizedString(lab_time, nil);
                cell.contentLb2.text = [NSString getTimeString:self.item.CreateDate];
            }
            else {
                cell.titleLb.text = NSLocalizedString(lab_send_username, nil);
                cell.contentLb.text = NSLocalizedString(title_NO_name, nil);
                cell.titleLb2.text = NSLocalizedString(lab_detail_phone, nil);
                cell.contentLb2.text = self.item.Phone;
            }
            return cell;
        }
        else {
            GoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify2];
            if (!cell) {
                cell = [[[GoodDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify2] autorelease];
            }
            
            NSString *content = nil;
            
            if (_item) {
                if (indexPath.section == 0) {
                    content = self.item.Title;
                }
                if (indexPath.section == 2) {
                    content = self.item.Description;
                }
                else if(indexPath.section == 4) {
                    content = self.item.QQSkype;
                }
                else {
                    content = self.item.Address;
                }
            }
            
            cell.contentLb.text = content;
            [cell reloadUI];
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == detailTableView) {
        if (indexPath.section == 4) {
            [self findIt];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
