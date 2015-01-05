//
//  AppDelegate.m
//  SameCity
//
//  Created by zengchao on 14-4-22.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonNavigationController.h"
#import "XpaShowMemoryCount.h"
#import "HomePageViewController.h"
#import "PointsViewController.h"
#import "UserCenterViewController.h"
#import "PublishViewController.h"
#import "CommonNavigationController.h"
#import "LoginViewController.h"
#import "Tabbar.h"
#import "FXZLocationManager.h"
#import "CityViewController.h"
#import "Global.h"
#import "UserLogin.h"
#import "CoreDataEnvir.h"

#import "AdMoGoSplashAds.h"
#import "AdMoGoSplashAdsDelegate.h"
#import "MobiSageSDK.h"


//#import "DMSplashAdController.h"
//#import "DMRTSplashAdController.h"
//#import "DMSplashAdController+AdsMogo.h"

#define DMPUBLISHERID        @"56OJyM1ouMGoULfJaL"
#define DMPLCAEMENTID_SPLASH @"16TLwebvAchkAY6iOVhpfHPs"

@interface AppDelegate ()<MobiSageSplashDelegate>

@property (nonatomic,retain) MobiSageSplash* mobiSageSplash;

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //初始化数据
    [[UserLogin instanse] queryUserInfo];
    [[Global ShareCenter] initCitys];
    [CoreDataEnvir registDefaultDataFileName:@"SameCity.sqlite"];
    [CoreDataEnvir registDefaultModelFileName:@"RegionModel"];
    
    // Override point for customization after application launch.
//    NSString *country = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_COUNTRY];
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_CITY];
//    NSString *region = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_REGION];
//    
//    [FXZLocationManager sharedManager].country = country;
//    [FXZLocationManager sharedManager].city = city;
//    [FXZLocationManager sharedManager].region = region;
    
    //获取地理位置
    [[FXZLocationManager sharedManager] startUploadLocation];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self naviUI];
    
//    UIViewController *next = [[UIViewController alloc] init];
//    self.window.rootViewController = next;
    if ([NSString isNotEmpty:city]) {
        self.window.rootViewController = self.tabBarCtl;
    }
    else {
        self.window.rootViewController = self.cityCtl;
    }
    
    [self.window makeKeyAndVisible];
    
//    UIViewController *next = [[UIViewController alloc] init] ;
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:next];
    
//    self.window.rootViewController = navi;
    

    /*
    AdMoGoSplashAds *splashAds;
    splashAds = [[AdMoGoSplashAds alloc] initWithAppKey:MoGo_ID_IPhone adMoGoSplashAdsDelegate:self window:self.window];
//    splashAds = [[AdMoGoSplashAds alloc] bolckAppLaunchinitWithAppKey:MoGo_ID_IPhone adMoGoSplashAdsDelegate:self window:self.window WithObjects:nil];
    
    [splashAds requestSplashAd];
    
    
    UIView *view  = [splashAds getBackgroundView];
    view.backgroundColor = [UIColor whiteColor];
    
    [splashAds release];
     */
     
    
//    NSString* imgName = @"Default";
//    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height ;
//    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//        imgName = @"Default-Portrait";
//    } else {
//        if (screenHeight >  667.0f) {
//            imgName = @"Default-1242";
//        } else if (screenHeight > 568.0f ) {
//            imgName = @"Default-750";
//            
//        }else if(screenHeight > 480.f) {
//            imgName = @"Default-568h";
//        }
//    }
//    
//    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imgName]];
//    
//    BOOL  isTRSplash = NO;
//    
//    if (isTRSplash) {
//        self.mobiSageSplash = [[MobiSageRTSplash alloc] initWithOrientation:MS_Orientation_Portrait
//                                                                 background:bgColor
//                                                               withDelegate:self
//                                                                  slotToken:MS_Test_SlotToken_Splash];
//    }else{
//        self.mobiSageSplash = [[MobiSageSplash alloc] initWithOrientation:MS_Orientation_Portrait
//                                                               background:bgColor
//                                                             withDelegate:self
//                                                                slotToken:MS_Test_SlotToken_Splash];
//    }
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    //    [self.window makeKeyAndVisible];
    
//    [self.mobiSageSplash startSplash];
    
    return YES;
}

- (BOOL)isPad {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 3.2f)
    {
        return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? YES : NO;
    }
    return NO;
}

- (UINavigationController *)cityCtl
{
    CityViewController *next = [[CityViewController alloc] init];
    
    CommonNavigationController *navi = [[CommonNavigationController alloc] initWithRootViewController:next];
    
    [next release];
    return [navi autorelease];
}

//- (LoginViewController *)loginCtl
//{
//    LoginViewController *next = [[LoginViewController alloc] init];
//    return [next autorelease];;
//}

- (TabbarViewController *)tabBarCtl
{
    if (!_tabBarCtl) {
        NSMutableArray *ctrlArr = [NSMutableArray arrayWithCapacity:5];
        
        HomePageViewController *vc1 = [[HomePageViewController alloc] init];
        CommonNavigationController *navi = [[CommonNavigationController alloc] initWithRootViewController:vc1];
//        navi.navigationBarHidden = YES;
        [ctrlArr addObject:navi];
        [vc1 release];
        [navi release];
        
        PointsViewController *vc2 = [[PointsViewController alloc] init];
        CommonNavigationController *navi2 = [[CommonNavigationController alloc] initWithRootViewController:vc2];
        [ctrlArr addObject:navi2];
        [vc2 release];
        [navi2 release];
        
        UserCenterViewController *vc3 = [[UserCenterViewController alloc] init];
        CommonNavigationController *navi3 = [[CommonNavigationController alloc] initWithRootViewController:vc3];
        [ctrlArr addObject:navi3];
        [vc3 release];
        [navi3 release];
        
        PublishViewController *vc4 = [[PublishViewController alloc] init];
        CommonNavigationController *navi4 = [[CommonNavigationController alloc] initWithRootViewController:vc4];
        [ctrlArr addObject:navi4];
        [vc4 release];
        [navi4 release];
        
        NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:5];
        [imgDic addObject:[UIImage imageNamed:@"tab1_icon.png"] forKey:@"Default"];
        [imgDic addObject:[UIImage imageNamed:@"tab1_s_icon.png"] forKey:@"Highlighted"];
        [imgDic addObject:[UIImage imageNamed:@"tab1_s_icon.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic2 addObject:[UIImage imageNamed:@"tab2_icon.png"] forKey:@"Default"];
        [imgDic2 addObject:[UIImage imageNamed:@"tab2_s_icon.png"] forKey:@"Highlighted"];
        [imgDic2 addObject:[UIImage imageNamed:@"tab2_s_icon.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic3 addObject:[UIImage imageNamed:@"tab3_icon.png"] forKey:@"Default"];
        [imgDic3 addObject:[UIImage imageNamed:@"tab3_s_icon.png"] forKey:@"Highlighted"];
        [imgDic3 addObject:[UIImage imageNamed:@"tab3_s_icon.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic4 addObject:[UIImage imageNamed:@"tab4_icon.png"] forKey:@"Default"];
        [imgDic4 addObject:[UIImage imageNamed:@"tab4_s_icon.png"] forKey:@"Highlighted"];
        [imgDic4 addObject:[UIImage imageNamed:@"tab4_s_icon.png"] forKey:@"Seleted"];
        //        NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
        //        [imgDic5 addObject:[UIImage imageNamed:@"tab5_icon.png"] forKey:@"Default"];
        //        [imgDic5 addObject:[UIImage imageNamed:@"tab5_s_icon.png"] forKey:@"Highlighted"];
        //        [imgDic5 addObject:[UIImage imageNamed:@"tab5_s_icon.png"] forKey:@"Seleted"];
        
        NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,nil];
        NSArray *titleArr = [NSArray arrayWithObjects:NSLocalizedString(main_nav_home, nil),NSLocalizedString(main_nav_score, nil),NSLocalizedString(main_nav_user, nil),NSLocalizedString(main_nav_publish, nil),nil];
        
        _tabBarCtl = [[TabbarViewController alloc] initWithViewControllers:ctrlArr imageArray:imgArr andTitleArray:titleArr];
        //        _tabbarCtl.delegate = self;
        [_tabBarCtl setBackgroundImage:ImageWithName(@"tab_back.png")];
        [_tabBarCtl setTabBarTransparent:NO];
    }

    return _tabBarCtl;
}

- (void)naviUI
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    NSDictionary *barTitleTextAttributes_ = [[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal];
    NSMutableDictionary *barTitleTextAttributes = [NSMutableDictionary dictionary];
    if (barTitleTextAttributes_) {
        [barTitleTextAttributes addEntriesFromDictionary:barTitleTextAttributes_];
    }
    [barTitleTextAttributes setObject:[UIFont systemFontOfSize:13] forKey:UITextAttributeFont];
    [barTitleTextAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [barTitleTextAttributes setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
    [barTitleTextAttributes setObject:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [[UIBarButtonItem appearance] setTitleTextAttributes:barTitleTextAttributes forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:barTitleTextAttributes forState:UIControlStateHighlighted];
    
    
    NSDictionary *titleTextAttributes_ = [[UINavigationBar appearance] titleTextAttributes];
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionary];
    if (titleTextAttributes_) {
        [titleTextAttributes addEntriesFromDictionary:titleTextAttributes_];
    }
    [titleTextAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [titleTextAttributes setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
    [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
    
    [[UINavigationBar appearance] setBackgroundImage:[ImageWithName(@"navi_bg") adjustSize] forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:[ImageWithName(@"navi_bar_btn") adjustSize] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:[ImageWithName(@"navi_bar_btn_s") adjustSize] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIViewController *)adsMoGoSplashAdsViewControllerForPresentingModalView{
    
    return self.window.rootViewController;
}


- (NSString *)adsMoGoSplashAdsiPhone5Image{
    return @"Default-568h";
}

- (NSString *)adsMoGoSplashAdsiPhoneImage{
    return @"Default";
}

- (NSString *)adsMoGoSplashAdsiPadLandscapeImage{
    return @"Default-Landscape";
}

- (NSString *)adsMoGoSplashAdsiPadPortraitImage{
    return @"Default-Portrait";
}

- (void)adsMoGoSplashAdsSuccess:(AdMoGoSplashAds *)splashAds{
    NSLog(@"AdsMoGoSplashAds Success");
}

- (void)adsMoGoSplashAdsFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err{
    NSLog(@"AdsMoGoSplashAds fail %@",err);
}

- (void)adsMoGoSplashAdsAllAdFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err{
    NSLog(@"AdsMoGoSplashAdsAllAd fail %@",err);
}

- (void)adsMoGoSplashAdsFinish:(AdMoGoSplashAds *)splashAds{
    NSLog(@"AdsMoGoSplashAdsAllAd Finish");
}

- (void)adsMoGoSplashAdsWillPresent:(AdMoGoSplashAds *)splashAds{
    NSLog(@"AdsMoGoSplashAdsAllAd will Present");
}

- (void)adsMoGoSplashAdsDidPresent:(AdMoGoSplashAds *)splashAds{
    NSLog(@"AdsMoGoSplashAdsAllAd did present");
}

- (void)adsMoGoSplashAdsWillDismiss:(AdMoGoSplashAds *)splashAds{
    NSLog(@"AdsMoGoSplashAdsAllAd will dismiss");
}

- (void)adsMoGoSplashAdsDidDismiss:(AdMoGoSplashAds *)splashAds{
    NSLog(@"AdsMoGoSplashAdsAllAd did dismiss");
}

/*
 返回芒果自售广告尺寸
 */
- (CGRect)adMoGoSplashAdSize{
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    
//    float w = 300.0f;
//    float h = 300.0f;
    
//    float x = (screenSize.width - w) / 2;
//    float y = (screenSize.height - h) /2;
    
    return  CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
}

// 仅在芒果自售广告中使用
//ipad 屏幕适配 (旋转相关)
//设备旋转 需更换开屏广告的default图片
- (NSString *)adsMoGoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetImageName:(UIInterfaceOrientation)interfaceOri{
    return [self getCurDefaultName];
}

// 仅在芒果自售广告中使用
//如果已展示广告旋转的过程需要调整广告的位置
- (CGPoint)adsMogoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetAdPoint:(UIInterfaceOrientation)interfaceOri{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float w =kMainScreenWidth, h = kMainScreenHeight, x = 0, y = 0;
    if (interfaceOri == UIInterfaceOrientationPortrait || interfaceOri == UIInterfaceOrientationPortraitUpsideDown) {
        x = (screenSize.width - w) / 2;
        y = (screenSize.height - h) /2;
    }else{
        x = (screenSize.height - w) / 2;
        y = (screenSize.width - h) /2;
    }
    return CGPointMake(x, y);
}

-(NSString *)getCurDefaultName{
    
    BOOL _isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    
    NSString *name = @"Default";
    int scale = [UIScreen mainScreen].scale;
    if (!_isPad) {
        if (scale > 1 ) {
            
            if ([UIScreen mainScreen].bounds.size.height > 480) {
                name = @"Default-568h@2x";
            }else{
                name = @"Default@2x";
            }
            
        }else{
            name = @"Default";
        }
    }else{
        UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
        if (scale > 1) {
            if (io == UIInterfaceOrientationPortrait || io == UIInterfaceOrientationPortraitUpsideDown) {
                name = @"Default-Portrait@2x";
            }else{
                name = @"Default-Landscape@2x";
            }
        }else{
            if (io == UIInterfaceOrientationPortrait || io == UIInterfaceOrientationPortraitUpsideDown) {
                name = @"Default-Portrait";
            }else{
                name = @"Default-Landscape";
            }
        }
        
    }
    return name;
}

//返回芒果开屏显示类型 1 全屏 2居上 3居下
- (SplashAdShowType)adMoGoSplashShowType{
    return SplashAdShowTypeFull;
}

/**
 *  Splash展示成功
 *  @param adSplash
 */
//开屏广告展示成功时,回调此方法
- (void)mobiSageSplashSuccessToShow:(MobiSageSplash*)adSplash{
    NSLog(@"MobiSageSplashSuccessToShow");
//    [self.window makeKeyAndVisible];
}

/**
 *  Splash展示失败
 *  @param adSplash
 */
//开屏广告展示失败时,回调此方法,在此回调方法中,需释放广告,且在此时弹出应用的界面
- (void)mobiSageSplashFaildToRequest:(MobiSageSplash*)adSplash withError:(NSError *)error{
    [self.window makeKeyAndVisible];
    NSLog(@"MobiSageSplashFaildToRequest error = %@", [error description]);
    self.mobiSageSplash.delegate = nil;
    self.mobiSageSplash = nil;
}

/**
 *  Splash被关闭
 *  @param adSplash
 */
//开屏广告失败时,回调此方法,需释放广告,且在此时弹出应用的界面
- (void)mobiSageSplashClose:(MobiSageSplash*)adSplash{
    [self.window makeKeyAndVisible];
    NSLog(@"SplashClose");
    self.mobiSageSplash.delegate = nil;
    self.mobiSageSplash = nil;
}


@end
