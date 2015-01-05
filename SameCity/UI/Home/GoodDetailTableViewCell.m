//
//  GoodDetailTableViewCell.m
//  samecity
//
//  Created by zengchao on 14-8-3.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "GoodDetailTableViewCell.h"

@implementation GoodDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _contentLb = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLb.backgroundColor = [UIColor clearColor];
        _contentLb.textColor = COLOR_TITLE;
        _contentLb.font = [UIFont systemFontOfSize:17];
        _contentLb.numberOfLines = 0;
        [self.contentView addSubview:self.contentLb];
    }
    return self;
}

- (void)reloadUI
{
    if (![NSString isNotEmpty:_contentLb.text]) {
        _contentLb.text = NSLocalizedString(history_NoInfo, nil);
    }
    
    CGSize size = [NSString calculateTextHeight:self.contentLb.font givenText:_contentLb.text givenWidth:kMainScreenWidth-30];
    _contentLb.frame = CGRectMake(20, 5, kMainScreenWidth-30, size.height+5);
}

+ (CGFloat)getCellheight:(NSString *)contentStr
{
    if (![NSString isNotEmpty:contentStr]) {
        contentStr = NSLocalizedString(history_NoInfo, nil);
    }
    CGSize size = [NSString calculateTextHeight:[UIFont systemFontOfSize:17] givenText:contentStr givenWidth:kMainScreenWidth-30];
    return size.height+20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    RELEASE_SAFELY(_contentLb);
    
    [super dealloc];
}

@end

@implementation GoodDetailTableViewCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 44)];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = COLOR_TITLE;
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.numberOfLines = 0;
        [self.contentView addSubview:self.titleLb];
        
        _contentLb = [[UILabel alloc] initWithFrame:CGRectMake(15+50, 0, kMainScreenWidth*0.5-15-50, 44)];
        _contentLb.backgroundColor = [UIColor clearColor];
        _contentLb.textColor = COLOR_CONTENT;
        _contentLb.font = [UIFont systemFontOfSize:14];
        _contentLb.numberOfLines = 0;
        [self.contentView addSubview:self.contentLb];
        
        _titleLb2 = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth*0.5+10, 0, 50, 44)];
        _titleLb2.backgroundColor = [UIColor clearColor];
        _titleLb2.textColor = COLOR_TITLE;
        _titleLb2.font = [UIFont systemFontOfSize:14];
        _titleLb2.numberOfLines = 0;
        [self.contentView addSubview:self.titleLb2];
        
        
        _contentLb2 = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth*0.5+10+50, 0, kMainScreenWidth*0.5-10-50, 44)];
        _contentLb2.backgroundColor = [UIColor clearColor];
        _contentLb2.textColor = COLOR_CONTENT;
        _contentLb2.font = [UIFont systemFontOfSize:14];
        _contentLb2.numberOfLines = 0;
        [self.contentView addSubview:self.contentLb2];
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_contentLb);
    RELEASE_SAFELY(_contentLb2);
    RELEASE_SAFELY(_titleLb);
    RELEASE_SAFELY(_titleLb2);
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
