//
//  PointsViewController.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "PointsViewController.h"

@interface PointsViewController ()

@end

@implementation PointsViewController

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
    
    self.title = NSLocalizedString(main_nav_score, nil);
    
    UIImageView *sIcon = [[UIImageView alloc] initWithImage:ImageWithName(@"stefen_icon")];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:sIcon];
    self.navigationItem.rightBarButtonItem = right;
    
    RELEASE_SAFELY(sIcon);
    RELEASE_SAFELY(right);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *contentLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kMainScreenWidth-40, 80)];
    contentLb.backgroundColor = [UIColor clearColor];
    contentLb.numberOfLines = 0;
    contentLb.text = NSLocalizedString(msg_point_tips, nil);
    [self.view addSubview:contentLb];
    [contentLb release];
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
