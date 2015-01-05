//
//  Province.m
//  aiyou
//
//  Created by zengchao on 12-11-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Province.h"

@implementation ProvinceDto

@synthesize enName = _enName;
@synthesize pid = _pid;
@synthesize name = _name;
@synthesize prefixLetter = _prefixLetter;

- (void)dealloc
{
    RELEASE_SAFELY(_enName)
    RELEASE_SAFELY(_pid)
    RELEASE_SAFELY(_name)
    RELEASE_SAFELY(_prefixLetter)
    
    [super dealloc];
}

- (void)getProvinceFrom:(NSDictionary *)Prodic
{
    NSString *enName_ = [[Prodic objectForKey:@"enName"] objectForKey:@"value"];
    if ([NSString isNotEmpty:enName_]) {
        self.enName = enName_;
    }
    
    NSString *id_ = [[Prodic objectForKey:@"id"] objectForKey:@"value"];
    if ([NSString isNotEmpty:id_]) {
        self.pid = id_;
    }
    
    NSString *name_ = [[Prodic objectForKey:@"name"] objectForKey:@"value"];
    if ([NSString isNotEmpty:name_]) {
        self.name = name_;
    }
    
    NSString *prefixLetter_ = [[Prodic objectForKey:@"prefixLetter"] objectForKey:@"value"];
    if ([NSString isNotEmpty:prefixLetter_]) {
        self.prefixLetter = prefixLetter_;
    }
}

@end

@implementation CityDto

@synthesize enName = _enName;
@synthesize cid = _cid;
@synthesize name = _name;
@synthesize prefixLetter = _prefixLetter;
@synthesize enName_p = _enName_p;
@synthesize pid = _pid;
@synthesize name_p = _name_p;
@synthesize prefixLetter_p = _prefixLetter_p;
@synthesize isSearchResult = _isSearchResult;

- (id)init
{
    if (self = [super init]) {
       self.isSearchResult = NO;
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_enName);
    RELEASE_SAFELY(_cid);
    RELEASE_SAFELY(_name);
    RELEASE_SAFELY(_prefixLetter);
    
    [super dealloc];
}

- (void)getCityFrom:(NSDictionary *)Prodic
{
    NSString *enName_ = [[Prodic objectForKey:@"enName"] objectForKey:@"value"];
    if ([NSString isNotEmpty:enName_]) {
        self.enName = enName_;
    }
    
    NSString *id_ = [[Prodic objectForKey:@"id"] objectForKey:@"value"];
    if ([NSString isNotEmpty:id_]) {
        self.cid = id_;
    }
    
    NSString *name_ = [[Prodic objectForKey:@"name"] objectForKey:@"value"];
    if ([NSString isNotEmpty:name_]) {
        self.name = name_;
    }
    
    NSString *prefixLetter_ = [[Prodic objectForKey:@"prefixLetter"] objectForKey:@"value"];
    if ([NSString isNotEmpty:prefixLetter_]) {
        self.prefixLetter = prefixLetter_;
    }
    else {
        self.prefixLetter = @"#";
    }
    
//    NSString *identify = [[Prodic objectForKey:@"name"] objectForKey:@"value"];
//    if ([NSString isNotEmpty:identify]) {
//        self.identify = identify;
//    }
}

@end