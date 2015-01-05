//
//  UserLogin.m
//  SameCity
//
//  Created by zengchao on 14-4-23.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "UserLogin.h"
#import "LoginViewController.h"
#import "CommonNavigationController.h"
#import "AppDelegate.h"
#import "Global.h"

@interface UserLogin()<LoginDelegate,UINavigationControllerDelegate>

@property (nonatomic ,copy) LoginVoidBlock succeedBlock;

@end

@implementation UserLogin

+ (UserLogin *)instanse {
    static UserLogin *_sharedClient = nil;
    static dispatch_once_t onceTokens;
    dispatch_once(&onceTokens, ^{
        _sharedClient = [[UserLogin alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    if (self = [super init]) {
        _categoryItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        if ([aDecoder allowsKeyedCoding]) {

            _uid = [[aDecoder decodeObjectForKey:USER_UID] copy];
            _phone = [[aDecoder decodeObjectForKey:USER_PHONE] copy];
            _email = [[aDecoder decodeObjectForKey:USER_EMAIL] copy];
            _qqSkype = [[aDecoder decodeObjectForKey:USER_QQSKPE] copy];
            _name = [[aDecoder decodeObjectForKey:USER_NAME] copy];
            _MemType = [[aDecoder decodeObjectForKey:USER_TYPE] copy];

        }
        else {
            _uid  = [[aDecoder decodeObject] copy];
            _phone = [[aDecoder decodeObject] copy];
            _email = [[aDecoder decodeObject] copy];
            _qqSkype = [[aDecoder decodeObject] copy];
            _name = [[aDecoder decodeObject] copy];
            _MemType = [[aDecoder decodeObject] copy];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if ([aCoder allowsKeyedCoding]) {
        [aCoder encodeObject:self.uid forKey:USER_UID];
        [aCoder encodeObject:self.phone forKey:USER_PHONE];
        [aCoder encodeObject:self.email forKey:USER_EMAIL];
        [aCoder encodeObject:self.qqSkype forKey:USER_QQSKPE];
        [aCoder encodeObject:self.name forKey:USER_NAME];
        [aCoder encodeObject:self.MemType forKey:USER_TYPE];
    }
    else {
        [aCoder encodeObject:self.uid];
        [aCoder encodeObject:self.phone];
        [aCoder encodeObject:self.email];
        [aCoder encodeObject:self.qqSkype];
        [aCoder encodeObject:self.name];
        [aCoder encodeObject:self.MemType];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    UserLogin *dto =  [[[self class] allocWithZone:zone] init];
    
    dto.uid = self.uid;
    dto.phone  = self.phone;
    dto.email = self.email;
    dto.qqSkype = self.qqSkype;
    dto.name = self.name;
    dto.MemType = self.MemType;
    
    return dto;
}

- (void)saveUserInfo
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    if (data) {
        [data writeToFile:UserPath() atomically:YES];
    }
}

- (void)queryUserInfo
{
    NSData *data = [NSData dataWithContentsOfFile:UserPath()];
    
    if (data) {
        UserLogin *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (user && [user isKindOfClass:[UserLogin class]]) {
            self.uid = user.uid;
            self.phone = user.phone;
            self.email = user.email;
            self.qqSkype = user.qqSkype;
            self.name = user.name;
            self.MemType = user.MemType;
        }
    }
}

- (void)clearUserInfo
{
    self.uid = nil;
    self.phone = nil;
    self.email = nil;
    self.qqSkype = nil;
    self.name = nil;
    self.MemType = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:UserPath()]) {
        //
        [[NSFileManager defaultManager] removeItemAtPath:UserPath() error:nil];
    }
}

- (BOOL)isLogin
{
    if ([NSString isNotEmpty:_uid]) {
        return YES;
    }
    return NO;
}

- (void)loginFrom:(UIViewController *)target succeed:(LoginVoidBlock)Succeed
{
    self.succeedBlock = nil;
    
    if (self.isLogin) {
        Succeed();
    }
    else {
        
        self.succeedBlock = Succeed;
        
        LoginViewController *next = [[LoginViewController alloc] init];
        next.delegate = self;
        [target.navigationController pushViewController:next animated:YES];
        [next release];
    }
}

- (void)LoginSucced:(LoginViewController *)target
{
    [target.navigationController popViewControllerAnimated:NO];

    if (_succeedBlock) {
        self.succeedBlock();
    }
    
    self.succeedBlock = nil;
}

- (void)actionDelay
{

}

@end
