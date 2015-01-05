//
//  RegionData.h
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HttpService.h"
#import "RegionItem.h"
#import "CustomRegionItem.h"

@interface RegionData : HttpService
{
    AFHTTPRequestOperationManager *net;
}

- (void)postRegionCode:(NSString *)cityCode;

- (void)postCustomRegionParentRegionName:(NSString *)name andRegionName:(NSString *)rname;

- (void)getCustomRegionListParentRegionName:(NSString *)name;

- (void)deleteRegionName:(NSString *)ID;

- (void)updateRegionName:(NSString *)name regionID:(NSString *)ID;

@end
