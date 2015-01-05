//
//  EditCateViewController.m
//  samecity
//
//  Created by zengchao on 14-10-13.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "EditCateViewController.h"
#import "NewRegionViewController.h"
#import "EditTableViewCell.h"
#import "CategoryItem.h"
#import "UserLogin.h"

@interface EditCateViewController ()<NewRegionViewControllerDelegate,EditCellDelegate>

@end

@implementation EditCateViewController

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
    RELEASE_SAFELY(cateData);
    RELEASE_SAFELY(addCateRequest);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
    self.title = NSLocalizedString(lab_edit_category, nil);
    
    UIBarButtonItem *right = [UIBarButtonItem createBarButtonItemWithTitle:NSLocalizedString(btn_add, nil) target:self action:@selector(gotoNewRegion:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)gotoNewRegion:(id)sender
{
    NewRegionViewController *next = [[NewRegionViewController alloc] init];
    next.delegate = self;
    next.title = NSLocalizedString(lab_add_category, nil);
    [self.navigationController pushViewController:next animated:YES];
    [next release];
}

- (void)newRegionViewController:(NewRegionViewController *)target add:(NSString *)newText
{
    if (!addCateRequest.isLoading && newText) {
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self startLoading];
    
        CategoryItem *item = [[CategoryItem alloc] init];
        item.ParentID = self.parentID;
        item.CreateUser = [UserLogin instanse].uid;
        item.Title = newText;
        
        if (target.ID) {
            //
            item.ID = target.ID;
            [addCateRequest updateNewCategory:item];
        }
        else {
            //
            [addCateRequest insertNewCategory:item];
        }
        
        RELEASE_SAFELY(item);
    }
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
    
    cateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:0];
    cateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cateTableView.dataSource = self;
    cateTableView.delegate = self;
    [self.view addSubview:cateTableView];
    
    //    editBottomView = [[YLEditBottomView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-64-49, kMainScreenWidth, 49)];
    //    editBottomView.delegate = self;
    //    [self.view addSubview:editBottomView];
    
    isChanged = NO;
    
    cateData = [[CategoryData alloc] init];
    cateData.delegate = self;
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self startLoading];
    
    [cateData getCategoryListParentID:self.parentID];
    
    addCateRequest = [[CategoryData alloc] init];
    addCateRequest.delegate = self;

}

- (void)back:(id)sender
{
    if (isChanged && _delegate && [_delegate respondsToSelector:@selector(EditCateViewControllerSucceed)]) {
        [self.delegate EditCateViewControllerSucceed];
    }
    
    [super back:sender];
}

- (void)getRegionList
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEFAULT_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *regionCellIdString = @"regioncell";
    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:regionCellIdString];
    
    if (!cell) {
        cell = [[[EditTableViewCell alloc] initWithStyle:0 reuseIdentifier:regionCellIdString] autorelease];
    }
    
    cell.row = indexPath.row;
    cell.delegate = self;
    
    CategoryItem *item = self.items[indexPath.row];
    cell.titleLb.text = item.Title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_delegate && [_delegate respondsToSelector:@selector(region:select:)]) {
//        [self.delegate region:self select:self.items[indexPath.row]];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}


- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self stopLoading];
    //    [MBProgressHUD showError:@"找不到服务器" toView:self.view];
    if (target == cateData) {
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:(NSArray *)response];
        [cateTableView reloadData];
    }
    else {

        isChanged = YES;
        
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self startLoading];
        
        [cateData getCategoryListParentID:self.parentID];
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
    [self stopLoadingWithError:nil];
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    [MBProgressHUD showError:@"找不到服务器" toView:self.view];
    [cateTableView reloadData];
}

- (void)EditCellShowMenu:(EditTableViewCell *)target
{
    NSArray *cells =  [cateTableView visibleCells];
    if (cells) {
        for (EditTableViewCell *cell in cells) {
            
            if (cell == target) {
                continue;
            }
            if (cell.currentStatus != kFeedStatusNormal) {
                [cell _slideInContentViewFromDirection];
                break;
            }
        }
    }
}

- (void)EditCellUpdate:(EditTableViewCell *)target
{
    [target _slideInContentViewFromDirection];
    
    CategoryItem *item = self.items[target.row];
    
    NewRegionViewController *next = [[NewRegionViewController alloc] init];
    next.delegate = self;
    next.title = NSLocalizedString(lab_edit_category, nil);
    next.originalText = item.Title;
    next.ID = item.ID;
    [self.navigationController pushViewController:next animated:YES];
    [next release];
}

- (void)EditCellDelete:(EditTableViewCell *)target
{
    
    [target _slideInContentViewFromDirection];
    
    CategoryItem *item = self.items[target.row];
    
    if (!addCateRequest.isLoading) {
  
        [self startLoading];
        
        [addCateRequest deleteNewCategoryID:item.ID];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
