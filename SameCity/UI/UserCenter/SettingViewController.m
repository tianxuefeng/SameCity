//
//  SettingViewController.m
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "FeedbackViewController.h"
#import "CityViewController.h"
#import "PasswordViewController.h"
#import "UserLogin.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    RELEASE_SAFELY(_items);
    RELEASE_SAFELY(settingTableView);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(title_setting, nil);
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
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
    
    _items = [[NSMutableArray alloc] init];
    [_items addObject:NSLocalizedString(btn_back_locat, nil)];
    [_items addObject:NSLocalizedString(btn_edit_pass, nil)];
    [_items addObject:NSLocalizedString(title_feedback, nil)];
    [_items addObject:@"关于我们"];
    
//    settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:0];
//    settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    settingTableView.dataSource = self;
//    settingTableView.delegate = self;
//    [self.view addSubview:settingTableView];
    NSMutableArray *settingArr = [NSMutableArray array];
    [settingArr addObject:NSLocalizedString(btn_back_locat, nil)];
    [settingArr addObject:NSLocalizedString(btn_edit_pass, nil)];

    
    NSMutableArray *settingArr2 = [NSMutableArray array];;
    [settingArr2 addObject:NSLocalizedString(title_feedback, nil)];
    [settingArr2 addObject:NSLocalizedString(title_aboutus, nil)];
    
    UIImageView *bg1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 40, kMainScreenWidth-60, 60)];
    bg1.userInteractionEnabled = YES;
    bg1.image = [ImageWithName(@"white_btn_bg") adjustSize];
    [self.view addSubview:bg1];
    [bg1 release];
    
//    UIImageView *div_line1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 59, bg1.frame.size.width-10, 2)];
//    div_line1.image = ImageWithName(@"div_line");
//    [bg1 addSubview:div_line1];
    
    UIImageView *line_vertical1 = [[UIImageView alloc] initWithFrame:CGRectMake(bg1.frame.size.width*0.5-1, 15, 1, bg1.frame.size.height-30)];
    line_vertical1.image = ImageWithName(@"line_vertical");
    [bg1 addSubview:line_vertical1];
    [line_vertical1 release];
//    UIImageView *line_vertical2 = [[UIImageView alloc] initWithFrame:CGRectMake(bg1.frame.size.width*0.5-1, 15+60, 1, bg1.frame.size.height*0.5-30)];
//    line_vertical2.image = ImageWithName(@"line_vertical");
//    [bg1 addSubview:line_vertical2];
    
    UIImageView *bg2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 120, kMainScreenWidth-60, 60)];
    bg2.userInteractionEnabled = YES;
    bg2.image = [ImageWithName(@"white_btn_bg") adjustSize];
    [self.view addSubview:bg2];
    [bg2 release];
    
    UIImageView *line_vertical3 = [[UIImageView alloc] initWithFrame:CGRectMake(bg1.frame.size.width*0.5-1, 15, 1, bg1.frame.size.height-30)];
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
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        CityViewController *next = [[CityViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (sender.tag == 101) {
        [[UserLogin instanse] loginFrom:self succeed:^{
            PasswordViewController *next = [[PasswordViewController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
            [next release];
        }];
    }
    else if (sender.tag == 200) {
        FeedbackViewController *next = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (sender.tag == 201) {
        AboutUsViewController *next = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"settingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:reuseIdetify] autorelease];
    }
    
    if (indexPath.row%2 == 0) {
        cell.contentView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    }
    else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.textColor = COLOR_TITLE;
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CityViewController *next = [[CityViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (indexPath.row == 1) {
        [[UserLogin instanse] loginFrom:self succeed:^{
            PasswordViewController *next = [[PasswordViewController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
            [next release];
        }];
    }
    else if (indexPath.row == 2) {
        FeedbackViewController *next = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    else if (indexPath.row == 3) {
        AboutUsViewController *next = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
