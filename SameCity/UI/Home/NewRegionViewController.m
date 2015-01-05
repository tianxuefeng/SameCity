//
//  NewRegionViewController.m
//  samecity
//
//  Created by zengchao on 14-8-3.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "NewRegionViewController.h"

@interface NewRegionViewController ()

@end

@implementation NewRegionViewController

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
    self.ID = nil;
    self.originalText = nil;
   
    RELEASE_SAFELY(textField);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [UIBarButtonItem createBarButtonItemWithTitle:NSLocalizedString(btnOK, nil) target:self action:@selector(newTextClick:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)newTextClick:(id)sender
{
    if (![NSString isNotEmpty:textField.text]) {
        //
        AlertMessage(NSLocalizedString(hint_content, nil));
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(newRegionViewController:add:)]) {
        [self.delegate newRegionViewController:self add:textField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    textField = [[CommonTextField alloc] initWithFrame:CGRectMake(10, 20, kMainScreenWidth-20, 40)];
    textField.background = [ImageWithName(@"input_bg_1") adjustSize];
    textField.placeholder = NSLocalizedString(hint_content, nil);
    textField.text = self.originalText;
    [self.view addSubview:textField];
    
    [textField becomeFirstResponder];
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
