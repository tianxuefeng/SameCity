//
//  EditCateViewController.h
//  samecity
//
//  Created by zengchao on 14-10-13.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "CommonViewController.h"
#import "CategoryData.h"

@protocol EditCateViewControllerDelegate <NSObject>

- (void)EditCateViewControllerSucceed;

//- (void)EditCateSelect:(NSString *)text;

@end

@interface EditCateViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate,HttpServiceDelegate>
{
    CategoryData *cateData;
    CategoryData *addCateRequest;
    
    UITableView *cateTableView;
    
    BOOL isChanged;
}

@property (nonatomic ,assign) id<EditCateViewControllerDelegate>delegate;

@property (nonatomic ,retain) NSString *parentID;

@property (nonatomic ,retain) NSMutableArray *items;

@end
