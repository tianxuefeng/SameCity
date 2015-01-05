//
//  HomePageCell.m
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "HomePageCell.h"
#import "UIImageView+WebCache.h"

@implementation HomePageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.contentView.backgroundColor = COLOR_BG;
        
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, self.frame.size.width-30, self.frame.size.width-30)];
        iconImageView.clipsToBounds = YES;
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:iconImageView];
        
        titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-35, self.frame.size.width-20, 35)];
        titleLb.font = [UIFont systemFontOfSize:13];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = COLOR_TITLE;
        titleLb.numberOfLines = 2;
        titleLb.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:titleLb];
    }
    return self;
}

- (void)setCItem:(CategoryItem *)cItem
{
    AUTORELEASE_SAFELY(_cItem);
    
    if (cItem) {
        _cItem = [cItem retain];
        
        NSString *imageUrl = [NSString stringWithFormat:@"http://%@/images/%@",HOST,cItem.Images];

        __unsafe_unretained UIImageView *weakSelf = iconImageView;
        
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:ImageWithName(@"default_img")  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //
            if (cacheType == SDImageCacheTypeNone) {
                CATransition *animation = [CATransition animation];
                animation.duration = 0.32;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = kCATransitionFade;
                animation.removedOnCompletion = YES;
                [[weakSelf layer] addAnimation:animation forKey:@"animation"];
            }
        }];
        
        titleLb.text = cItem.Title;
    }
}

- (void)dealloc
{
    RELEASE_SAFELY(iconImageView);
    RELEASE_SAFELY(titleLb);
    
    [super dealloc];
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
