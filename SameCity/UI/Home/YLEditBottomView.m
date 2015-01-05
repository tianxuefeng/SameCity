//
//  YLEditBottomView.m
//  YiLife
//
//  Created by zengchao on 14-7-30.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "YLEditBottomView.h"

@implementation YLEditBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, kMainScreenWidth, 49)];
    if (self) {
        // Initialization code
        
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.clipsToBounds = YES;
        addBtn.exclusiveTouch = YES;
        addBtn.frame = CGRectMake(0, 0, kMainScreenWidth*0.5, 49);
        addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        editBtn.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
//        [addBtn setImage:ImageWithName(@"edit_button") forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[ImageWithName(@"tab_btn_0") adjustSize] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[ImageWithName(@"tab_btn_0") adjustSize] forState:UIControlStateHighlighted];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addBtn setTitle:NSLocalizedString(btn_add, nil) forState:UIControlStateNormal];
        addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self addSubview:addBtn];
        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        
        editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.clipsToBounds = YES;
        editBtn.exclusiveTouch = YES;
        editBtn.frame = CGRectMake(kMainScreenWidth*0.5, 0, kMainScreenWidth*0.5, 49);
        editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        //        editBtn.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
//        [editBtn setImage:ImageWithName(@"edit_button") forState:UIControlStateNormal];
        [editBtn setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateNormal];
        [editBtn setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateHighlighted];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [editBtn setTitle:NSLocalizedString(btn_edit, nil) forState:UIControlStateNormal];
        editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self addSubview:editBtn];
        [editBtn addTarget:self action:@selector(updateTableView:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = self.frame.size.width/3;
        
        allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        allSelectBtn.clipsToBounds = YES;
        allSelectBtn.exclusiveTouch = YES;
        allSelectBtn.frame = CGRectMake(0, 0, width, 49);
        allSelectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [allSelectBtn setImage:ImageWithName(@"checked_btn_on") forState:UIControlStateNormal];
        [allSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [allSelectBtn setTitle:NSLocalizedString(lab_all_select, nil) forState:UIControlStateNormal];
        allSelectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [allSelectBtn setBackgroundImage:[ImageWithName(@"tab_btn_0") adjustSize] forState:UIControlStateNormal];
        [allSelectBtn setBackgroundImage:[ImageWithName(@"tab_btn_0") adjustSize] forState:UIControlStateHighlighted];
        [self addSubview:allSelectBtn];
        [allSelectBtn addTarget:self action:@selector(allSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        
        deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.clipsToBounds = YES;
        deleteBtn.exclusiveTouch = YES;
        deleteBtn.frame = CGRectMake(width, 0, width, 49);
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleteBtn setImage:ImageWithName(@"delete_btn_icon") forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deleteBtn setTitle:NSLocalizedString(title_delete, nil) forState:UIControlStateNormal];
        deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [deleteBtn setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateHighlighted];
        [self addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(allDelete:) forControlEvents:UIControlEventTouchUpInside];
        
        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.clipsToBounds = YES;
        cancelBtn.exclusiveTouch = YES;
        cancelBtn.frame = CGRectMake(width*2, 0, width, 49);
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setImage:ImageWithName(@"cancel_btn_icon") forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(btnNO, nil) forState:UIControlStateNormal];
        cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [cancelBtn setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[ImageWithName(@"tab_btn_1") adjustSize] forState:UIControlStateHighlighted];
        [self addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(updateTableView:) forControlEvents:UIControlEventTouchUpInside];
        
        editBtn.hidden = NO;
        allSelectBtn.hidden = YES;
        deleteBtn.hidden = YES;
        cancelBtn.hidden = YES;
        
        _allSelected = YES;
    }
    return self;
}

- (void)setAllSelected:(BOOL)allSelected
{
    _allSelected = allSelected;
    
    if (allSelected) {
        [allSelectBtn setImage:ImageWithName(@"checked_btn_off") forState:UIControlStateNormal];
        [allSelectBtn setTitle:NSLocalizedString(lab_all_unselect, nil) forState:UIControlStateNormal];
    }
    else {
        [allSelectBtn setImage:ImageWithName(@"checked_btn_on") forState:UIControlStateNormal];
        [allSelectBtn setTitle:NSLocalizedString(lab_all_select, nil) forState:UIControlStateNormal];
    }
}

- (void)updateTableView:(id)sender
{
    self.isEditing = !self.isEditing;
    
//    [mypublishTableView reloadData];
//    [mypublishTableView2 reloadData];
//    [mypublishTableView3 reloadData];
    //    [myfavTableView setEditing:!myfavTableView.editing animated:YES];
    if (self.isEditing) {
        
        CATransition *  tran=[CATransition animation];
        tran.removedOnCompletion = YES;
        tran.type = @"cube";
        tran.duration=0.32;
        tran.subtype = kCATransitionFromTop;
        [self.layer addAnimation:tran forKey:@"kongyu"];
        
        editBtn.hidden = YES;
        allSelectBtn.hidden = NO;
        deleteBtn.hidden = NO;
        cancelBtn.hidden = NO;
    }
    else {
        
        CATransition *  tran=[CATransition animation];
        tran.removedOnCompletion = YES;
        tran.type = @"cube";
        tran.duration=0.32;
        tran.subtype = kCATransitionFromBottom;
        [self.layer addAnimation:tran forKey:@"kongyu"];
        
        editBtn.hidden = NO;
        allSelectBtn.hidden = YES;
        deleteBtn.hidden = YES;
        cancelBtn.hidden = YES;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(YLEditBottomViewStateChaneged:)]) {
        [self.delegate YLEditBottomViewStateChaneged:self];
    }
}

- (void)allSelectClick:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(YLEditBottomViewAllSelect:)]) {
        [self.delegate YLEditBottomViewAllSelect:self];
    }
    
    self.allSelected = !self.allSelected;
}

- (void)allDelete:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(YLEditBottomViewDelete:)]) {
        [self.delegate YLEditBottomViewDelete:self];
    }
}

- (void)addClick:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(YLEditBottomViewAdd:)]) {
        [self.delegate YLEditBottomViewAdd:self];
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
