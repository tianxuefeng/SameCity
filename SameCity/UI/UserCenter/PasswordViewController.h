//
//  PasswordViewController.h
//  samecity
//
//  Created by zengchao on 14-8-10.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonTextField.h"
#import "MemberData.h"

@interface PasswordViewController : CommonViewController<HttpServiceDelegate>
{
    CommonTextField *passwordText;
    CommonTextField *passwordText2;
    
    MemberData *passwordData;
}
@end
