//
//  IndexViewController.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeList.h"

@interface HomePageViewController ()<SoapServiceDelegate>

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    defaultCityLb = [[UILabel alloc] initWithFrame:CGRectMake(0, statusBar_Top, kMainScreenWidth, 30)];
    defaultCityLb.backgroundColor = COLOR_BOTTOM_BG;
    defaultCityLb.textColor = [UIColor whiteColor];
    defaultCityLb.font = [UIFont boldSystemFontOfSize:16];
    defaultCityLb.text = @"南京";
    [self.view addSubview:defaultCityLb];
    
    _items = [[NSMutableArray alloc] init];
    
    UIView *functionBg = [[UIView alloc] initWithFrame:CGRectMake(0, 30+statusBar_Top, kMainScreenWidth, 60)];
    functionBg.backgroundColor = COLOR_THEME;
    [self.view addSubview:functionBg];
    
    
    [functionBg release];
    
    indexTableView = [[MJRefreshTableView alloc] initWithFrame:CGRectMake(0, 90+statusBar_Top, kMainScreenWidth, kMainScreenHeight-49-90-statusBar_Top) style:0];
    indexTableView.dataSource = self;
    indexTableView.delegate = self;
    indexTableView.mjdelegate = self;
    [self.view addSubview:indexTableView];
    
    [self getIndexData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"XFIndexCell";
    IndexListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[[IndexListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify] autorelease];
    }
    cell.indexItem = self.items[indexPath.row];
    return cell;
}

- (void)getIndexData
{
    HomeList *list = [[HomeList alloc] init];
    list.delegate = self;
    [list getHomeList];
    [list release];
}

- (void)soapService:(SoapService *)target Succeed:(NSObject *)response
{
    [self.items addObjectsFromArray:(NSArray *)response];
    [indexTableView reloadData];
}

- (void)soapService:(SoapService *)target Failed:(NSError *)error
{
       [indexTableView reloadData];
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
