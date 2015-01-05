//
//  SoapUtility.m
//  SameCity
//
//  Created by zengchao on 14-4-22.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "SoapUtility.h"


@interface SoapUtility(){
    DDXMLElement *rootelement;
}

@end

@implementation SoapUtility

-(id)initFromFile:(NSString *)filename{
    self=[super init];
    if(self){
        rootelement=[DDXMLElement LoadWSDL:filename];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}


-(NSString *)BuildSoapwithMethodName:(NSString *)methodName withParas:(NSDictionary *)parasdic
{
    // <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
	//     <soap:Header/>
	//     <soap:Body>
	//     <parameters xmlns="http://xxxx.com"/>
    //          <param1></param1>
    //          <param2></param2>
    //          <param3></param3>
	//     </parameters/>
	//     </soap:Body>
	// </soap:Envelope>
    
    
    //根节点
    DDXMLElement *ddRoot = [DDXMLElement elementWithName:@"soap:Envelope"];
    //根节点的命名空间
    [ddRoot addNamespace:[DDXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"]];
    [ddRoot addNamespace:[DDXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"]];
    [ddRoot addNamespace:[DDXMLNode namespaceWithName:@"soap" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"]];

    //body
    DDXMLElement *ddBody = [DDXMLElement elementWithName:@"soap:Body"];
    
    //消息体的命名空间
    DDXMLNode *ddmsgNS = [DDXMLNode namespaceWithName:@"" stringValue:[NSString stringWithFormat:@"http://%@/",HOST]];
    DDXMLElement *msg= [DDXMLElement elementWithName:methodName];
    [msg addNamespace:ddmsgNS];
    
    //给消息体添加参数列表，并赋值
    for(NSString *param in parasdic.allKeys){
        NSString *paramValue=[parasdic objectForKey:param];
        DDXMLElement *paranode=[DDXMLElement elementWithName:param stringValue:paramValue];
        [msg addChild:paranode];
    }
    [ddBody addChild:msg];
    [ddRoot addChild:ddBody];
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>%@",[ddRoot XMLString]];
}

-(NSString *)BuildSoap12withMethodName:(NSString *)methodName withParas:(NSDictionary *)parasdic
{
    // <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
	//     <soap:Header/>
	//     <soap:Body>
	//     <parameters xmlns="http://xxxx.com"/>
    //          <param1></param1>
    //          <param2></param2>
    //          <param3></param3>
	//     </parameters/>
	//     </soap:Body>
	// </soap:Envelope>
    
    //根节点
    DDXMLElement *ddRoot = [DDXMLElement elementWithName:@"soap12:Envelope"];
    //根节点的命名空间
    [ddRoot addNamespace:[DDXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"]];
    [ddRoot addNamespace:[DDXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"]];
    [ddRoot addNamespace:[DDXMLNode namespaceWithName:@"soap12" stringValue:@"http://www.w3.org/2003/05/soap-envelope/"]];
    
    //body
    DDXMLElement *ddBody = [DDXMLElement elementWithName:@"soap12:Body"];
    
    //消息体的命名空间
    DDXMLNode *ddmsgNS = [DDXMLNode namespaceWithName:@"" stringValue:[NSString stringWithFormat:@"http://%@/",HOST]];
    DDXMLElement *msg= [DDXMLElement elementWithName:methodName];
    [msg addNamespace:ddmsgNS];
    
    //给消息体添加参数列表，并赋值
    for(NSString *param in parasdic.allKeys){
        NSString *paramValue=[parasdic objectForKey:param];
        DDXMLElement *paranode=[DDXMLElement elementWithName:param stringValue:paramValue];
        [msg addChild:paranode];
    }
    [ddBody addChild:msg];
    [ddRoot addChild:ddBody];
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>%@",[ddRoot XMLString]];
}

-(NSString *)GetSoapActionByMethodName:(NSString *)methodName{
    return [NSString stringWithFormat:@"http://%@/%@",HOST,methodName];
}
@end
