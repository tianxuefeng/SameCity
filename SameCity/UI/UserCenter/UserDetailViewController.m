//
//  UserDetailViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-29.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "UserDetailViewController.h"
#import "MemberItem.h"
#import "UserLogin.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

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
    RELEASE_SAFELY(nameLb);
    RELEASE_SAFELY(IDLb);
    RELEASE_SAFELY(qqLb);
    RELEASE_SAFELY(phoneLb);
    RELEASE_SAFELY(emailLb);
    RELEASE_SAFELY(menberData);
    RELEASE_SAFELY(nameLbb);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(lab_detail_info, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    nameLbb.text = NSLocalizedString(lab_register_name, nil);
    
    nameLb.enabled = NO;
    IDLb.enabled = NO;
    qqLb.enabled = NO;
    phoneLb.enabled = NO;
    emailLb.enabled = NO;
    
    nameLb.background = [ImageWithName(@"input_bg_2") adjustSize];
    IDLb.background = [ImageWithName(@"input_bg_2") adjustSize];
    qqLb.background = [ImageWithName(@"input_bg_2") adjustSize];
    phoneLb.background = [ImageWithName(@"input_bg_2") adjustSize];
    emailLb.background = [ImageWithName(@"input_bg_2") adjustSize];
    
    nameLb.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    IDLb.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    qqLb.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneLb.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailLb.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, nameLb.frame.size.height)];
    imageV.backgroundColor = [UIColor clearColor];
    
    nameLb.leftViewMode = UITextFieldViewModeAlways;
    nameLb.leftView = imageV;
    [imageV release];
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, IDLb.frame.size.height)];
    imageV.backgroundColor = [UIColor clearColor];
    
    IDLb.leftViewMode = UITextFieldViewModeAlways;
    IDLb.leftView = imageV;
    [imageV release];
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, qqLb.frame.size.height)];
    imageV.backgroundColor = [UIColor clearColor];
    
    qqLb.leftViewMode = UITextFieldViewModeAlways;
    qqLb.leftView = imageV;
    [imageV release];
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, emailLb.frame.size.height)];
    imageV.backgroundColor = [UIColor clearColor];
    emailLb.leftViewMode = UITextFieldViewModeAlways;
    emailLb.leftView = imageV;
    [imageV release];
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, phoneLb.frame.size.height)];
    imageV.backgroundColor = [UIColor clearColor];
    phoneLb.leftViewMode = UITextFieldViewModeAlways;
    phoneLb.leftView = imageV;
    [imageV release];
    
    
    menberData = [[MemberData alloc] init];
    menberData.delegate = self;
    
    if ([NSString isNotEmpty: [UserLogin instanse].email]) {
        nameLb.text =  [UserLogin instanse].name;
        emailLb.text =  [UserLogin instanse].email;
        IDLb.text =  [UserLogin instanse].uid;
        qqLb.text =  [UserLogin instanse].qqSkype;
        phoneLb.text =  [UserLogin instanse].phone;
    }
    else {
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self startLoading];
        
        [menberData getMemberDetail:self.userID];
    }
    
//    CommonButton *loginBtn = [CommonButton buttonWithType:UIButtonTypeCustom];
//    loginBtn.tag = 101;
//    loginBtn.backgroundColor = COLOR_THEME;
//    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [loginBtn setTitle:@"退出" forState:UIControlStateNormal];
//    [loginBtn setBackgroundImage:ImageWithName(@"btn_big_normal") forState:UIControlStateNormal];
//    [loginBtn setBackgroundImage:ImageWithName(@"btn_big_press") forState:UIControlStateHighlighted];
//    loginBtn.frame = CGRectMake(20, 300, kMainScreenWidth-40, 35);
//    [self.view addSubview:loginBtn];
//    [loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(id)sender
{
    [[UserLogin instanse] clearUserInfo];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self stopLoading];
    
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        
        MemberItem *mItem = [[MemberItem alloc] initWithDictionary:(NSDictionary *)response error:nil];
        if (mItem) {
            //
            nameLb.text = mItem.Name;
            emailLb.text = mItem.Email;
            IDLb.text = mItem.ID;
            qqLb.text = mItem.QQSkype;
            phoneLb.text = mItem.Phone;
            
            if ([UserLogin instanse].uid && mItem.ID && [[UserLogin instanse].uid isEqualToString: mItem.ID]) {
                //...
                [UserLogin instanse].name = mItem.Name;
                [UserLogin instanse].email = mItem.Email;
                [UserLogin instanse].qqSkype = mItem.QQSkype;
                [UserLogin instanse].phone = mItem.Phone;
                [UserLogin instanse].MemType = mItem.MemType;
            }
            
            [[UserLogin instanse] saveUserInfo];
        }
        RELEASE_SAFELY(mItem);
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [MBProgressHUD showError:@"服务器错误" toView:self.view];
    
    [self stopLoadingWithError:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
