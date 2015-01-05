//
//  Global.m
//  samecity
//
//  Created by zengchao on 14-8-3.
//  Copyright (c) 2014年 com.stefan. All rights reserved.
//

#import "Global.h"
#import "XlsReader.h"
#import "CoreDataEnvir.h"
#import "AppDelegate.h"

//系统Doc文件夹
inline NSString *SystemDoc() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docPath=[paths objectAtIndex:0];
    return docPath;
}


inline NSString *UserPath() {
    NSString *MplistPath = [SystemDoc() stringByAppendingPathComponent:@"DefaultUser.archive"];
    return MplistPath;
}

@implementation Global

+ (Global *)ShareCenter {
    static Global *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Global alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    if (self = [super init]) {
        
        _cityLists_sorted = [[NSMutableArray alloc] init];
        _firstArray = [[NSMutableArray alloc] init];
        _isSorted = NO;
    }
    return self;
}

- (void)initCitys
{
    //    BOOL isDown =  [[NSUserDefaults standardUserDefaults] boolForKey:@"cityIsDown"];
    if (!citysSet) {
        citysSet = [[NSMutableSet alloc] init];
    }
    
    if (!cityLists) {
        cityLists = [[NSMutableArray alloc] init];
    }
    
    //复位
    [citysSet removeAllObjects];
    [cityLists removeAllObjects];
    [self.cityLists_sorted removeAllObjects];
    [self.firstArray removeAllObjects];
    self.isSorted = NO;
    //
    //    if (isDown) {
    //        CityDAO *cDAO = [[CityDAO alloc] init];
    //        [cDAO getAllCityList:cityLists];
    //        TT_RELEASE_SAFELY(cDAO)
    //        for (CityDto *cdto in cityLists) {
    //            //填装首字母Set
    //            [citysSet addObject:[NSDictionary dictionaryWithObjectsAndKeys:cdto.prefixLetter,@"firstLetter", nil]];
    //        }
    //        [self sortCityArray];
    //    }
    //    else {
    //        CityDAO *cDAO = [[CityDAO alloc] init];
    //        //清空城市列表数据
    //        [cDAO deleteAllCitys];
    //        [self initCityHttp];
    //        TT_RELEASE_SAFELY(cDAO)
    //    }
    [XlsReader traversingVector:@"Citys" withArr:cityLists ofSet:citysSet];
    
    [self sortCityArray];
}

- (void)sortCityArray
{
    @synchronized(self)//确保每次该方法都能走完
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                
                //排序
                NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"firstLetter" ascending:YES];
                
                NSArray *sortDescriptors = [NSArray arrayWithObjects:sd, nil];
                
                NSMutableArray *tmpSectionArray = [NSMutableArray arrayWithArray:[[citysSet allObjects] sortedArrayUsingDescriptors:sortDescriptors]];
               
//                NSObject *haha = [tmpSectionArray objectAtIndex:0];
                
                if ([tmpSectionArray count] > 0 && [[[tmpSectionArray objectAtIndex:0] objectForKey:@"firstLetter"] isEqualToString:@"#"])
                {
                    [tmpSectionArray removeObjectAtIndex:0];
                    [tmpSectionArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"#",@"firstLetter", nil]];
                }
                [sd release];
                
                for (NSDictionary *firstDic in tmpSectionArray)
                {
                    NSMutableArray *tmpArray = [NSMutableArray array];
                    
                    NSString *fStr = [firstDic objectForKey:@"firstLetter"];
                    [self.firstArray addObject:fStr];
                    
                    for (CityDto *cdto in cityLists)
                    {
                        if ([cdto.prefixLetter isEqualToString:fStr])
                        {
                            [tmpArray addObject:cdto];
                        }
                    }
                    [self.cityLists_sorted addObject:tmpArray];
                }
                
                self.isSorted = YES;
                //    for (int i=0; i<[self.cityLists_sorted count]; i++) {
                //        DLog(@"%@",[(NSArray *)[self.cityLists_sorted objectAtIndex:i] debugDescription])
                //    }
                
                //                DLog(@"%d.....%d",cityLists.count,ij)
                
                RELEASE_SAFELY(citysSet)
                RELEASE_SAFELY(cityLists)
            }});
    }
}

- (NSArray *)getMainCateArray
{
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    NSArray *cates = [MainCate itemsInContext:[CoreDataEnvir instance]];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    if (cates && [cates isKindOfClass:[NSArray class]]) {
        for (MainCate *cate in cates) {
            
            CategoryItem *item = [[CategoryItem alloc] init];
            
            item.ID = cate.cID;
            item.Title = cate.title;
            item.Description = cate.desc;
            item.ParentID = @"0";
            item.CountryCode = cate.countryCode;
            item.Images = cate.images;
            
            [resultArr addObject:item];
            
            [item release];
        }
    }
    return resultArr;
}

- (MainCate *)insertNewCates:(CategoryItem *)item
{
    if (!item) {
        return nil;
    }
    
    CoreDataEnvir *db = [CoreDataEnvir instance];
    
    MainCate *cate = [MainCate lastItemInContext:db usingPredicate:[NSPredicate predicateWithFormat:@"cID=%@", item.ID]];
    if (!cate) {
        //Inset item.
        cate = [MainCate insertItemInContext:db];
        
        cate.cID = item.ID;
        cate.title = item.Title;
        cate.desc = item.Description;
        cate.countryCode = item.CountryCode;
        cate.images = item.Images;
    }
    
    [cate saveTo:db];
    
    return cate;
}

- (void)deleteAllCates
{
    CoreDataEnvir *db = [CoreDataEnvir instance];
    
    NSArray *array = [MainCate itemsInContext:db];
    if (array && [array isKindOfClass:[NSArray class]]) {
        //Inset item.
        for (MainCate *item in array) {
            [item removeFrom:db];
        }
    }
    
    [db saveDataBase];
}

- (NSArray *)getRecordArray
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    NSArray *records = [Record itemsInContext:[CoreDataEnvir instance] sortDescriptions:[NSArray arrayWithObjects:sort, nil] withFormat:nil];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    if (records && [records isKindOfClass:[NSArray class]]) {
        for (Record *record in records) {
            
            HomePageItem *item = [[HomePageItem alloc] init];
            
            item.ID = record.rID;
            item.Title = record.title;
            item.CategoryID = record.categoryID;
            item.City = record.city;
            item.CountryCode = record.countryCode;
            item.Description = record.desc;
            item.CreateDate = record.createDate;
            item.Phone = record.phone;
            item.Price = record.price ;
            item.QQSkype = record.qqSkype ;
            item.Region = record.region;
            item.Sequence = record.sequence;
            item.UserID = record.userID;
            item.Images = record.images;
            
            [resultArr addObject:item];
            
            [item release];
        }
    }
    return resultArr;
}

- (Record *)insertNewRecord:(HomePageItem *)item
{
    if (!item) {
        return nil;
    }
    
    CoreDataEnvir *db = [CoreDataEnvir instance];
    Record *record = [Record lastItemInContext:db usingPredicate:[NSPredicate predicateWithFormat:@"rID=%@", item.ID]];
    if (!record) {
        //Inset item.
        record = [Record insertItemInContext:db];
        
        record.rID = item.ID;
        record.title = item.Title;
        record.categoryID = item.CategoryID;
        record.city = item.City;
        record.countryCode = item.CountryCode;
        record.desc = item.Description;
        record.createDate = item.CreateDate;
        record.phone = item.Phone;
        record.price = item.Price;
        record.qqSkype = item.QQSkype;
        record.region = item.Region;
        record.sequence = item.Sequence;
        record.userID = item.UserID;
        record.images = item.Images;
    }
    
    record.timestamp = [NSDate date];
    
    [record saveTo:db];
    
    return record;
}

- (void)setCountry:(NSString *)country
{
    if (country) {
        [[NSUserDefaults standardUserDefaults] setObject:country forKey:DEFAULT_COUNTRY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setCity:(NSString *)city
{
    if (city) {
        [[NSUserDefaults standardUserDefaults] setObject:city forKey:DEFAULT_CITY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setRegion:(NSString *)region
{
    if (region) {
        [[NSUserDefaults standardUserDefaults] setObject:region forKey:DEFAULT_REGION];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)country
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_COUNTRY];
}

- (NSString *)city
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_CITY];

}

- (NSString *)region
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_REGION];
    
}

@end
