//
//  RegionData.m
//  SameCity
//
//  Created by zengchao on 14-7-13.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "RegionData.h"
#import "AppDelegate.h"

@implementation RegionData

//http://api.dangqian.com/apidiqu2/api.asp?format=json&callback=wjr&id=000000000000

- (id)init
{
    if (self = [super init]) {
        //
        net = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.dangqian.com"]];
        net.responseSerializer = [AFHTTPResponseSerializer serializer];
        net.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"text/plain",@"text/html", nil];
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(net);
    
    [super dealloc];
}

- (void)postRegionCode:(NSString *)cityCode
{
//    NSURL *url = [NSURL URLWithString:@"http://api.dangqian.com/apidiqu2/api.asp?format=json&callback=wjr&id=320100000000"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    self.isLoading = YES;
    
    __unsafe_unretained RegionData *weakSelf = self;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addObject:@"json" forKey:@"format"];
    [dic addObject:@"wjr" forKey:@"callback"];
    [dic addObject:cityCode forKey:@"id"];
    
    [net GET:@"apidiqu2/api.asp" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        NSString *responseStr = operation.responseString;
        responseStr = [responseStr stringByReplacingOccurrencesOfString:@"wjr(" withString:@""];
        responseStr = [responseStr stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        NSData* jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        
        weakSelf.isLoading = NO;
        
        NSDictionary *jsonObject = [jsonData fetchedData];
        
        NSDictionary *list = [jsonObject objectForKey:@"list"];
        
        NSMutableArray *items = [NSMutableArray array];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages objectAtIndex:0];
    
        NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_CITY];
        
        if (list && [list isKindOfClass:[NSDictionary class]]) {
            //
            for (NSDictionary *wjr in list.allValues) {

                RegionItem *item = [[RegionItem alloc] initWithDictionary:wjr error:nil];
                
                if (item) {
                    CustomRegionItem *item_temp = [[CustomRegionItem alloc] init];
                    item_temp.isCustom = NO;
                    item_temp.ParentRegionName = cityName;
                    item_temp.RegionName = item.diming;
                    item_temp.LanguageCode = currentLanguage;
                    [items addObject:item_temp];
                    RELEASE_SAFELY(item_temp);
                }
                RELEASE_SAFELY(item);
            }
        }
        
        
        if ( weakSelf.delegate && [ weakSelf.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [weakSelf.delegate httpService:weakSelf Succeed:items];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        weakSelf.isLoading = NO;
        
        if ( weakSelf.delegate && [ weakSelf.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [weakSelf.delegate httpService:self Failed:error];
        }
    }];
    
//    [net HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //
//        
//        self.isLoading = NO;
//        
//         NSMutableArray *items = [NSMutableArray array];
//        
//        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
//            [self.delegate httpService:self Succeed:items];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //
//        
//        self.isLoading = NO;
//        
//        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
//            [self.delegate httpService:self Failed:error];
//        }
//    }];
}

- (void)postCustomRegionParentRegionName:(NSString *)name andRegionName:(NSString *)rname
{
    self.isLoading = YES;
    
    __unsafe_unretained RegionData *bSelf = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addObject:name forKey:@"ParentRegionName"];
    [dic addObject:rname forKey:@"RegionName"];
    [dic addObject:currentLanguage forKey:@"LanguageCode"];
    
    [self PostAsync:combineStr(REGION_SERVICE_URL, GET_INSERT_REGION_URL) andParams:dic Success:^(NSObject *response) {
        //
        bSelf.isLoading = NO;
        
        if ( bSelf.delegate && [bSelf.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [bSelf.delegate httpService:bSelf Succeed:nil];
        }
        
    } falure:^(NSError *error) {
        //
        bSelf.isLoading = NO;
        
        if ( bSelf.delegate && [bSelf.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [bSelf.delegate httpService:bSelf Failed:error];
        }
    }];
}

- (void)getCustomRegionListParentRegionName:(NSString *)name
{
    self.isLoading = YES;
    
    __unsafe_unretained RegionData *bSelf = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addObject:name forKey:@"ParentRegionName"];
    [dic addObject:currentLanguage forKey:@"LanguageCode"];
    
    [self PostAsync:combineStr(REGION_SERVICE_URL, GET_REGION_LIST_URL) andParams:dic Success:^(NSObject *response) {
        //
        bSelf.isLoading = NO;
        
        NSMutableArray *items = [NSMutableArray array];
        
        if (response && [response isKindOfClass:[NSArray class]]) {
            for (NSDictionary *tmpDic in (NSArray *)response) {
                CustomRegionItem *indexDto = [[CustomRegionItem alloc] initWithDictionary:tmpDic error:nil];
                if (indexDto) {
                    indexDto.isCustom = YES;
                    [items addObject:indexDto];
                }
                RELEASE_SAFELY(indexDto);
            }
        }
        
        if ( bSelf.delegate && [ bSelf.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [bSelf.delegate httpService:bSelf Succeed:items];
        }
        
    } falure:^(NSError *error) {
        //
        bSelf.isLoading = NO;
        
        if ( bSelf.delegate && [ bSelf.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [bSelf.delegate httpService:bSelf Failed:error];
        }
    }];

}

- (void)deleteRegionName:(NSString *)ID
{
    self.isLoading = YES;
    
    __unsafe_unretained RegionData *bSelf = self;
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
//    NSString *currentLanguage = [languages objectAtIndex:0];
//    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addObject:ID forKey:@"ID"];

    [self PostAsync:combineStr(REGION_SERVICE_URL, @"DeleteRegion") andParams:dic Success:^(NSObject *response) {
        //
        bSelf.isLoading = NO;
        
        NSMutableArray *items = [NSMutableArray array];
        
        if (response && [response isKindOfClass:[NSArray class]]) {

        }
        
        if ( bSelf.delegate && [ bSelf.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [bSelf.delegate httpService:bSelf Succeed:items];
        }
        
    } falure:^(NSError *error) {
        //
        bSelf.isLoading = NO;
        
        if ( bSelf.delegate && [ bSelf.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [bSelf.delegate httpService:bSelf Failed:error];
        }
    }];
}

- (void)updateRegionName:(NSString *)name regionID:(NSString *)ID
{
    self.isLoading = YES;
    
    __unsafe_unretained RegionData *bSelf = self;

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addObject:name forKey:@"RegionName"];
    [dic addObject:ID forKey:@"ID"];
    
    [self PostAsync:combineStr(REGION_SERVICE_URL, @"UpdateRegion") andParams:dic Success:^(NSObject *response) {
        //
        bSelf.isLoading = NO;
        
        NSMutableArray *items = [NSMutableArray array];
        
        if (response && [response isKindOfClass:[NSArray class]]) {
            
        }
        
        if ( bSelf.delegate && [ bSelf.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [bSelf.delegate httpService:bSelf Succeed:items];
        }
        
    } falure:^(NSError *error) {
        //
        bSelf.isLoading = NO;
        
        if ( bSelf.delegate && [ bSelf.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [bSelf.delegate httpService:bSelf Failed:error];
        }
    }];
}

@end
