//
//  IndexViewController.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HomePageViewController.h"
#import "CategoryViewController.h"
#import "AppDelegate.h"
#import "GoodsDetailViewController.h"
#import "UserLogin.h"
#import "MessageViewController.h"
#import "HomePageCell.h"
#import "CityBarItemView.h"
#import "CityViewController.h"
#import "RegionViewController.h"
#import "FXZLocationManager.h"
#import "Global.h"
//#import "HomePageListViewController.h"
#import "AdMoGoView.h"

@interface HomePageViewController ()

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

- (void)dealloc
{
    RELEASE_SAFELY(defaultCityLb);
    RELEASE_SAFELY(collectView);
    RELEASE_SAFELY(categoryData);
//    RELEASE_SAFELY(functionBg);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
//    self.title = @"同城";
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:[CityBarItemView shareInstance]];
    [[CityBarItemView shareInstance].acButton addTarget:self action:@selector(gotoCityCtl:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = left;
    RELEASE_SAFELY(left);
    
    UIImageView *sIcon = [[UIImageView alloc] initWithImage:ImageWithName(@"stefen_icon")];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:sIcon];
    self.navigationItem.rightBarButtonItem = right;
    
    RELEASE_SAFELY(sIcon);
    RELEASE_SAFELY(right);
}

- (void)gotoCityCtl:(id)sender
{
    RegionViewController *next = [[RegionViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
    [next release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[UserLogin instanse].categoryItems removeAllObjects];
    [[UserLogin instanse].categoryItems addObjectsFromArray:[[Global ShareCenter] getMainCateArray]];
    
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize                     = CGSizeMake(kMainScreenWidth/4,kMainScreenWidth/4+20);
    //    layout.sectionInset                 = UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0);
    layout.minimumInteritemSpacing      = 0;
    layout.minimumLineSpacing           = 0;
    layout.headerReferenceSize          = CGSizeMake(0, 15.0);
    layout.footerReferenceSize          = CGSizeMake(0, 15.0);
    
    collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44-49-50) collectionViewLayout:layout];
    collectView.backgroundColor = COLOR_BG;
    [collectView registerClass:[HomePageCell class]
    forCellWithReuseIdentifier:@"GradientCell"];
    collectView.delegate = self;
    collectView.dataSource = self;
//    collectView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
//    collectView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.view addSubview:collectView];
    
    [layout release];
    
    AdMoGoView *adView = [[AdMoGoView alloc] initWithAppKey:MoGo_ID_IPhone
                                         adType:AdViewTypeNormalBanner                                adMoGoViewDelegate:nil];
//    adView.adWebBrowswerDelegate = self;
    adView.frame = CGRectMake(0.0, kMainScreenHeight-20-44-49-52, kMainScreenWidth, 50.0);
    [self.view addSubview:adView];
    
    categoryData = [[CategoryData alloc] init];
    categoryData.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cateReload:) name:CateReloadNotificationKey object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTitle) name:LocationManagerLocationGetAddressNotificationKey object:nil];
    
//     self.view.backgroundColor = COLOR_BG;
}

- (void)reloadTitle
{
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_CITY];
    self.title = [NSString stringWithFormat:@"%@%@",city,NSLocalizedString(title_appname, nil)];
}

- (void)cateReload:(id)sender
{
    if ([UserLogin instanse].categoryItems.count == 0) {
        [categoryData getCategoryListParentID:@"0"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_CITY];
    self.title = [NSString stringWithFormat:@"%@%@",city,NSLocalizedString(title_appname, nil)];
    [ApplicationDelegate.tabBarCtl hidesTabBar:NO animated:YES];

    
    if (!isLoaded) {
        
        if (!categoryData.isLoading) {
    
            if ([UserLogin instanse].categoryItems.count == 0) {
                [self startLoading];
            }

            [categoryData getCategoryListParentID:@"0"];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setupCategory
{
//    for (UIView *tmpView in functionBg.subviews) {
//        [tmpView removeFromSuperview];
//    }
//    
//    CGFloat width = 20;
//
//    for (int i=0; i<[UserLogin instanse].categoryItems.count; i++) {
//        //
//        CategoryItem *categoryItem = [UserLogin instanse].categoryItems[i];
//        
//        CommonButton *categoryBtn = [CommonButton buttonWithType:UIButtonTypeCustom];
//        categoryBtn.tag = 100+i;
//        [functionBg addSubview:categoryBtn];
//        if ([NSString isNotEmpty:categoryItem.Title]) {
//            
//            CGSize size = [NSString calculateTextHeight:categoryBtn.titleLabel.font givenText:categoryItem.Title givenWidth:100];
//            
//            categoryBtn.frame = CGRectMake(width, 10, size.width, 20);
//            [categoryBtn setTitle:categoryItem.Title forState:UIControlStateNormal];
//            
//            width += size.width+20;
//        }
//        [categoryBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    functionBg.contentSize = CGSizeMake(width+20, functionBg.frame.size.height);
}

//- (void)buttonClick:(UIButton *)sender
//{
//    NSInteger tag = sender.tag-100;
//    
//    CategoryItem *categoryItem = [UserLogin instanse].categoryItems[tag];
//    
//    CategoryViewController *next = [[CategoryViewController alloc] init];
//    next.cItem = categoryItem;
//    next.title = categoryItem.Title;
//    [self.navigationController pushViewController:next animated:YES];
//    [next release];
//    
//}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self stopLoading];
    
    if (target.tag == CATEGORY_DATA_TAG) {
        
        if ([(NSArray *)response count] > 0) {
            isLoaded = YES;
        }
        
        if ([UserLogin instanse].categoryItems.count == 0) {
            [[UserLogin instanse].categoryItems removeAllObjects];
            [[UserLogin instanse].categoryItems addObjectsFromArray:(NSArray *)response];
            //        [self setupCategory];
            [collectView reloadData];
        }
   
        [[Global ShareCenter] deleteAllCates];
        
        for (CategoryItem *cate in (NSArray *)response) {
            [[Global ShareCenter] insertNewCates:cate];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CateObtainNotificationKey object:nil];
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
    if ([UserLogin instanse].categoryItems.count == 0) {
        [self stopLoadingWithError:nil];
    }
    else {
        [self stopLoading];
    }
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [UserLogin instanse].categoryItems.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    HomePageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CategoryItem *citem = [UserLogin instanse].categoryItems[indexPath.row];
    cell.cItem = citem;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryItem *citem = [UserLogin instanse].categoryItems[indexPath.row];
    
    CategoryViewController *next = [[CategoryViewController alloc] init];
    next.cItem = citem;
    next.title = citem.Title;
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
