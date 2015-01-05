//
//  LoginViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserLogin.h"
#import "MemberItem.h"

@interface LoginViewController ()<RegisterViewDelegate>

@end

@implementation LoginViewController

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
    self.delegate = nil;
    RELEASE_SAFELY(loginData);
//    RELEASE_SAFELY(usernameLb);
    RELEASE_SAFELY(usernameText);
    
//    RELEASE_SAFELY(passwordLb);
    RELEASE_SAFELY(passwordText);
    
    [super dealloc];
}

- (void)loadView
{
    self.view = [[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)] autorelease];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(lab_login , nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [UIBarButtonItem createBarButtonItemWithTitle:NSLocalizedString(btn_register , nil)target:self action:@selector(regiserCilck:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)regiserCilck:(id)sender
{
    
    RegisterViewController *next = [[RegisterViewController alloc] init];
    next.delegate = self;
    [self.navigationController pushViewController:next animated:YES];
    [next release];
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, kMainScreenWidth-20, 80)];
    imageView.image = [ImageWithName(@"login_bg") adjustSize];
    [self.view addSubview:imageView];
    [imageView release];
    
//    usernameLb = [[CommonLabel alloc] initWithFrame:CGRectMake(30, 50, 60, 35)];
//    usernameLb.text = @"用户名:";
//    [self.view addSubview:usernameLb];
    
    usernameText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 20, 290, 40)];
    usernameText.placeholder = NSLocalizedString(lab_email, nil);
    usernameText.font = [UIFont systemFontOfSize:16];
//    usernameText.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:usernameText];
    
//    passwordLb = [[CommonLabel alloc] initWithFrame:CGRectMake(30, 100, 60, 35)];
//    passwordLb.text = @"密码:";
//    [self.view addSubview:passwordLb];
    
    passwordText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 20+40, 290, 40)];
    passwordText.secureTextEntry = YES;
    passwordText.font = [UIFont systemFontOfSize:16];
    passwordText.placeholder = NSLocalizedString(lab_password, nil);
//    passwordText.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:passwordText];

    CommonButton *loginBtn = [CommonButton buttonWithType:UIButtonTypeCustom];
    loginBtn.tag = 101;
    loginBtn.backgroundColor = COLOR_THEME;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:NSLocalizedString(lab_login, nil) forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:ImageWithName(@"btn_big_normal") forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:ImageWithName(@"btn_big_press") forState:UIControlStateHighlighted];
    loginBtn.frame = CGRectMake(20, 130, kMainScreenWidth-40, 35);
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    CommonButton *registerBtn = [CommonButton buttonWithType:UIButtonTypeCustom];
//    registerBtn.tag = 102;
//    registerBtn.backgroundColor = COLOR_THEME;
//    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
//    registerBtn.frame = CGRectMake(200, 150, 80, 35);
//    [self.view addSubview:registerBtn];
//    [registerBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    loginData = [[MemberData alloc] init];
    loginData.delegate = self;
    
    userData = [[MemberData alloc] init];
    userData.delegate = self;
    
    userData2 = [[MemberData alloc] init];
    userData2.delegate = self;
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 101) {
        
        if (![NSString isNotEmpty:usernameText.text]) {
            AlertMessage(NSLocalizedString(msg_login_not_email, nil));
            return;
        }
        
        if (![NSString isNotEmpty:passwordText.text]) {
            AlertMessage(NSLocalizedString(msg_login_not_pawd, nil));
            return;
        }
        
        if (!loginData.isLoading) {
            
            [usernameText resignFirstResponder];
            [passwordText resignFirstResponder];
            
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self startLoading];
            
            [loginData loginEmail:usernameText.text andPassword:passwordText.text];
        }
    }
    else if (sender.tag == 102) {

    }
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
    if (target == loginData) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self stopLoading];
        
        if (response && [response isKindOfClass:[NSString class]]) {
            
            NSArray *results = [(NSString *)response componentsSeparatedByString:@"|"];
            
            if (results.count >= 2) {
                
                NSString *isLogin = results[0];
                NSString *reason = results[1];
                
                if ([NSString isNotEmpty:isLogin] && [isLogin isEqualToString:@"true"] && [NSString isNotEmpty:reason]) {
                    //
                    [UserLogin instanse].uid = reason;
                    [[UserLogin instanse] saveUserInfo];
                    
                    //登录成功
                    if ([NSString isNotEmpty:reason]) {
                        
//                        loginData.tag = 1001;
                        [userData getMemberDetail:reason];
    
                    }
                }
                else {
                    if ([NSString isNotEmpty:reason]) {
                        AlertMessage(reason);
                    }
                }
            }
        }
    }
    else if (target == userData) {
        
        if (response && [response isKindOfClass:[NSDictionary class]]) {
            
            MemberItem *mItem = [[MemberItem alloc] initWithDictionary:(NSDictionary *)response error:nil];
            if (mItem) {
                //
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
        
        AlertMessage(NSLocalizedString(msg_login_success, nil));
        
        if (_delegate && [_delegate respondsToSelector:@selector(LoginSucced:)]) {
            [self.delegate LoginSucced:self];
        }
    }
    else if (target == userData2) {
        
        if (response && [response isKindOfClass:[NSDictionary class]]) {
            
            MemberItem *mItem = [[MemberItem alloc] initWithDictionary:(NSDictionary *)response error:nil];
            if (mItem) {
                //
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
        
        AlertMessage(NSLocalizedString(msg_register_success, nil));
        
        if (_delegate && [_delegate respondsToSelector:@selector(LoginSucced:)]) {
            [self.delegate LoginSucced:self];
        }
    }

}

- (void)httpService:(HttpService *)target Failed:(NSError *)error{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self stopLoadingWithError:nil];
}

- (void)registerViewSucceed:(RegisterViewController *)target
{
//    if (_delegate && [_delegate respondsToSelector:@selector(LoginSucced:)]) {
//        [self.delegate LoginSucced:self];
//    }
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (!userData2.isLoading) {
        [self startLoading];
        [userData2 getMemberDetail:[UserLogin instanse].uid];
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
