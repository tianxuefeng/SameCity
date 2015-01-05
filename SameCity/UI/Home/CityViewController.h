//
//  CityViewController.h
//  SameCity
//
//  Created by zengchao on 14-6-28.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "CommonViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CommonTextField.h"
#import "RegionData.h"

@interface CityViewController : CommonViewController<HttpServiceDelegate>
{
    IBOutlet TPKeyboardAvoidingScrollView *bgScrollView;
    
    IBOutlet UIButton *locationBtn;
    
    IBOutlet UIButton *enterBtn;
    
    IBOutlet UIButton *citySelectBtn;
    IBOutlet UIButton *regionSelectBtn;
    
    IBOutlet UILabel *countryLb;
    IBOutlet UILabel *cityLb;
    IBOutlet UILabel *regionLb;
    IBOutlet UILabel *tipsLb;
    
    IBOutlet UIButton *city_selectBtn;
    IBOutlet UIButton *region_selectBtn;
    
    IBOutlet UIButton *enter_selectBtn;
    
    RegionData *addRegionRequest;
}

@property (nonatomic ,retain) NSString *selectCityID;

@property (nonatomic ,retain) NSString *selectCityName;

@property (nonatomic ,retain) IBOutlet UILabel *statusLb;

@property (nonatomic ,retain) IBOutlet CommonTextField *countryText;

@property (nonatomic ,retain) IBOutlet CommonTextField *cityText;

@property (nonatomic ,retain) IBOutlet CommonTextField *regionText;

- (IBAction)buttonClick:(id)sender;

@end
