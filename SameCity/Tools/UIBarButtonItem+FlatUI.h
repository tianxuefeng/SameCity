//
//  UIBarButtonItem+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FlatUI)

// removes the text shadows off a single bar button item (sadly, this can't be easily done for all buttons simultaneously)
//- (void) removeTitleShadow;

//+ (UIBarButtonItem *) createBarButtonItemWithImage:(UIImage *)image highlightedImage:(UIImage *)hightlightedImage target:(id)target action:(SEL)action NS_AVAILABLE_IOS(5_0);

+ (UIBarButtonItem *)createBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action NS_AVAILABLE_IOS(5_0);

+ (UIBarButtonItem *)createBackBarButtonItemTarget:(id)target action:(SEL)action NS_AVAILABLE_IOS(5_0);

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
