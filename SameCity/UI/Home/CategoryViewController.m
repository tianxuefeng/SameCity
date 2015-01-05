//
//  CategoryViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CategoryViewController.h"
#import "HomePageListViewController.h"
#import "UserLogin.h"
#import "EditCateViewController.h"

@interface CategoryViewController ()<EditCateViewControllerDelegate>

@property (nonatomic ,retain) NSMutableDictionary *listDic;

@end

@implementation CategoryViewController

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
    self.cItem = nil;
    RELEASE_SAFELY(categoryData);
    RELEASE_SAFELY(categoryData2);
    RELEASE_SAFELY(_items);
    RELEASE_SAFELY(_listDic);
    RELEASE_SAFELY(_slideSwitchView);
//    RELEASE_SAFELY(functionBg);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.backBarButtonItem.action = @selector(back:);
    
    _items = [[NSMutableArray alloc] init];
    _listDic = [[NSMutableDictionary alloc] init];
    
    _slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    //    self.slideSwitchView.openUnselect = NO;
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.tabItemNormalColor = COLOR_TITLE;
    self.slideSwitchView.tabItemSelectedColor = COLOR_THEME;
    self.slideSwitchView.shadowImage = [UIImage imageWithColor:COLOR_THEME];
    [self.view addSubview:self.slideSwitchView];
    
    categoryData = [[CategoryData alloc] init];
    categoryData.delegate = self;
    
    categoryData2 = [[CategoryData alloc] init];
    categoryData2.delegate = self;
    
    [self addSubCateBtn];
    
    if (_cItem) {
        
        [self startLoading];
        
        [categoryData getCategoryListParentID:self.cItem.ID];
    }
}

- (void)addSubCateBtn
{
    addButton = [CommonButton buttonWithType:UIButtonTypeCustom];
    addButton.tag = 100;
    //    myfavBtn.backgroundColor = COLOR_THEME;
    [addButton setTitle:@"编辑子分类" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[[UIImage imageWithColor:COLOR_THEME] adjustSize] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[[UIImage imageWithColor:COLOR_THEME] adjustSize] forState:UIControlStateHighlighted];
    addButton.frame = CGRectMake((kMainScreenWidth-120)*0.5, 100, 120, 42);
    [self.view addSubview:addButton];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    addButton.layer.borderColor = UIColorFromRGB(0xbf2b41).CGColor;
    addButton.layer.borderWidth = 0.5;
    addButton.hidden = YES;
}

- (void)addButtonClick:(id)sender
{
    __unsafe_unretained CategoryViewController *bSelf = self;
    
    [[UserLogin instanse] loginFrom:self succeed:^{
        //
        if ([UserLogin instanse].isLogin) {
            if ([UserLogin instanse].MemType) {
                //
                if ([UserLogin instanse].MemType.intValue > 1) {
                    //
  
                    EditCateViewController *next = [[EditCateViewController alloc] init];
                    next.delegate = bSelf;
                    next.parentID = bSelf.cItem.ID;
                    [bSelf.navigationController pushViewController:next animated:YES];
                    [next release];
                    
                    return;
                }
            }
        }

//        [MBProgressHUD showMessag:@"权限不足,管理员可修改子分类" toView:self.view];
        [self showTips:@"权限不足,管理员可修改子分类"];
    }];
}

- (void)updateUserDetail
{
    if ([UserLogin instanse].isLogin) {
        if ([UserLogin instanse].MemType) {
            //
            if ([UserLogin instanse].MemType.intValue > 1) {
                //
                UIBarButtonItem *right = [UIBarButtonItem  createBarButtonItemWithTitle:NSLocalizedString(btn_edit, nil) target:self action:@selector(addNew)];
                self.navigationItem.rightBarButtonItem = right;
                
                return;
            }
        }
    }
    else {
        UIBarButtonItem *right = [UIBarButtonItem  createBarButtonItemWithTitle:NSLocalizedString(btn_login, nil) target:self action:@selector(addNew)];
        self.navigationItem.rightBarButtonItem = right;
    }
}

- (void)addNew
{
    __unsafe_unretained CategoryViewController *bSelf = self;
    
    [[UserLogin instanse] loginFrom:self succeed:^{
        //
        if ([UserLogin instanse].isLogin) {
            if ([UserLogin instanse].MemType) {
                //
                if ([UserLogin instanse].MemType.intValue > 1) {
                    //
                    UIBarButtonItem *right = [UIBarButtonItem  createBarButtonItemWithTitle:NSLocalizedString(btn_edit, nil) target:self action:@selector(addNew)];
                    bSelf.navigationItem.rightBarButtonItem = right;
                }
            }
        }
        else {
            UIBarButtonItem *right = [UIBarButtonItem  createBarButtonItemWithTitle:NSLocalizedString(btn_login, nil) target:self action:@selector(addNew)];
            bSelf.navigationItem.rightBarButtonItem = right;
        }
        
        if ([UserLogin instanse].MemType) {
            //
            if ([UserLogin instanse].MemType.intValue > 1) {
                //
                EditCateViewController *next = [[EditCateViewController alloc] init];
                next.delegate = bSelf;
                next.parentID = bSelf.cItem.ID;
                [bSelf.navigationController pushViewController:next animated:YES];
                [next release];
            }
        }
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
}

#pragma mark - 滑动tab视图代理方法

- (UIViewController<HomePageListControllerProtocol> *)getListViewControllerIndex:(NSInteger)index
{
    NSString *key_  = [NSString stringWithFormat:@"%d",(int)index];
    
    if ([self.listDic.allKeys containsObject:key_])
    {
        HomePageListViewController *next = [self.listDic objectForKey:key_];
        return next;
    }
    else
    {
        HomePageListViewController *next = [[HomePageListViewController alloc] init];
        CategoryItem *citem = self.items[index];
        //        next.notice = news.notice;
        next.cateItem = citem;
        next.title = citem.Title;
        [self addChildViewController:next];
        [self.listDic addObject:next forKey:key_];
        return [next autorelease];
    }
    return nil;
}

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return self.items.count;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    UIViewController *next = [self getListViewControllerIndex:number];
    return next;
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    //    NSLog(@"---->%d",number);
    //    [self.slideSwitchView.rootScrollView sendSubviewToBack:[self getIndexCtl].view];
    if (number < self.items.count) {
        UIViewController <HomePageListControllerProtocol> *next = [self getListViewControllerIndex:number];
        [next viewDidLoaded];
    }
}

#pragma mark -- HTTP

- (void)clearData
{
    //    self.nIndexDto = nil;
    [self.items removeAllObjects];
}

- (void)trimData
{
    [self.slideSwitchView buildUI];
    //    [self getIndexCtl].view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44-kHeightOfTopScrollView);
    //    [self.slideSwitchView.rootScrollView addSubview:[self getIndexCtl].view];
    //    [self.slideSwitchView.rootScrollView bringSubviewToFront:[self getIndexCtl].view];
}


- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self stopLoading];
    
    if (target.tag == CATEGORY_DATA_TAG) {
        
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:(NSArray *)response];

        [self trimData];
        
        if (self.items.count == 0) {
            
//            [MBProgressHUD showSuccess:@"暂无子分类" toView:self.view];
            [self showTips:NSLocalizedString(history_NoInfo, nil)];
            
            [self performSelector:@selector(performAddNoHidden) withObject:nil afterDelay:2];
        }
        else {
        
            [self performSelector:@selector(performAddHidden) withObject:nil afterDelay:1];
        }
        
        [self performSelector:@selector(updateUserDetail) withObject:nil afterDelay:1];
    }
    else if (target.tag == CATEGORY_INSERT_TAG) {
        AlertMessage(NSLocalizedString(msg_add_success, nil));
        if (_cItem) {
         
            [self startLoading];
            
            [categoryData getCategoryListParentID:self.cItem.ID];
        }
    }
}

- (void)performAddHidden
{
    if (addButton.hidden == NO) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.32;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        animation.removedOnCompletion = YES;
        [[addButton layer] addAnimation:animation forKey:@"animation"];
        addButton.hidden = YES;
    }
}

- (void)performAddNoHidden
{
    if (addButton.hidden == YES) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.32;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        animation.removedOnCompletion = YES;
        [[addButton layer] addAnimation:animation forKey:@"animation"];
        addButton.hidden = NO;
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
    if (target.tag == CATEGORY_DATA_TAG) {
        [self performSelector:@selector(updateUserDetail) withObject:nil afterDelay:1];
    }
    
    [self stopLoadingWithError:NSLocalizedString(msg_server_error, nil)];
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    [MBProgressHUD showError:@"找不到服务器" toView:self.view];
}

- (void)EditCateViewControllerSucceed
{
    if (_cItem) {

        [self startLoading];
        
        [categoryData getCategoryListParentID:self.cItem.ID];
    }
}

//- (void)newRegionViewController:(NewRegionViewController *)target add:(NSString *)newText
//{
//    if (!categoryData2.isLoading && [NSString isNotEmpty:newText] && _cItem) {
//        CategoryItem *item = [[CategoryItem alloc] init];
//        item.ParentID = self.cItem.ID;
//        item.CreateUser = [UserLogin instanse].uid;
//        item.Title = newText;
//        [categoryData2 insertNewCategory:item];
//    }
//}

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
