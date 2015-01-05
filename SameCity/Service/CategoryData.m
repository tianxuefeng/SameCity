//
//  CategoryData.m
//  SameCity
//
//  Created by zengchao on 14-6-12.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CategoryData.h"

@implementation CategoryData

- (id)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)getCategoryListParentID:(NSString *)parentID
{
    self.tag = CATEGORY_DATA_TAG;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
	NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params addObject:currentLanguage forKey:@"LanguageCode"];
    [params addObject:parentID forKey:@"ParentID"];
    
    [self GetAsync:combineStr(CATE_SERVICE_URL, GET_CATEGORY_LIST_URL) andParams:params Success:^(NSObject *response) {
        //
        
        NSMutableArray *items = [NSMutableArray array];
        
        if (response && [response isKindOfClass:[NSArray class]]) {
            for (NSDictionary *tmpDic in (NSArray *)response) {
                CategoryItem *cateDto = [[CategoryItem alloc] initWithDictionary:tmpDic error:nil];
                if (cateDto) {
                    [items addObject:cateDto];
                }
                RELEASE_SAFELY(cateDto);
            }
        }
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:items];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)insertNewCategory:(CategoryItem *)newItem
{
    self.tag = CATEGORY_INSERT_TAG;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    newItem.CountryCode = currentLanguage;
    newItem.Sequence = @"1";
    
    [self PostAsync:combineStr(CATE_SERVICE_URL, POST_INSERT_CATE_URL) andParams:[newItem toDictionary] Success:^(NSObject *response) {
        //
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)updateNewCategory:(CategoryItem *)newItem
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    newItem.CountryCode = currentLanguage;
    newItem.Sequence = @"1";

    NSString *CreateUser = newItem.CreateUser;
    
    newItem.CreateUser = nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:[newItem toDictionary]];
    [params addObject:CreateUser forKey:@"UpdateUser"];
    
    [self PostAsync:combineStr(CATE_SERVICE_URL, @"UpdateCategory") andParams:params Success:^(NSObject *response) {
        //
        
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

- (void)deleteNewCategoryID:(NSString *)ID
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas addObject:ID forKey:@"ID"];
    
    [self PostAsync:combineStr(CATE_SERVICE_URL, @"DeleteCategory") andParams:parmas Success:^(NSObject *response) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Succeed:)]) {
            [self.delegate httpService:self Succeed:response];
        }
        
    } falure:^(NSError *error) {
        //
        if ( self.delegate && [ self.delegate respondsToSelector:@selector(httpService:Failed:)]) {
            [self.delegate httpService:self Failed:error];
        }
    }];
}

@end
