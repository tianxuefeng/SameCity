//
//  Province.h
//  aiyou
//
//  Created by zengchao on 12-11-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceDto : NSObject

@property (nonatomic ,retain) NSString *enName;
@property (nonatomic ,retain) NSString *pid;
@property (nonatomic ,retain) NSString *name;
@property (nonatomic ,retain) NSString *prefixLetter;

- (void)getProvinceFrom:(NSDictionary *)Prodic;

@end

@interface CityDto : NSObject

@property (nonatomic ,retain) NSString *enName;
@property (nonatomic ,retain) NSString *cid;
@property (nonatomic ,retain) NSString *name;
@property (nonatomic ,retain) NSString *prefixLetter;
@property (nonatomic ,retain) NSString *identify;

@property (nonatomic ,retain) NSString *enName_p;
@property (nonatomic ,retain) NSString *pid;
@property (nonatomic ,retain) NSString *name_p;
@property (nonatomic ,retain) NSString *prefixLetter_p;
@property (nonatomic ,assign) BOOL isSearchResult;

- (void)getCityFrom:(NSDictionary *)Prodic;

@end