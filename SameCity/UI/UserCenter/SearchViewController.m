//
//  SearchViewController.m
//  samecity
//
//  Created by zengchao on 14-8-10.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    
    self.title = NSLocalizedString(lab_user_search, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIImageView *sIcon = [[UIImageView alloc] initWithImage:ImageWithName(@"stefen_icon")];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:sIcon];
    self.navigationItem.rightBarButtonItem = right;
    
    RELEASE_SAFELY(sIcon);
    RELEASE_SAFELY(right);
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
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
    searchBar.placeholder = NSLocalizedString(hint_keyword, nil);
    [self.view addSubview:searchBar];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [searchBar resignFirstResponder];
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
