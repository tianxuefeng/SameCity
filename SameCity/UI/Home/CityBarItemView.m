//
//  CityBarItemView.m
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CityBarItemView.h"

@implementation CityBarItemView


+ (instancetype)shareInstance {
    static CityBarItemView *_sharedClient = nil;
    static dispatch_once_t onceTokens;
    dispatch_once(&onceTokens, ^{
        _sharedClient = [[CityBarItemView alloc] init];
    });
    
    return _sharedClient;
}

- (void)dealloc
{
    RELEASE_SAFELY(_cityLb);
    
    [super dealloc];
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 80, 44)];
    if (self) {
        // Initialization code
        
        UIView *cityBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        _cityLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        self.cityLb.textAlignment = NSTextAlignmentCenter;
        self.cityLb.text = NSLocalizedString(title_narrow_region, nil);
        self.cityLb.textColor = [UIColor whiteColor];
        self.cityLb.backgroundColor = [UIColor clearColor];
        self.cityLb.numberOfLines = 2;
        self.cityLb.font = [UIFont systemFontOfSize:15];
        
        UIImageView *arrows = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0, 20, 44)];
        arrows.contentMode = UIViewContentModeCenter;
        arrows.image = ImageWithName(@"arrows_down");
        
        [cityBg addSubview:arrows];
        [cityBg addSubview:self.cityLb];
        
        [self addSubview:cityBg];
        
        _acButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.acButton.frame = self.bounds;
        [self addSubview:self.acButton];
        
        RELEASE_SAFELY(arrows);
        RELEASE_SAFELY(cityBg);
    }
    return self;
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
