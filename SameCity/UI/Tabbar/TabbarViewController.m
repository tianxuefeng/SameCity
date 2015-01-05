//
//  TabbarViewController.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "TabbarViewController.h"

#define kTabBarHeight 49.0f

static TabbarViewController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (TabbarViewController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

@interface TabbarViewController (private)

- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation TabbarViewController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize animateDriect;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr andTitleArray:(NSArray *)arr2
{
	self = [super init];
	if (self != nil)
	{
        self.imageArrs = arr;
        self.titleArrs = arr2;
        
		self.viewControllers = [NSMutableArray arrayWithArray:vcs];
		
        leveyTabBarController = self;
        animateDriect = 0;
	}
	return self;
}

- (void)loadView
{
	[super loadView];
	
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    _transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _containerView.frame.size.height - kTabBarHeight)];
    //		_transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    
    _tabBar = [[Tabbar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, kMainScreenWidth, kTabBarHeight) buttonImages:self.imageArrs andButtonTitles:self.titleArrs];
    if (_backgroundImage) {
        [_tabBar setBackgroundImage:_backgroundImage];
    }
    _tabBar.delegate = self;
    
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
    
	self.view = _containerView;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#endif

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BG;
	_transitionView.backgroundColor = COLOR_BG;
    _containerView.backgroundColor = COLOR_BG;
    
    self.selectedIndex = 0;
    
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.modalPresentationCapturesStatusBarAppearance = YES;
        self.extendedLayoutIncludesOpaqueBars = YES;
        //        self.automaticallyAdjustsScrollViewInsets = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}

- (void)dealloc
{
    self.titleArrs = nil;
    self.imageArrs = nil;
    _tabBar.delegate = nil;
    self.backgroundImage = nil;
    [_tabBar release];
    [_containerView release];
    [_transitionView release];
    [_viewControllers release];
    [super dealloc];
}

#pragma mark - instant methods

- (Tabbar *)tabBar
{
	return _tabBar;
}

- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}

- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - kTabBarHeight);
	}
}

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
		{
			return;
		}
	}
    
    if (yesOrNO) {
        self.tabBarTransparent = YES;
    }
    else {
        self.tabBarTransparent = NO;
    }
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO == YES)
		{
            
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else
		{
            //            self.tabBarTransparent = NO;
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else
	{
		if (yesOrNO == YES)
		{
            //                self.tabBarTransparent = YES;
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else
		{
            //            self.tabBarTransparent = NO;
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}


//- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
//{
//    [self hidesTabBar:yesOrNO animated:animated driect:animateDriect];
//}
//
//- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated driect:(NSInteger)driect
//{
//    // driect: 0 -- 上下  1 -- 左右
//
//    NSInteger kTabBarWidth = [[UIScreen mainScreen] applicationFrame].size.width;
//
//	if (yesOrNO == YES)
//	{
//        if (driect == 0)
//        {
//            if (self.tabBar.frame.origin.y == self.view.frame.size.height)
//            {
//                return;
//            }
//        }
//        else
//        {
//            if (self.tabBar.frame.origin.x == 0 - kTabBarWidth)
//            {
//                return;
//            }
//        }
//	}
//	else
//	{
//        if (driect == 0)
//        {
//            if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
//            {
//                return;
//            }
//        }
//        else
//        {
//            if (self.tabBar.frame.origin.x == 0)
//            {
//                return;
//            }
//        }
//	}
//
//	if (animated == YES)
//	{
//		[UIView beginAnimations:nil context:NULL];
//		[UIView setAnimationDuration:0.3f];
//		if (yesOrNO == YES)
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0 - kTabBarWidth, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//		else
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//		[UIView commitAnimations];
//	}
//	else
//	{
//		if (yesOrNO == YES)
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0 - kTabBarWidth, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//		else
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//	}
//}

- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}

- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}

#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)])
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0)
    {
        return;
    }
    
    _selectedIndex = index;
    
	UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];
	
	selectedVC.view.frame = _transitionView.frame;
    
    for (UIView *tmpView in _transitionView.subviews) {
        [tmpView removeFromSuperview];
    }
    
	if ([selectedVC.view isDescendantOfView:_transitionView])
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
	}
    
    // Notify the delegate, the viewcontroller has been changed.
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [_delegate tabBarController:self didSelectViewController:selectedVC];
    }
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(Tabbar *)tabBar didSelectIndex:(NSInteger)index
{
	if (self.selectedIndex == index) {
        UINavigationController *nav = [self.viewControllers objectAtIndex:index];
        [nav popToRootViewControllerAnimated:YES];
    }else {
        [self displayViewAtIndex:index];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
