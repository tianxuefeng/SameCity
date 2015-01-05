//
//  ReplyView.m
//  BBYT
//
//  Created by zengchao on 14-3-15.
//  Copyright (c) 2014年 babyun. All rights reserved.
//

#import "ReplyView.h"

@implementation ReplyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        isFirst = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillHide:)
													 name:UIKeyboardWillHideNotification
												   object:nil];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
	// Do any additional setup after loading the view.
    self.backgroundColor = UIColorFromRGB(0xdddddd);
    originalFrame  = self.frame;
    
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 5, 240-12, self.frame.size.height)];
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 4;
	textView.returnKeyType = UIReturnKeyDefault; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor clearColor];
    
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[[UIImageView alloc] initWithImage:entryBackground] autorelease];
    entryImageView.frame = CGRectMake(6, 0, 240-12, self.frame.size.height);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
//    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
//    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
//    UIImageView *imageView = [[[UIImageView alloc] init] autorelease];
//    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
//    [self addSubview:imageView];
    [self addSubview:entryImageView];
    [self addSubview:textView];
//    [entryImageView release];
    
	_doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.doneBtn.frame = CGRectMake(self.frame.size.width - 69, 7.5, 63, 25);
    self.doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
	[self.doneBtn setTitle:NSLocalizedString(title_reply, nil) forState:UIControlStateNormal];
    self.doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.doneBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneBtn setBackgroundImage:[[UIImage imageWithColor:[UIColor whiteColor]] adjustSize] forState:UIControlStateNormal];
    self.doneBtn.layer.masksToBounds = YES;
    self.doneBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.doneBtn.layer.borderWidth = 0.5;
	[self addSubview:self.doneBtn];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)sendBtnClick:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(replyViewDidSend:)]) {
        [self.delegate replyViewDidSend:self];
    }
}

- (void)dealloc
{
    self.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    textView.delegate = nil;
    RELEASE_SAFELY(textView);
    
    [super dealloc];
}

- (NSString *)text
{
    return textView.text;
}

- (void)setText:(NSString *)text
{
    textView.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    textView.placeholder = placeholder;
}

- (NSString *)placeholder
{
    return textView.placeholder;
}

//// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView {
//
////    [super loadView];
//    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
//    self.view.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
//
//
//}

- (BOOL)isTextFirstResponder
{
    return isFirst;
}

- (void)becomeTextView
{
	[textView becomeFirstResponder];
}

- (void)resignTextView
{
	[textView resignFirstResponder];
}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    
    isFirst = YES;
    
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.superview convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = self.frame;
    containerFrame.origin.y = self.superview.frame.size.height - (keyboardBounds.size.height + containerFrame.size.height);
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	self.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    
    isFirst = NO;
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
//	CGRect containerFrame = self.frame;
//    containerFrame.origin.y = self.superview.frame.size.height - originalFrame.size.height;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	self.frame = CGRectMake(0, kMainScreenHeight-64-40, kMainScreenWidth, 40);
	
	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	self.frame = r;
}

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
    if (_delegate && [_delegate respondsToSelector:@selector(replyViewBeginEditing:)]) {
        [self.delegate replyViewBeginEditing:self];
    }
    
    if (growingTextView.text) {
        NSUInteger length = growingTextView.text.length;
        growingTextView.selectedRange = NSMakeRange(length,0);
    }
}

- (BOOL)growingTextViewShouldEndEditing:(HPGrowingTextView *)growingTextView
{
//    RELEASE_SAFELY(saveString);
//    if (growingTextView.text) {
//        saveString = [growingTextView.text copy];
//    }
    growingTextView.text = @"";
    return YES;
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    if (growingTextView.isEditing && _delegate && [_delegate respondsToSelector:@selector(replyViewDidChanged:)]) {
        [self.delegate replyViewDidChanged:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
