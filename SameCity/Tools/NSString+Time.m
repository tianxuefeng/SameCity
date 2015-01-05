//
//  NSString+Time.m
//  LYGInformationport
//
//  Created by zengchao on 14-2-18.
//  Copyright (c) 2014年 xweisoft. All rights reserved.
//

#import "NSString+Time.h"
#import "NSDate+TimeAgo.h"

@implementation NSString (Time)


+ (NSString *) getTimeString:(NSString *)timeString{
    
    if (![NSString isNotEmpty:timeString]) {
        return @"";
    }
    
    timeString = [timeString substringWithRange:NSMakeRange(0, 10)];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeString.doubleValue];
    // Calculate distance time string
    //
    // time= time/1000;
    return [time dateTimeAgo];
//    NSString *string = nil;
//    
//    int distance = [[NSDate date] timeIntervalSinceDate:time];
//
//    if (distance < 1){//avoid 0 seconds
//        string = @"刚刚";
//    }
//    else if (distance < 60) {
//        string = [NSString stringWithFormat:@"%d秒前", (distance)];
//    }
//    else if (distance < 3600) {//60 * 60
//        distance = distance / 60;
//        string = [NSString stringWithFormat:@"%d分钟前", (distance)];
//    }
//    else if (distance < 86400) {//60 * 60 * 24
//        distance = distance / 3600;
//        string = [NSString stringWithFormat:@"%d小时前", (distance)];
//    }
//    else if (distance < 604800) {//60 * 60 * 24 * 7
//        distance = distance / 86400;
//        string = [NSString stringWithFormat:@"%d天前", (distance)];
//    }
//    else if (distance < 2419200) {//60 * 60 * 24 * 7 * 4
//        distance = distance / 604800;
//        string = [NSString stringWithFormat:@"%d周前", (distance)];
//    }
//    else {
//        static NSDateFormatter *dateFormatter;
//        
//        if (dateFormatter == nil) {
//            dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
//        }
//        
//        string  = [dateFormatter stringFromDate:time];
//        
//    }
//    return string;
    
    
//    static NSDateFormatter *dateFormatter = nil;
//    
//    if (dateFormatter == nil) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    }
//    
//    return [dateFormatter stringFromDate:time];
}

+ (NSString *) getBBYTimeString:(NSString *)timeString
{
    if (![NSString isNotEmpty:timeString]) {
        return @"";
    }
    
    static NSDateFormatter *originalDateFormatter;
//    static NSDateFormatter *originalDateFormatter2;
    if (originalDateFormatter == nil) {
        originalDateFormatter = [[NSDateFormatter alloc] init];
        [originalDateFormatter setDateFormat:@"yyyyMMddHHmm"];
    }
    
//    if (originalDateFormatter2 == nil) {
//        originalDateFormatter2 = [[NSDateFormatter alloc] init];
//        [originalDateFormatter2 setDateFormat:@"yyyyMMddHHmmss"];
//    }
    
    NSDate *time = [originalDateFormatter dateFromString:timeString];
//    if (!time) {
//        time = [originalDateFormatter2 dateFromString:timeString];
//    }
        return [time dateTimeAgo];
//    NSString *string = nil;
//    
//    // Calculate distance time string
//    //
//    // time= time/1000;
//    int distance = [[NSDate date] timeIntervalSinceDate:time];
//    
//    if (distance < 1){//avoid 0 seconds
//        string = @"刚刚";
//    }
//    else if (distance < 60) {
//        string = [NSString stringWithFormat:@"%d秒前", (distance)];
//    }
//    else if (distance < 3600) {//60 * 60
//        distance = distance / 60;
//        string = [NSString stringWithFormat:@"%d分钟前", (distance)];
//    }
//    else if (distance < 86400) {//60 * 60 * 24
//        distance = distance / 3600;
//        string = [NSString stringWithFormat:@"%d小时前", (distance)];
//    }
//    else if (distance < 604800) {//60 * 60 * 24 * 7
//        distance = distance / 86400;
//        string = [NSString stringWithFormat:@"%d天前", (distance)];
//    }
//    else if (distance < 2419200) {//60 * 60 * 24 * 7 * 4
//        distance = distance / 604800;
//        string = [NSString stringWithFormat:@"%d周前", (distance)];
//    }
//    else {
//        static NSDateFormatter *dateFormatter;
//        
//        if (dateFormatter == nil) {
//            dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"MM月dd日HH:mm"];
//        }
//        
//        string  = [dateFormatter stringFromDate:time];
//        
//    }
//    return string;
}

//+ (NSString *) getBBYTNowTimeString
//{
//    static NSDateFormatter *dateFormatter = nil;
//    
//    if (dateFormatter == nil) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//    }
//    
//    NSString *string = [dateFormatter stringFromDate:[NSDate date]];
//    
//    return string;
//}


+ (NSString *)getXFTimeString:(NSString *)timeString
{
    if (![NSString isNotEmpty:timeString]) {
        return @"";
    }
    
//    if (![NSString isTimestamp:timeString]) {
//        return timeString;
//    }
    timeString = [timeString substringWithRange:NSMakeRange(0, 10)];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeString.longLongValue];
    // Calculate distance time string
    //
    // time= time/1000;
    int distance = [[NSDate date] timeIntervalSinceDate:time];
    NSString *string = nil;
    if (distance == 0){//avoid 0 seconds
        string = @"刚刚";
    }
    else if (distance > 0 && distance < 60) {
        string = [NSString stringWithFormat:@"%d秒前", (distance)];
    }
    else if (distance > 0 && distance < 3600) {//60 * 60
        distance = distance / 60;
        string = [NSString stringWithFormat:@"%d分钟前", (distance)];
    }
    else if (distance > 0 && distance < 86400) {//60 * 60 * 24
        distance = distance / 3600;
        string = [NSString stringWithFormat:@"%d小时前", (distance)];
    }
    else if (distance > 0 && distance < 604800) {//60 * 60 * 24 * 7
        distance = distance / 86400;
        string = [NSString stringWithFormat:@"%d天前", (distance)];
    }
    else if (distance > 0 && distance < 2419200) {//60 * 60 * 24 * 7 * 4
        distance = distance / 604800;
        string = [NSString stringWithFormat:@"%d周前", (distance)];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        
        string = [dateFormatter stringFromDate:time];
        
    }
    return string;
    
//    if (!timeString) {
//        return @"";
//    }
//    
//    
//    NSString *timestamp = [timeString substringWithRange:NSMakeRange(0, 13)];
//    NSDate *anyDate = [NSDate dateWithTimeIntervalSince1970:timeString.longLongValue];
//    
//    NSString *tmp = [timeString stringByReplacingOccurrencesOfString:timestamp withString:@""];
//    NSString *timezone = [NSString stringWithFormat:@"GMT%@",tmp];
//    //设置源日期时区
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:timezone];//或GMT
//    //设置转换后的目标日期时区
//    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    //得到源日期与世界标准时间的偏移量
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
//    //目标日期与本地时区的偏移量
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
//    //得到时间偏移量的差值
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    //转为现在时间
//    NSDate* destinationDateNow =  [NSDate dateWithTimeInterval:interval sinceDate:anyDate];
//
//    static NSDateFormatter *dateFormatter;
//    
//    if (dateFormatter == nil) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
//    }
//
//    return [dateFormatter stringFromDate:destinationDateNow];
}

@end
