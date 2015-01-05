//
//  RecordViewController.m
//  samecity
//
//  Created by zengchao on 14-8-10.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "RecordViewController.h"
#import "HomePageListCell.h"
#import "GoodsDetailViewController.h"
#import "Global.h"

static NSString *reuseIdetify = @"RecordListCell";

@interface RecordViewController ()

@end

@implementation RecordViewController

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
    RELEASE_SAFELY(_items);
    RELEASE_SAFELY(indexTableView);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(lab_user_history, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIImageView *sIcon = [[UIImageView alloc] initWithImage:ImageWithName(@"stefen_icon")];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:sIcon];
    self.navigationItem.rightBarButtonItem = right;
    
    RELEASE_SAFELY(sIcon);
    RELEASE_SAFELY(right);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _items = [[NSMutableArray alloc] init];
    
    indexTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:0];
    indexTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    indexTableView.dataSource = self;
    indexTableView.delegate = self;
    [self.view addSubview:indexTableView];
    
    [indexTableView registerClass:[HomePageListCell class] forCellReuseIdentifier:reuseIdetify];
    
    [self.items addObjectsFromArray: [[Global ShareCenter] getRecordArray]];
    [indexTableView reloadData];
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
    
    if (indexPath.row%2 == 1) {
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
