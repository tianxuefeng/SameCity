//
//  SoapUtility.h
//  SameCity
//
//  Created by zengchao on 14-4-22.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXML.h"
#import "DDXMLElement+WSDL.h"

@interface SoapUtility : NSObject

-(id)initFromFile:(NSString *)filename;

-(id)init;

-(NSString *)BuildSoapwithMethodName:(NSString *)methodName withParas:(NSDictionary *)parasdic;

-(NSString *)BuildSoap12withMethodName:(NSString *)methodName withParas:(NSDictionary *)parasdic;

-(NSString *)GetSoapActionByMethodName:(NSString *)methodName;

@end
