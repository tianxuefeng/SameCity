//
//  XFConstant.h
//  samecity
//
//  Created by zengchao on 14-4-20.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#ifndef samecity_XFConstant_h
#define samecity_XFConstant_h

#define AdMoGoVersion @"1.5.4"
#define MoGo_ID_IPhone @"01464587d4ce490cb1749ca06322e686"
//#define  MoGo_ID_IPhone   @"bb0bf739cd8f4bbabb74bbaa9d2768bf"

//安全释放
#define RELEASE_SAFELY(__REF) { if (nil != (__REF)) { [(__REF) release]; __REF = nil; } }
#define AUTORELEASE_SAFELY(__REF) { if (nil != (__REF)) { [(__REF) autorelease]; __REF = nil; } }

#define IOS7    SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")


#define SYSTEM_VERSION_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedDescending)

//角度转换为弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLOR_BG        UIColorFromRGB(0xf0f0f0)
#define COLOR_CONTENT   UIColorFromRGB(0x828282)
#define COLOR_TITLE     UIColorFromRGB(0x121212)
#define COLOR_TIME      UIColorFromRGB(0x8a8a8a)

#define COLOR_THEME            UIColorFromRGB(0xae0002)

#define COLOR_BOTTOM_BG        UIColorFromRGB(0x655d52)

#define kMainScreenFrameRect   [[UIScreen mainScreen] bounds]

//设备屏幕宽
#define kMainScreenWidth  kMainScreenFrameRect.size.width

//设备屏幕高度
#define kMainScreenHeight kMainScreenFrameRect.size.height

#define ImageWithName(name)\
[UIImage imageNamed:name]

#define ImageWithFile(pathN)\
[UIImage imageWithContentsOfFile:pathN]

#define AlertMessage(tipMsg)    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:\
tipMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];\
[alertView show];\
RELEASE_SAFELY(alertView)

#define AlertMessageArc(tipMsg)    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:\
tipMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];\
[alertView show];

#endif
