//
//  UserCenterViewController.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserLogin.h"
#import "MyFavViewController.h"
#import "UserDetailViewController.h"
#import "MyPublishedViewController.h"
#import "SettingViewController.h"
#import "RecordViewController.h"
#import "SearchViewController.h"

#import "AdMoGoView.h"
#import "BUIView.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(main_nav_user, nil);
    
    UIImageView *sIcon = [[UIImageView alloc] initWithImage:ImageWithName(@"stefen_icon")];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:sIcon];
    self.navigationItem.leftBarButtonItem = right;
    
    RELEASE_SAFELY(sIcon);
    RELEASE_SAFELY(right);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *settingArr = [NSMutableArray array];
    [settingArr addObject:NSLocalizedString(lab_login, nil)];
    [settingArr addObject:NSLocalizedString(lab_user_send, nil)];
    [settingArr addObject:NSLocalizedString(lab_user_favorites, nil)];
    [settingArr addObject:NSLocalizedString(lab_user_history, nil)];
   
    NSMutableArray *settingArr2 = [NSMutableArray array];
    [settingArr2 addObject:NSLocalizedString(lab_user_search, nil)];
    [settingArr2 addObject:NSLocalizedString(title_setting, nil)];
    
    UIImageView *bg1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 40, kMainScreenWidth-60, 120)];
    bg1.userInteractionEnabled = YES;
    bg1.image = [ImageWithName(@"white_btn_bg") adjustSize];
    [self.view addSubview:bg1];
    [bg1 release];
    
    UIImageView *div_line1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 59, bg1.frame.size.width-10, 2)];
    div_line1.image = ImageWithName(@"div_line");
    [bg1 addSubview:div_line1];
    [div_line1 release];
    
    UIImageView *line_vertical1 = [[UIImageView alloc] initWithFrame:CGRectMake(bg1.frame.size.width*0.5-1, 15, 1, bg1.frame.size.height*0.5-30)];
    line_vertical1.image = ImageWithName(@"line_vertical");
    [bg1 addSubview:line_vertical1];
    [line_vertical1 release];
    
    UIImageView *line_vertical2 = [[UIImageView alloc] initWithFrame:CGRectMake(bg1.frame.size.width*0.5-1, 15+60, 1, bg1.frame.size.height*0.5-30)];
    line_vertical2.image = ImageWithName(@"line_vertical");
    [bg1 addSubview:line_vertical2];
    [line_vertical2 release];
    
    UIImageView *bg2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 180, kMainScreenWidth-60, 60)];
    bg2.userInteractionEnabled = YES;
    bg2.image = [ImageWithName(@"white_btn_bg") adjustSize];
    [self.view addSubview:bg2];
    [bg2 release];
    
    UIImageView *line_vertical3 = [[UIImageView alloc] initWithFrame:CGRectMake(bg1.frame.size.width*0.5-1, 15, 1, bg1.frame.size.height*0.5-30)];
    line_vertical3.image = ImageWithName(@"line_vertical");
    [bg2 addSubview:line_vertical3];
    [line_vertical3 release];
    
    CGFloat width = (kMainScreenWidth-60)/2;
    
    for (int i=0 ; i < settingArr.count; i++) {
        
        NSString *title = settingArr[i];
        
        NSInteger x = i%2;
        NSInteger y = i/2;
        
        CommonButton *button = [CommonButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(x*width, 5+y*60, width, 50);
        [bg1 addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            loginBtn = button;
        }
    }
    
    for (int i=0 ; i < settingArr2.count; i++) {
        
        NSString *title = settingArr2[i];
        
        NSInteger x = i%2;
        NSInteger y = i/2;
        
        CommonButton *button = [CommonButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200+i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(x*width, 5+y*60, width, 50);
        [bg2 addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    /*
    CGFloat width = (kMainScreenWidth-20)/3;
    
    for (int i=0; i<settingArr.count; i++) {
        NSString *title = settingArr[i];
        
        NSInteger x = i%3;
        NSInteger y = i/3;
        
        CommonButton *button = [CommonButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        //    myfavBtn.backgroundColor = COLOR_THEME;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageWithColor:COLOR_THEME] adjustSize] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageWithColor:COLOR_THEME] adjustSize] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(10+x*width, 30+y*width, width, width);
        [self.view addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = UIColorFromRGB(0xbf2b41).CGColor;
        button.layer.borderWidth = 0.5;
        
        if (i==0) {
            loginBtn = button;
        }
    }
    */
    
    loginOutBtn = [CommonButton buttonWithType:UIButtonTypeCustom];
    loginOutBtn.tag = 300;
    loginOutBtn.backgroundColor = COLOR_THEME;
    [loginOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginOutBtn setTitle:NSLocalizedString(btn_logout, nil) forState:UIControlStateNormal];
    [loginOutBtn setBackgroundImage:ImageWithName(@"btn_big_normal") forState:UIControlStateNormal];
    [loginOutBtn setBackgroundImage:ImageWithName(@"btn_big_press") forState:UIControlStateHighlighted];
    loginOutBtn.frame = CGRectMake(35, 260, kMainScreenWidth-70, 35);
    [self.view addSubview:loginOutBtn];
    [loginOutBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    AdMoGoView *adView = [[AdMoGoView alloc] initWithAppKey:MoGo_ID_IPhone
                                                     adType:AdViewTypeNormalBanner                                adMoGoViewDelegate:nil];
    //    adView.adWebBrowswerDelegate = self;
    adView.frame = CGRectMake(0.0, kMainScreenHeight-20-44-49-52, kMainScreenWidth, 50.0);
    [self.view addSubview:adView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [ApplicationDelegate.tabBarCtl hidesTabBar:NO animated:YES];
    
    if ([UserLogin instanse].isLogin) {
        [loginBtn setTitle:NSLocalizedString(title_view_user, nil) forState:UIControlStateNormal];
        loginOutBtn.hidden = NO;
        if ([NSString isNotEmpty:[UserLogin instanse].name]) {
            UIBarButtonItem *right = [UIBarButtonItem createBarButtonItemWithTitle:[UserLogin instanse].name target:self action:nil];
            self.navigationItem.rightBarButtonItem = right;
        }

    }
    else {
        [loginBtn setTitle:NSLocalizedString(btn_login, nil) forState:UIControlStateNormal];
        loginOutBtn.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        
        [[UserLogin instanse] loginFrom:self succeed:^{
            //
            UserDetailViewController *next = [[UserDetailViewController alloc] init];
            next.userID = [UserLogin instanse].uid;
            [self.navigationController pushViewController:next animated:YES];
            [next release];
            
        }];
    }
    else if (sender.tag == 101) {
        
        [[UserLogin instanse] loginFrom:self succeed:^{
            //
            MyPublishedViewController *next = [[MyPublishedViewController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
            [next release];
        }];
        
        
    }
    else if (sender.tag == 102) {
  
        [[UserLogin instanse] loginFrom:self succeed:^{
            //
            MyFavViewController *next = [[MyFavViewController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
            [next release];
        }];
    }
    else if (sender.tag == 103) {
        
        
        RecordViewController *next = [[RecordViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (sender.tag == 200) {
        SearchViewController *next = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (sender.tag == 201) {
        SettingViewController *next = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (sender.tag == 300) {
        
        __unsafe_unretained UserCenterViewController *weakSelf = self;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(msg_exit, nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(btnNO, nil) otherButtonTitles:NSLocalizedString(btnOK, nil), nil];
        [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
            //
            if (buttonIndex == 1) {
                [[UserLogin instanse] clearUserInfo];
                [weakSelf->loginBtn setTitle:NSLocalizedString(btn_login, nil) forState:UIControlStateNormal];
                weakSelf.navigationItem.rightBarButtonItem = nil;
                weakSelf->loginOutBtn.hidden = YES;
            }
        }];
    }
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
