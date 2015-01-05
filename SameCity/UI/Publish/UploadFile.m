//
//  UploadFile.m
//  LYGInformationport
//
//  Created by zengchao on 14-5-22.
//  Copyright (c) 2014年 xweisoft. All rights reserved.
//

#import "UploadFile.h"

@implementation UploadFile

- (void)dealloc
{
    RELEASE_SAFELY(_fileId);
    RELEASE_SAFELY(_videoUrl);
    RELEASE_SAFELY(_image);
    
    [super dealloc];
}

@end
