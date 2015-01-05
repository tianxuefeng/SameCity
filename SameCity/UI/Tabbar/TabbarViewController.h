//
//  TabbarViewController.h
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tabbar.h"

@class TabbarViewController;

@protocol TabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(TabbarViewController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(TabbarViewController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end

@interface TabbarViewController : UIViewController <TabbarDelegate>
{
	Tabbar *_tabBar;
	UIView      *_containerView;
	UIView		*_transitionView;
	id<TabBarControllerDelegate> _delegate;
	NSMutableArray *_viewControllers;
	NSUInteger _selectedIndex;
	
	BOOL _tabBarTransparent;
	BOOL _tabBarHidden;
    
    NSInteger animateDriect;
    
    
}

@property (nonatomic ,retain) UIImage *backgroundImage;

@property (nonatomic ,retain) NSArray *imageArrs;
@property (nonatomic ,retain) NSArray *titleArrs;

@property(nonatomic, copy) NSMutableArray *viewControllers;

@property(nonatomic, readonly) UIViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

// Apple is readonly
@property (nonatomic, readonly) Tabbar *tabBar;
@property(nonatomic,assign) id<TabBarControllerDelegate> delegate;


// Default is NO, if set to YES, content will under tabbar
@property (nonatomic) BOOL tabBarTransparent;
@property (nonatomic) BOOL tabBarHidden;

@property(nonatomic,assign) NSInteger animateDriect;

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr andTitleArray:(NSArray *)arr2;

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
//- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated driect:(NSInteger)driect;

// Remove the viewcontroller at index of viewControllers.
- (void)removeViewControllerAtIndex:(NSUInteger)index;

// Insert an viewcontroller at index of viewControllers.
- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;

@end


@interface UIViewController (TabBarControllerSupport)
@property(nonatomic, readonly) TabbarViewController *leveyTabBarController;

@end
