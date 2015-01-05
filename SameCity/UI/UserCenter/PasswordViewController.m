//
//  PasswordViewController.m
//  samecity
//
//  Created by zengchao on 14-8-10.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController

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
    RELEASE_SAFELY(passwordData);
    RELEASE_SAFELY(passwordText);
    RELEASE_SAFELY(passwordText2);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(btn_edit_pass, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
//    UIBarButtonItem *right = [UIBarButtonItem createBarButtonItemWithTitle:@"注册" target:self action:@selector(regiserCilck:)];
//    self.navigationItem.rightBarButtonItem = right;
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
    
    passwordText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 20, 290, 40)];
    passwordText.secureTextEntry = YES;
    passwordText.placeholder = @"新密码最少6位";
    passwordText.font = [UIFont systemFontOfSize:16];
    //    usernameText.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:passwordText];
    
    //    passwordLb = [[CommonLabel alloc] initWithFrame:CGRectMake(30, 100, 60, 35)];
    //    passwordLb.text = @"密码:";
    //    [self.view addSubview:passwordLb];
    
    passwordText2 = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 20+40, 290, 40)];
    passwordText2.secureTextEntry = YES;
    passwordText2.font = [UIFont systemFontOfSize:16];
    passwordText2.placeholder = @"确认密码";
    //    passwordText.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:passwordText2];
    
    CommonButton *loginBtn = [CommonButton buttonWithType:UIButtonTypeCustom];
    loginBtn.tag = 101;
    loginBtn.backgroundColor = COLOR_THEME;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:NSLocalizedString(btn_submit, nil) forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:ImageWithName(@"btn_big_normal") forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:ImageWithName(@"btn_big_press") forState:UIControlStateHighlighted];
    loginBtn.frame = CGRectMake(20, 130, kMainScreenWidth-40, 35);
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    passwordData = [[MemberData alloc] init];
    passwordData.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
}

- (void)buttonClick:(UIButton *)sender
{
    [passwordText resignFirstResponder];
    [passwordText2 resignFirstResponder];
    
    if (sender.tag == 101) {
        
        if (![NSString isNotEmpty:passwordText.text]) {
            //
            AlertMessage(NSLocalizedString(msg_login_not_pawd, nil));
            return;
        }

        if (![NSString isNotEmpty:passwordText2.text]) {
            AlertMessage(NSLocalizedString(msg_login_not_pawd2, nil));
            return;
        }
        
        if (passwordText.text.length < 6) {
            AlertMessage(NSLocalizedString(msg_pawd_limit, nil));
            return;
        }
        
        if (passwordText2.text.length < 6) {
            AlertMessage(NSLocalizedString(msg_pawd_limit, nil));
            return;
        }
        
        if (![passwordText.text isEqualToString:passwordText2.text]) {
            AlertMessage(NSLocalizedString(msg_register_not_pawd_error, nil));
            return;
        }
        
        if (!passwordData.isLoading) {

            [self startLoading];
            
            [passwordData updatePassword:passwordText.text];
        }
    }
    else if (sender.tag == 102) {
        
    }
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self stopLoading];
    
    
    if (response && [response isKindOfClass:[NSString class]]) {
        
        NSArray *results = [(NSString *)response componentsSeparatedByString:@"|"];
        
        if (results.count >= 2) {
            
            NSString *isLogin = results[0];
            NSString *reason = results[1];
            
            if ([NSString isNotEmpty:isLogin] && [isLogin isEqualToString:@"true"] && [NSString isNotEmpty:reason]) {
                //
                AlertMessage(NSLocalizedString(msg_edit_pwd_success, nil));
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                if ([NSString isNotEmpty:reason]) {
                    AlertMessage(reason);
                }
            }
        }
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self stopLoadingWithError:nil];
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
