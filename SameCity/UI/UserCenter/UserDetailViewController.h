//
//  UserDetailViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-29.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "MemberData.h"

@interface UserDetailViewController : CommonViewController<HttpServiceDelegate>
{
    IBOutlet CommonTextField *nameLb;
    
    IBOutlet CommonTextField *IDLb;
    
    IBOutlet CommonTextField *qqLb;
    
    IBOutlet CommonTextField *phoneLb;
    
    IBOutlet CommonTextField *emailLb;
    
    MemberData *menberData;
    
    IBOutlet UILabel *nameLbb;
}

@property (nonatomic ,retain) NSString *userID;

@end
