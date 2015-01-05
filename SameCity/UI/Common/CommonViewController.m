//
//  CommonViewController.m
//  BBYT
//
//  Created by zengchao on 14-1-15.
//  Copyright (c) 2014年 babyun. All rights reserved.
//

#import "CommonViewController.h"
#import "UIImage+GIF.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

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
    
    RELEASE_SAFELY(_loadingView);
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

- (void)slideViewDidLoad
{

}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#endif

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.view.backgroundColor = COLOR_BG;

    self.view.userInteractionEnabled = YES;
    
    [self setupNavi];
    
    if (IOS7 && self.navigationController.navigationBarHidden) {
        statusBar_Top = 20;
    }
    else {
        statusBar_Top = 0;
    }
    
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.modalPresentationCapturesStatusBarAppearance = YES;
        self.extendedLayoutIncludesOpaqueBars = YES;
//        self.automaticallyAdjustsScrollViewInsets = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
//    else {
//        self.wantsFullScreenLayout = YES;
//    }
}

- (YYAnimationIndicator *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[YYAnimationIndicator alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-80, 100, 80)];
        [_loadingView setLoadText:NSLocalizedString(msg_Load, nil)];
        [self.view addSubview:_loadingView];
    }
    return _loadingView;
}

- (void)startLoading
{
    if (self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    self.view.userInteractionEnabled = NO;
    
    [self.loadingView setLoadText:NSLocalizedString(msg_Load, nil)];

    if (!self.loadingView.isAnimating) {
        [self.loadingView startAnimation];
    }
}

- (void)startLoadingWithTitle:(NSString *)title
{
    if (self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    self.view.userInteractionEnabled = NO;
    
    if (title) {
        [self.loadingView setLoadText:title];
    }
    
    if (!self.loadingView.isAnimating) {
        [self.loadingView startAnimation];
    }
}

- (void)stopLoading
{
    if (self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    self.view.userInteractionEnabled = YES;

    [self.loadingView stopAnimationWithLoadText:@"finish" withType:YES];//加载成功
}

- (void)stopLoadingWithError:(NSString *)error
{
    if (self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    self.view.userInteractionEnabled = YES;
    
    if (error) {
        [self.loadingView stopAnimationWithLoadText:error withType:NO];//加载失败
    }
    else {
        [self.loadingView stopAnimationWithLoadText:NSLocalizedString(msg_server_error, nil) withType:YES];//加载失败
    }
}

- (void)showTips:(NSString *)tips
{
    if (tips) {
        [LeafNotification showInController:self withText:tips];
    }
}

- (void)setupNavi
{

}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
