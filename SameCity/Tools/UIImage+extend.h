//
//  UIImage+extend.h
//  linphone
//
//  Created by  on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (extend)

- (UIImage *)addImageReflection:(CGFloat)reflectionFraction;
//+ (UIImage *)imageNamed:(NSString *)name;
- (UIImage *)adjustSize;

+ (UIImage *)loadImageNamed:(NSString *)Name;

+ (UIImage *)backgroundGradientImageWithSize:(CGSize)size;

//上传头像时用
-(UIImage*)scaleToSize:(CGSize)size;


//调整图片大小
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

- (UIImage *)circleImageWithParam:(CGFloat)inset AndColor:(UIColor *)color;

- (UIImage *) renderAtSize:(const CGSize) size;
- (UIImage *) maskWithImage:(const UIImage *) maskImage;
+ (UIImage *) imageWithColor:(UIColor *)color;
/*
 *videoURL:视频地址(本地/网络)
 *time      :第N帧
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

//+ (UIImage *)imageNamed:(NSString *)name;



@end
