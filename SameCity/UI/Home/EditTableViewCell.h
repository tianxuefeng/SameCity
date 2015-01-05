//
//  EditTableViewCell.h
//  samecity
//
//  Created by zengchao on 14-10-13.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_CELL_HEIGHT     50

@class EditTableViewCell;

typedef enum {
    kFeedStatusNormal = 0,
    kFeedStatusLeftExpanded = 1,
    kFeedStatusLeftExpanding = 2,
}kFeedStatus;

typedef enum {
    FeedCellDirectionNone = 0,
    FeedCellDirectionRight = 1,
    FeedCellDirectionLeft = 2,
} FeedCellDirection;

@protocol EditCellDelegate <NSObject>

@optional
- (void)EditCellShowMenu:(EditTableViewCell *)target;

//- (void)FMDownloadManagerCellShare:(FMDownloadManagerCell *)target;

- (void)EditCellUpdate:(EditTableViewCell *)target;

- (void)EditCellDelete:(EditTableViewCell *)target;

@end

@interface EditTableViewCell : UITableViewCell
{
//    UIView *bottomView;
    
    UIImageView *iconImageView;
    
    UIButton *updateBtn;
    UIButton *deleteBtn;
    
    UIView *bottom;
}

@property (nonatomic ,assign) NSInteger row;

@property (nonatomic ,assign) id <EditCellDelegate> delegate;

//@property (nonatomic ,assign) BOOL isSelect;

//@property (nonatomic ,assign) BOOL canEdit;

//@property (nonatomic ,assign) BOOL isEditing;

@property (nonatomic ,strong) UILabel *titleLb;

//@property (nonatomic ,strong) UILabel *contentLb;

//@property (nonatomic ,strong) UILabel *timeLb;

@property (nonatomic ,assign) kFeedStatus currentStatus;

- (void)_slideInContentViewFromDirection;

//- (void)reloadUI;

//+ (CGFloat)getMessageCellHeight:(NSString *)string;

@end
