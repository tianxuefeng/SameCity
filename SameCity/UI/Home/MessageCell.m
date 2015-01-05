//
//  MessageCell.m
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        replyLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 15)];
        replyLb.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:replyLb];
        
        messageLb = [[UILabel alloc] init];
        messageLb.font = [UIFont systemFontOfSize:16];
        messageLb.numberOfLines = 0;
        [self.contentView addSubview:messageLb];
        
        levelLb = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-80, 5, 60, 15)];
        levelLb.font = [UIFont systemFontOfSize:15];
        levelLb.textColor = [UIColor grayColor];
        levelLb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:levelLb];
        
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(replyLb);
    RELEASE_SAFELY(messageLb);
    
    self.replyString = nil;
    RELEASE_SAFELY(_item);
    RELEASE_SAFELY(levelLb);
    
    [super dealloc];
}

- (void)setItem:(MessageItem *)item
{
    AUTORELEASE_SAFELY(_item);
    
    if (item) {
        //
        _item = [item retain];

        
        if ([NSString isNotEmpty:_replyString]) {
            replyLb.text = self.replyString;
        }
        else {
            replyLb.text = @"测试用户名";
        }
        
        messageLb.text = item.Msg;
        
        levelLb.text = [NSString stringWithFormat:@"#%d％@",self.row+1,NSLocalizedString(title_floor, nil)];
        
        CGSize size = [NSString calculateTextHeight:messageLb.font givenText:item.Msg givenWidth:280];
        
        messageLb.frame = CGRectMake(20, 30, 280, size.height);
        
    }
}

+ (CGFloat)getMessageCellHeight:(MessageItem *)mess
{
    CGSize size = [NSString calculateTextHeight:[UIFont systemFontOfSize:15] givenText:mess.Msg givenWidth:280];
    
    return size.height + 50;
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
