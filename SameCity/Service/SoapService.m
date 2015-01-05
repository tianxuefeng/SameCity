//
//  SoapService.m
//  SameCity
//
//  Created by zengchao on 14-4-22.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "SoapService.h"

@implementation ResponseData 

@end

@implementation SoapService

-(id)initWithPostUrl:(NSString *)url SoapAction:(NSString *)soapAction{
    self=[super init];
    if(self){
        self.PostUrl=url;
        self.SoapAction=soapAction;
        self.isLoading = NO;
    }
    return self;
}

-(ResponseData *)PostSync:(NSString *)postData{
    
    NSMutableURLRequest *request=[self CreatRequest:postData];
    // Response对象，用来得到返回后的数据，比如，用statusCode==200 来判断返回正常
    NSHTTPURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response error:nil];
    // 处理返回的数据
    NSString *strReturn = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    ResponseData *result=[[ResponseData alloc] init];
    result.StatusCode=response.statusCode;
    result.Content=strReturn;

    return result;
}

-(void)PostAsync:(NSString *)postData Success:(SuccessBlock)success falure:(FailureBlock)failure{
    NSMutableURLRequest *request=[self CreatRequest:postData];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray *components = [operation.responseString componentsSeparatedByString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
         NSString *responseString = components[0];
         
         NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
         
         success([responseData fetchedData]);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         failure(error);
     }];
    [operation start];
}

-(NSMutableURLRequest *)CreatRequest:(NSString *)postData
{
    // 要请求的地址
    NSString *urlString=self.PostUrl;
    // 将地址编码
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 实例化NSMutableURLRequest，并进行参数配置
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    if(self.Timeout){
        [request setTimeoutInterval: self.Timeout];
    }else{
        [request setTimeoutInterval: 30];
    }
    if(self.SoapAction){
        [request addValue:self.SoapAction forHTTPHeaderField:@"SOAPAction"];
    }
    if(self.ContentType){
        [request addValue:self.ContentType forHTTPHeaderField:@"Content-Type"];
    }else{
        [request addValue:@"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
//    if(self.UserAgent){
//        [request addValue:self.UserAgent forHTTPHeaderField:@"User-Agent"];
//    }else{
//        [request addValue:@"IOS App (power by elliott)" forHTTPHeaderField:@"User-Agent"];
//    }
    if(self.AcceptEncoding){
        [request addValue:self.AcceptEncoding forHTTPHeaderField:@"Accept-Encoding"];
    }
    
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];

    return request;
}

- (void)postAsyncSuccess:(SuccessBlock)success falure:(FailureBlock)falure
{

}

@end
