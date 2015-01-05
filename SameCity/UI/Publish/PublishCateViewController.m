//
//  PublishCateViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "PublishCateViewController.h"
#import "UserLogin.h"
#import "CommonTableViewCell.h"

static NSString *reuseIdetify = @"PublishCateListCell";

@interface PublishCateViewController ()

@end

@implementation PublishCateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.level = 0;
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_items);
    RELEASE_SAFELY(categoryData);
    RELEASE_SAFELY(cateTableView);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(lab_select_category, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _items = [[NSMutableArray alloc] init];
    
    cateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:0];
    cateTableView.dataSource = self;
    cateTableView.delegate = self;
    cateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [cateTableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:reuseIdetify];
    [self.view addSubview:cateTableView];
    
    categoryData = [[CategoryData alloc] init];
    categoryData.delegate = self;
    
    if (self.level == 0) {
        
        if ([UserLogin instanse].categoryItems.count == 0) {
            
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self startLoading];
            
            [categoryData getCategoryListParentID:@"0"];
        }
        else {
            [self.items addObjectsFromArray:[UserLogin instanse].categoryItems];
            [cateTableView reloadData];
        }
    }
    else {
        if (_superCateID) {
            
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self startLoading];
            
            [categoryData getCategoryListParentID:_superCateID];
        }
        else {
            [self showTips:NSLocalizedString(msg_server_error, nil)];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    
    CategoryItem *cate = self.items[indexPath.row];
    
    cell.textLabel.text = cate.Title;
//    cell.item = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.level == 0) {
        
        CategoryItem *cate = self.items[indexPath.row];
        
        PublishCateViewController *next = [[PublishCateViewController alloc] init];
        next.delegate = self.delegate;
        next.level = 1;
        next.superCateID = cate.ID;
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (self.level == 1) {
        //
        CategoryItem *cate = self.items[indexPath.row];
        
        if (_delegate && [_delegate respondsToSelector:@selector(publishCateViewControllerCitySelect:)]) {
            [self.delegate publishCateViewControllerCitySelect:cate];
        }
        
        for (UIViewController *tmpCtl in self.navigationController.viewControllers) {
            //
            if ([tmpCtl isKindOfClass:NSClassFromString(@"PublishViewController")]) {
                [self.navigationController popToViewController:tmpCtl animated:YES];
                return;
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self stopLoading];
    
    if (target.tag == CATEGORY_DATA_TAG) {
        
        if ([(NSArray *)response count] == 0) {
            [self showTips:NSLocalizedString(history_NoInfo, nil)];
        }
        
        if (self.level == 0) {
            [[UserLogin instanse].categoryItems removeAllObjects];
            [[UserLogin instanse].categoryItems addObjectsFromArray:(NSArray *)response];
            [self.items removeAllObjects];
            [self.items addObjectsFromArray:(NSArray *)response];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:CateObtainNotificationKey object:nil];
        }
        else {
            [self.items removeAllObjects];
            [self.items addObjectsFromArray:(NSArray *)response];
        }
        
        [cateTableView reloadData];
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [MBProgressHUD showError:@"找不到服务器" toView:self.view];
    [self stopLoadingWithError:NSLocalizedString(msg_server_error, nil)];
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
