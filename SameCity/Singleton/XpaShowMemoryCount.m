//
//  XpaShowMemoryCount.m
//  XpaApp
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XpaShowMemoryCount.h"
#import <mach/mach.h>

#define THISTEXTWIDTH 700.f
@implementation XpaShowMemoryCount
static XpaShowMemoryCount* _xpaShowMemoryCount = nil;

+(XpaShowMemoryCount*)shareInstance
{
    return _xpaShowMemoryCount = _xpaShowMemoryCount ?_xpaShowMemoryCount: [[XpaShowMemoryCount alloc] init];
}

+(void)clearInstance
{
    if(_xpaShowMemoryCount)
    {
        [ _xpaShowMemoryCount  release];
        _xpaShowMemoryCount = nil;
    }
}

//1毫秒一次
-(id)init
{
    self = [super init];
    if(self)
    {
        _uiTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 50, THISTEXTWIDTH, THISTEXTWIDTH)];
        _uiTextView.userInteractionEnabled = NO;
        _uiTextView.editable = NO;
        [_uiTextView setBackgroundColor:[UIColor clearColor]];
        [_uiTextView setTextColor:[UIColor blackColor]];
        [_uiTextView setTextAlignment:NSTextAlignmentLeft];
        
        [_uiTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:22]];
        
    //    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    return self;
}

-(void)showMemory
{
    if(_showMemoryTimer == nil)
    {
        [[UIApplication sharedApplication].keyWindow addSubview:_uiTextView];
        _showMemoryTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(refresh) userInfo:nil repeats:YES];
        
    }  
}

-(void)closeMemory
{
    if(_showMemoryTimer)
    {
        [_uiTextView removeFromSuperview];
        [_showMemoryTimer invalidate];
        _showMemoryTimer = nil;
    }
}

//刷新
-(void)refresh
{
    //因为要处理横竖屏的问题,所以frame的大小应该正好包含整个字符
    [_uiTextView setText:[self reportMemory]];
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if(interfaceOrientation ==UIInterfaceOrientationLandscapeLeft)
    {
        _uiTextView.transform = CGAffineTransformMakeRotation(-M_PI/2);

        [_uiTextView setFrame:CGRectMake(0,1024-THISTEXTWIDTH,THISTEXTWIDTH,THISTEXTWIDTH)];


    }
    else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        _uiTextView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        [_uiTextView setFrame:CGRectMake(768 - THISTEXTWIDTH,0,THISTEXTWIDTH,THISTEXTWIDTH)];
  
    }
    
    //
//        //home键在上

    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_uiTextView];
    
}

-(NSString *)reportMemory
{
    struct task_basic_info info;

    mach_msg_type_number_t size = sizeof(info);

    kern_return_t kerr = task_info(mach_task_self(),
                               
                               TASK_BASIC_INFO,
                               
                               (task_info_t)&info,
                               
                               &size);

    if( kerr == KERN_SUCCESS ) {
        NSLog(@"Memory used: %fM", info.resident_size/1024/1024.0); 
        return [NSString stringWithFormat:@"Memory used: %.2f M",info.resident_size/1024/1024.0];
     //   NSLog(@"Memory used: %fM", info.resident_size/1024/1024.0); //in M
    
    } else {
        return @"";
        NSLog(@"Error: %s", mach_error_string(kerr));
    }
}

-(void)dealloc
{
    [_uiTextView release];
    
    [super dealloc];
}

-(void)breakPoint:(NSString*)thisBreakPoint
{
    //待实现
}

-(void)removeBreakPoint:(NSString*)thisBreakPoint
{
    //待实现
}

@end
