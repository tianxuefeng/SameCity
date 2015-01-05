//
//  RegisterViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-3.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserLogin.h"
#import "TPKeyboardAvoidingScrollView.h"

//static NSString *registerIdentifier = @"registerIdentifier";

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    TPKeyboardAvoidingScrollView *tpbg = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    self.view = tpbg;
    [tpbg release];
}

- (void)dealloc
{
    self.delegate = nil;
    RELEASE_SAFELY(registerData);
    RELEASE_SAFELY(emailText);
    RELEASE_SAFELY(passwordText);
    RELEASE_SAFELY(confirmText);

    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(btn_register, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, kMainScreenWidth-20, 80)];
    imageView.image = [ImageWithName(@"login_bg") adjustSize];
    [self.view addSubview:imageView];
    [imageView release];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, kMainScreenWidth-20, 80)];
    imageView2.image = [ImageWithName(@"login_bg") adjustSize];
    [self.view addSubview:imageView2];
    [imageView2 release];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 220, kMainScreenWidth-20, 80)];
    imageView3.image = [ImageWithName(@"login_bg") adjustSize];
    [self.view addSubview:imageView3];
    [imageView3 release];
    
    emailText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 20, 290, 40)];
    emailText.placeholder = NSLocalizedString(lab_email, nil);
    [self.view addSubview:emailText];
    
    
    nameText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 20+40, 290, 40)];
    nameText.placeholder = NSLocalizedString(lab_register_name, nil);
    [self.view addSubview:nameText];
    
    passwordText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 120, 290, 40)];
//    passwordText.borderStyle = UITextBorderStyleBezel;
    passwordText.placeholder = NSLocalizedString(lab_password, nil);
    [self.view addSubview:passwordText];
    
    confirmText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 120+40, 290, 40)];
//    confirmText.borderStyle = UITextBorderStyleBezel;
    confirmText.placeholder = NSLocalizedString(lab_password2, nil);
    [self.view addSubview:confirmText];
    
    phoneText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 220, 290, 40)];
    phoneText.placeholder = NSLocalizedString(lab_phone, nil);
    [self.view addSubview:phoneText];
    
    qqText = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 220+40, 290, 40)];
    qqText.placeholder = @"QQ/Skype";
    [self.view addSubview:qqText];
    
    CommonButton *registerBtn = [CommonButton buttonWithType:UIButtonTypeCustom];
    registerBtn.tag = 102;
//    registerBtn.backgroundColor = COLOR_THEME;
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:ImageWithName(@"btn_big_normal") forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:ImageWithName(@"btn_big_press") forState:UIControlStateHighlighted];
    [registerBtn setTitle:NSLocalizedString(btn_register, nil) forState:UIControlStateNormal];
    registerBtn.frame = CGRectMake(20, 320, kMainScreenWidth-40, 35);
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    registerData = [[MemberData alloc] init];
    registerData.delegate = self;
    
}

- (void)buttonClick:(UIButton *)sender
{
    if (![NSString isNotEmpty:emailText.text]) {
        AlertMessage(NSLocalizedString(msg_login_not_email, nil));
        return;
    }
    
    if (![NSString isNotEmpty:nameText.text]) {
        AlertMessage(NSLocalizedString(hint_username, nil));
        return;
    }
    
    if (![NSString isNotEmpty:passwordText.text]) {
        AlertMessage(NSLocalizedString(hint_password, nil));
        return;
    }
    
    if (![NSString isNotEmpty:confirmText.text]) {
        AlertMessage(NSLocalizedString(hint_password2, nil));
        return;
    }
    
    if (![passwordText.text isEqualToString:confirmText.text]) {
        AlertMessage(NSLocalizedString(msg_register_not_pawd_error, nil));
        return;
    }
    
    if (!registerData.isLoading) {
        
        [emailText resignFirstResponder];
        [nameText resignFirstResponder];
        
        [passwordText resignFirstResponder];
        [confirmText resignFirstResponder];
        
        [phoneText resignFirstResponder];
        [qqText resignFirstResponder];
        
        [self startLoading];
        
        RegiserItem *registerItem = [[RegiserItem alloc] init];
        registerItem.Email = emailText.text;
        registerItem.Name = nameText.text;
        registerItem.Password = [passwordText.text MD5Sum];
        
        if ([NSString isNotEmpty:phoneText.text]) {
            registerItem.Phone = phoneText.text;
        }
        else {
            registerItem.Phone = @"";
        }
        
        if ([NSString isNotEmpty:qqText.text]) {
            registerItem.QQSkype = qqText.text;
        }
        else {
            registerItem.QQSkype = @"";
        }
        
        registerItem.IC = @"";
        
        [registerData regiserEmail:registerItem];
        
        RELEASE_SAFELY(registerItem);
    }
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
    [self stopLoading];
    
    if (response && [response isKindOfClass:[NSString class]]) {
        
        NSArray *results = [(NSString *)response componentsSeparatedByString:@"|"];
        
        if (results.count >= 2) {
            
            NSString *isLogin = results[0];
            NSString *reason = results[1];
            
            if ([NSString isNotEmpty:isLogin] && [isLogin isEqualToString:@"true"] && [NSString isNotEmpty:reason]) {
                //
                [UserLogin instanse].uid = reason;
                
                //登录成功
                if ([NSString isNotEmpty:reason]) {
                    
//                    [self.navigationController popViewControllerAnimated:NO];
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(registerViewSucceed:)]) {
                        [self.delegate registerViewSucceed:self];
                    }
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

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
    [self stopLoading];
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
