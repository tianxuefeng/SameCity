//
//  MessageViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "UserLogin.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
    self.itemID = nil;
    RELEASE_SAFELY(_items);
    RELEASE_SAFELY(wallTableView);
    RELEASE_SAFELY(containerView);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = @"留言";
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _items = [[NSMutableArray alloc] init];
    
    wallTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-40) style:0];
    wallTableView.dataSource = self;
    wallTableView.delegate = self;
    [self.view addSubview:wallTableView];
    [wallTableView.panGestureRecognizer addTarget:self action:@selector(tableViewClick:)];
    
    containerView = [[ReplyView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, 320, 40)];
    [containerView.doneBtn setTitle:NSLocalizedString(btn_send, nil) forState:UIControlStateNormal];
    containerView.delegate = self;
    containerView.placeholder = NSLocalizedString(hint_detail_msg, nil);
    [self.view addSubview:containerView];
    
    messageData = [[MessageData alloc] initWithItemId:self.itemID];
    messageData.delegate = self;
    [messageData getMessageList];
}

- (void)tableViewClick:(id)sender
{
    if ([containerView isTextFirstResponder]) {
        
        [containerView resignTextView];
    }
}

- (void)postReply
{
    
}

- (void)postNew
{
    if (![NSString isNotEmpty:containerView.text]) {
        return;
    }
    
    if (!messageData.isLoading) {
        //
        [messageData sendMessage:containerView.text];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageItem *item = self.items[indexPath.row];
    
    return [MessageCell getMessageCellHeight:item];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"WallCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify] autorelease];
    }
    cell.row = indexPath.row;
    cell.item = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
    if (target.tag == WALL_LIST_DATA_TAG) {
  
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:(NSArray *)response];
        [wallTableView reloadData];
    }
    else if (target.tag == WALL_INSERT_DATA_TAG) {
        
        [messageData getMessageList];
    }
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
    if (target.tag == WALL_LIST_DATA_TAG) {
        [wallTableView reloadData];
    }
    
}

- (void)replyViewDidSend:(ReplyView *)target
{
    if (![NSString isNotEmpty:target.text]) {
        //
        return;
    }
    
    [[UserLogin instanse] loginFrom:self succeed:^{
        //
        [self postNew];
        
        self.prepareString = nil;
        
        [containerView resignTextView];
    }];
}

- (void)replyViewDidChanged:(ReplyView *)target
{
    self.prepareString = target.text;
    //    NSLog(@"log:%@",self.prepareString);
}

- (void)replyViewBeginEditing:(ReplyView *)target
{
    //    NSLog(@"%@",self.prepareString);
    target.text = self.prepareString;
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
