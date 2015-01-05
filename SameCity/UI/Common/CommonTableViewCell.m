//
//  CommonTableViewCell.m
//  BBYT
//
//  Created by zengchao on 14-3-1.
//  Copyright (c) 2014年 babyun. All rights reserved.
//

#import "CommonTableViewCell.h"

@implementation CommonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageFoot = [[UIImageView alloc] initWithFrame:CGRectMake(00, 0, kMainScreenWidth, 1)];
        _imageFoot.image = ImageWithName(@"div_line");
        _imageFoot.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageFoot];

    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imageFoot = [[UIImageView alloc] initWithFrame:CGRectMake(00, 0, kMainScreenWidth, 1)];
    _imageFoot.image = ImageWithName(@"div_line");
//    _imageFoot.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageFoot];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageFoot.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}

- (void)dealloc
{
    RELEASE_SAFELY(_imageFoot);
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
