//
//  HomePageListViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HomePageListViewController.h"
#import "GoodsDetailViewController.h"
#import "Global.h"
#import "PublishViewController.h"

static NSString *reuseIdetify = @"HomePageListCell";

@interface HomePageListViewController ()<PublishViewControllerDelegate>

@end

@implementation HomePageListViewController

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
    RELEASE_SAFELY(listData);
    RELEASE_SAFELY(_items);
    RELEASE_SAFELY(indexTableView);
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _items = [[NSMutableArray alloc] init];
    
    indexTableView = [[MJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-38) style:0];
    indexTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    indexTableView.dataSource = self;
    indexTableView.delegate = self;
    indexTableView.mjdelegate = self;
    [self.view addSubview:indexTableView];
    
    [indexTableView registerClass:[HomePageListCell class] forCellReuseIdentifier:reuseIdetify];
    
    
    addButton = [CommonButton buttonWithType:UIButtonTypeCustom];
    addButton.tag = 100;
    //    myfavBtn.backgroundColor = COLOR_THEME;
    [addButton setTitle:NSLocalizedString(lab_local_add_good, nil) forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[[UIImage imageWithColor:COLOR_THEME] adjustSize] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[[UIImage imageWithColor:COLOR_THEME] adjustSize] forState:UIControlStateHighlighted];
    addButton.frame = CGRectMake((kMainScreenWidth-120)*0.5, 100, 120, 42);
    [indexTableView addSubview:addButton];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    addButton.layer.borderColor = UIColorFromRGB(0xbf2b41).CGColor;
    addButton.layer.borderWidth = 0.5;
    addButton.hidden = YES;
    
    NSString *city = [Global ShareCenter].city;
    NSString *region = [Global ShareCenter].region;
    
    listData = [[HomePageData alloc] initWithCity:city andRegion:region];
    listData.delegate = self;
    if (_cateItem) {
        listData.parentID = self.cateItem.ParentID;
        listData.categoryID = self.cateItem.ID;
    }
}

- (void)addButtonClick:(id)sender
{
    PublishViewController *next = [[PublishViewController alloc] initWithNibName:@"PublishViewController" bundle:nil];
    next.delegate = self;
    next.selectCate = self.cateItem;
    next.fromPush = YES;
    [self.navigationController pushViewController:next animated:YES];
    [next release];
}

- (void)publishedSuccceed:(PublishViewController *)target
{
    if (_cateItem && [Global ShareCenter].publishedID) {
        if ([self.cateItem.ID isEqualToString:[Global ShareCenter].publishedID]) {
            //
            isRefreshing = YES;
            [indexTableView startPullDownRefreshing];
            [Global ShareCenter].publishedID = nil;
        }
    }
}

- (void)viewDidLoaded
{
    if (self.items.count == 0) {
        isRefreshing = YES;
        [indexTableView startPullDownRefreshing];
    }
    else {
        if ([Global ShareCenter].mustRefresh) {
            isRefreshing = YES;
            [indexTableView startPullDownRefreshing];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomePageListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    
    if (indexPath.row%2 == 0) {
        cell.contentView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    }
    else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    cell.item = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomePageItem *item = self.items[indexPath.row];
    
    GoodsDetailViewController *next = [[GoodsDetailViewController alloc] init];
    next.item = item;
    [self.navigationController pushViewController:next animated:YES];
    [next release];
}

- (void)getIndexData
{
    if (!listData.isLoading) {
        int page = 0;
        if (isRefreshing) {
            page = 1;
        }
        else {
            if (self.items.count%PER_PAGE_SIZE != 0) {
                [indexTableView endRefreshingAndReloadData];
                return;
            }
            else {
                page = (int)self.items.count/PER_PAGE_SIZE+1;
            }
        }
        
        NSString *city = [Global ShareCenter].city;
        NSString *region = [Global ShareCenter].region;
        listData.city = city;
        listData.region = region;
        [listData getHomeDataPageNum:page andPageSize:PER_PAGE_SIZE];
    }
    else {
        [indexTableView endRefreshingAndReloadData];
    }
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
    if (target.tag == HOME_DATA_TAG) {
        if (isRefreshing) {
            [self.items removeAllObjects];
        }
        [self.items addObjectsFromArray:(NSArray *)response];
        
        if ([(NSArray *)response count] < PER_PAGE_SIZE) {
            [indexTableView endRefreshingAndReloadDataNoMore];
        }
        else {
            [indexTableView endRefreshingAndReloadData];
        }
        
        if (self.items.count == 0) {
            addButton.hidden = NO;
        }
        else {
            addButton.hidden = YES;
            [Global ShareCenter].mustRefresh = NO;
        }
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
    if (target.tag == HOME_DATA_TAG) {
        [indexTableView endRefreshingAndReloadData];
    }
    
}

- (void)MJRefreshTableViewStartRefreshing:(MJRefreshTableView *)target
{
    isRefreshing = YES;
    //    [self startLoading];
    [self performSelector:@selector(getIndexData) withObject:nil afterDelay:0.1];
}

- (void)MJRefreshTableViewDidStartLoading:(MJRefreshTableView *)target
{
    isRefreshing = NO;
    //    [self startLoading];
    [self performSelector:@selector(getIndexData) withObject:nil afterDelay:0.1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
