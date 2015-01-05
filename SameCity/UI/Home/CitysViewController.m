//
//  CitysViewController.m
//  aiyou
//
//  Created by zengchao on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CitysViewController.h"
#import "ComponentsFactory.h"
#import "UIImage+extend.h"
#import "Global.h"
#import "UserLogin.h"
#import "NewRegionViewController.h"

#define TableViewIndexTimerOffset        0.2f
#define TableViewIndexAnimationDuration  0.4f

#define SearchBarPlaceholder @"输入数字、拼音、首字母搜索"

@interface CitysViewController ()<NewRegionViewControllerDelegate>

@end

@implementation CitysViewController
@synthesize sectionArray = _sectionArray;
@synthesize sectionDataArray = _sectionDataArray;
@synthesize filterContactArray = _filterContactArray;
@synthesize searchSectionArray = _searchSectionArray;

@synthesize cityTable = _cityTable;
@synthesize searchBar = _searchBar;
@synthesize searchDisplayControl = _searchDisplayControl;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(lab_city, nil);
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_cityTable)
    RELEASE_SAFELY(_sectionArray)
    RELEASE_SAFELY(_sectionDataArray)
    RELEASE_SAFELY(_filterContactArray)
    RELEASE_SAFELY(_searchSectionArray)
    
    RELEASE_SAFELY(_searchBar)
    RELEASE_SAFELY(_searchDisplayControl)
    
    self.delegate = nil;
    
    [super dealloc];
}

- (void)back
{
    if (_delegate && [_delegate respondsToSelector:@selector(CityDidSelect:)]) {
        [_delegate CityDidSelect:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupNavi
{
    [super setupNavi];
    
    UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [UIBarButtonItem  createBarButtonItemWithTitle:NSLocalizedString(btn_add, nil) target:self action:@selector(addNew)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _sectionDataArray = [[NSMutableArray alloc] initWithArray:[[Global ShareCenter] cityLists_sorted]];
    _sectionArray = [[NSMutableArray alloc] initWithArray:[[Global ShareCenter] firstArray]];
//    self.sectionDataArray = [[DataManagerCenter ShareCenter] cityLists_sorted];
//    self.sectionArray = [[DataManagerCenter ShareCenter] firstArray];
    
    _filterContactArray = [[NSMutableArray alloc] init];
    _searchSectionArray = [[NSMutableArray alloc] init];
    
//    DLog(@"%@",self.sectionArray.debugDescription)
    
    self.cityTable.tag = 11;
    self.searchDisplayControl.searchResultsTitle = NSLocalizedString(title_search, nil);
}

- (void)addNew
{
    __unsafe_unretained CitysViewController *bSelf = self;
    
    [[UserLogin instanse] loginFrom:self succeed:^{
        //
        NewRegionViewController *next = [[NewRegionViewController alloc] init];
        next.title = NSLocalizedString(lab_local_add_area, nil);
        next.delegate = bSelf;
        [bSelf.navigationController pushViewController:next animated:YES];
    }];
}

- (UITableView *)cityTable
{
    if (!_cityTable) {
        _cityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:UITableViewStylePlain];
        _cityTable.delegate = self;
        _cityTable.dataSource = self;
        _cityTable.rowHeight = 48;
//        _cityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_cityTable];
        [_cityTable setEditing:NO animated:YES];
    }
    return _cityTable;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[CustomSearchbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMainScreenWidth, 44.0f)];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
//        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.keyboardType = UIKeyboardTypeDefault;
//        [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
//        [_searchBar sizeToFit];
        _searchBar.delegate = self;
        [self.cityTable setTableHeaderView:_searchBar];
    }
    return _searchBar;
}

- (UISearchDisplayController *)searchDisplayControl
{
    if (!_searchDisplayControl) {
        _searchDisplayControl = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchDisplayControl.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _searchDisplayControl.searchResultsTableView.rowHeight = 48;
        _searchDisplayControl.searchResultsDataSource = self;
        _searchDisplayControl.searchResultsDelegate = self;	
        _searchDisplayControl.delegate = self;
    }
    return _searchDisplayControl;
}


- (void)hideTheIndexTitle:(id)params
{
    [_tableIndexTitleTimer invalidate];
    _tableIndexTitleTimer = nil;
    
    void (^animation)(void) = ^(void)
    {
        [_tableIndexTitleView setAlpha:0.0f];
        //NSLog(@"hideTheIndexTitle :: animation");
    };
    void (^animationEnd)(BOOL finished) = ^(BOOL finished)
    {
        [_tableIndexTitleView setHidden:YES];
        //NSLog(@"hideTheIndexTitle :: animationEnd");
    };
    [UIView animateWithDuration:TableViewIndexAnimationDuration animations:animation completion:animationEnd];
}

- (void)showIndexTitles:(NSString *)title index:(NSInteger)index
{
    if (_tableIndexTitleTimer != nil && [_tableIndexTitleTimer isValid])
    {
        [_tableIndexTitleTimer invalidate];
        _tableIndexTitleTimer = nil;
    }
    
    if (_tableIndexTitleView == nil)
    {
//        NSString * path = [[NSBundle mainBundle] pathForResource:@"tableview_title_index_bg" ofType:@"png"];
        //        NSString * path = [[NSBundle mainBundle] pathForResource:@"calling_btn_bg" ofType:@"png"];
        UIImage * image = [UIImage imageNamed:@"tableview_title_index2_bg.png"];
        _tableIndexTitleView = [[UIImageView alloc] initWithImage:image];
        [_tableIndexTitleView setBackgroundColor:[UIColor clearColor]];
        CGSize superSize = self.view.bounds.size;
        float x = (superSize.width  - image.size.width) / 2;
        float y = (superSize.height - image.size.height -44) / 2;
        [_tableIndexTitleView setFrame:CGRectMake(x, y, image.size.width, image.size.height)];
        [self.view addSubview:_tableIndexTitleView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:_tableIndexTitleView.bounds];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont boldSystemFontOfSize:32]];
        [_tableIndexTitleView addSubview:label];
        _tableIndexTitleLabel = label;
        [label release];
    }
    
    [_tableIndexTitleView setHidden:NO];
    [_tableIndexTitleView setAlpha:1.0f];
    [_tableIndexTitleLabel setText:title];
    
    if (_tableIndexTitleTimer == nil)
    {
        _tableIndexTitleTimer = [NSTimer scheduledTimerWithTimeInterval:TableViewIndexTimerOffset 
                                                                 target:self 
                                                               selector:@selector(hideTheIndexTitle:) 
                                                               userInfo:nil 
                                                                repeats:NO];
    }
}

#pragma mark --
#pragma mark -- UItableviewDelagte

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    if (tableView == self.cityTable) 
    {
//        return [NSArray arrayWithObjects:
//                UITableViewIndexSearch,
//                @"A", @"B", @"C", @"D", @"E", @"F", @"G",
//                @"H", @"I", @"J", @"K", @"L", @"M", @"N",
//                @"O", @"P", @"Q", @"R", @"S", @"T", @"U", 
//                @"V", @"W", @"X", @"Y", @"Z", @"#", nil];
        NSMutableArray *tmpSectionArr = [[NSMutableArray alloc] initWithArray:self.sectionArray copyItems:YES];
        [tmpSectionArr insertObject:UITableViewIndexSearch atIndex:0];
        return [tmpSectionArr autorelease];
    
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //    NSInteger retPos = -1; /*无效的位置*/
    /*因为特殊字符，如@"#"比@“A”小，但是＃必须要显示在Z后面，所有需要单独处理*/
    
	if (title == UITableViewIndexSearch) 
	{
		[self.cityTable scrollRectToVisible:_searchBar.frame animated:YES];
		return -1;
	}
    else if([title isEqualToString:@"#"])
    {
        [self showIndexTitles:title index:index];
        return [self.sectionArray count] - 1;
    }
    else
    {
        [self showIndexTitles:title index:index];
        
        for (int i = 0; i < [_sectionArray count]; i ++) 
        {
            if ([[_sectionArray objectAtIndex:i] isEqualToString:title]) 
            {
                return i;
            }
        }
    }
    return -1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{     
    if (tableView == _cityTable) 
    {
        return [_sectionArray count];
    }
    else {
        return [_filterContactArray count];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _cityTable) 
    {
        return [(NSArray *)[_sectionDataArray objectAtIndex:section] count];
    }
//    else if (bIsSearching && searchTextLength != 0) 
//    {
//       return [(NSMutableArray*)[_filterContactArray objectAtIndex:section] count];
//    }
    else {
        return [(NSArray *)[_filterContactArray objectAtIndex:section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    } 
    for (UIView *view in [cell.contentView subviews]) 
    {
        [view removeFromSuperview];
    }
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:cell.frame];
    bgView.image = [[UIImage imageNamed:@"list_center_bg.png"] adjustSize];
    cell.backgroundView = bgView;
    [bgView release];
    
    UIView *selectView = [[UIView alloc] initWithFrame:cell.frame];
    selectView.backgroundColor = COLOR_THEME;
    cell.selectedBackgroundView = selectView;
    [selectView release];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    if (tableView == self.cityTable) {
        if (_sectionDataArray) {
            CityDto *cdto = [[self.sectionDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.textLabel.text = cdto.name;
        }
    }else {
        
        if (_filterContactArray) {
            CityDto *cdto = [[self.filterContactArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.textLabel.text = cdto.name;
        }

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    if (tableView == _cityTable) 
    {
            if ([_sectionArray objectAtIndex:section])
            {
                title = [_sectionArray objectAtIndex:section];
            }
    }
    else 
    {
        title = ((CityDto *)[[_filterContactArray objectAtIndex:section] objectAtIndex:0]).prefixLetter;
    }
    return [ComponentsFactory sectionLabelWithText:title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _cityTable) {
        if (_sectionDataArray) {
            CityDto *cdto = [[self.sectionDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if (_delegate && [_delegate respondsToSelector:@selector(CityDidSelect:)]) {
                [_delegate CityDidSelect:cdto];
            }
        }
    }
    else {
        if (_filterContactArray) {
            CityDto *cdto = [[self.filterContactArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if (_delegate && [_delegate respondsToSelector:@selector(CityDidSelect:)]) {
                [_delegate CityDidSelect:cdto];
            }
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - searchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar 
{
    bIsSearching = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar 
{
    bIsSearching = NO;
    searchTextLength = 0;
    [_searchBar resignFirstResponder];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    //added by wangjizeng  判断是否应该停止搜索
    int totalCount = 0;
    for (int i = 0; i < [_filterContactArray count]; i++) 
    {
        NSMutableArray *array = [_filterContactArray objectAtIndex:i];
        
        totalCount += [array count];
    }
    if (_oldSearchStr && totalCount==0 && [searchText hasPrefix:_oldSearchStr])
    {
        return;
    }
    RELEASE_SAFELY(_oldSearchStr)
    _oldSearchStr = [searchText retain];
    //add by wangjizeng 
    [self filterForSearchText:searchText];
}

//搜索
- (void)filterForSearchText:(NSString *)searchText
{
    // 搜索数据初始化
    [_filterContactArray removeAllObjects];
    [_searchSectionArray removeAllObjects];
    
    searchTextLength = [searchText length];
    if (searchTextLength == 0) 
    {
        return;
    }
    else 
    {
        // 判断是否包含中文
        BOOL isHasChinese = NO;
//        for (int i = 0; i < searchTextLength; i++) 
//        {
//            unichar c = [searchText characterAtIndex:i];
//            NSString *s = [NSString stringWithFormat:@"%C",c];
//            if ([s isMatchedByRegex:@"[\u4e00-\u9fa5]"]) 
//            {
//                isHasChinese = YES;
//                break;
//            }
//        }
        // 开始过滤匹配        
        for (int i = 0; i < [_sectionDataArray count]; i++) 
        {
            NSArray *array = [_sectionDataArray objectAtIndex:i];

            for (int j = 0; j < [array count]; j++) 
            {
                CityDto *city = [array objectAtIndex:j];
                
                city.isSearchResult = NO;
//                if (isHasChinese) 
//                {
                    // 如果搜索的文字中包含中文，只匹配完整名字
                    BOOL range = [city.enName hasPrefix:searchText];
                    if (range) 
                    {
                        city.isSearchResult = YES;
//                        [tmpArr addObject:city];
                    }
//                }
//                else 
//                {
//                    NSString *searchTextPinyin = [[[VoipDataManagerCenter shareDataCenter] getFullPinyinString:searchText] lowercaseString];
//                    // 匹配全拼
                    if ([city.name containsString:searchText]) 
                    {
                        city.isSearchResult = YES;
                    }
                    // 匹配首字母
//                    range = [person.firstLetterAry rangeOfString:searchTextPinyin];
//                    if (range.location != NSNotFound) 
//                    {
//                        person.isSearchResult = YES;
//                    }
//                }
            }
        }
        
        // 过滤不是搜索结果的字符串，生成搜索数据数组
        for (int i = 0; i < [_sectionDataArray count]; i++) 
        {
            NSArray *array = [_sectionDataArray objectAtIndex:i];
            
            NSMutableArray *tmpArr = [[NSMutableArray alloc] init]; 
            
            for (int j = 0; j < [array count]; j++)
            {
                CityDto *city = [array objectAtIndex:j];
                
                if (city.isSearchResult)
                {
                    [tmpArr addObject:city];
                }
            }
            
            if ([tmpArr count] != 0)
            {
                [_filterContactArray addObject:tmpArr];
            }
            
            RELEASE_SAFELY(tmpArr)
        }
    }
    // 生成搜索首字母索引数组
    for (int i = 0; i < [_filterContactArray count]; i++) 
    {
        NSArray *array = [_filterContactArray objectAtIndex:i];
        for (int j = 0; j < [array count]; j++) 
        { 
            CityDto *city = [array objectAtIndex:j];
            BOOL bIsFristLetterExist = [self isFirstLetterExist:city.prefixLetter];
            if (!bIsFristLetterExist) 
            {
                [_searchSectionArray addObject:city];
            }
        }
    }
//    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (BOOL)isFirstLetterExist:(NSString *)firstLetter 
{
    for (CityDto *city in _searchSectionArray) 
    {
        if ([city.prefixLetter isEqualToString:firstLetter]) 
        {
            return YES;
        }
    }
    return NO;
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{

}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//@implementation CityNaviController
//@synthesize cityVC = _cityVC;
//
//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
//{
//    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        _cityVC = [[CitysViewController alloc] init];
//        [self initWithRootViewController:_cityVC];
//        
//    }
//    return self;
//}
//
//- (void)dealloc
//{
//    [_cityVC release];
//    [super dealloc];
//}
//
//@end
