//
//  PublishViewController.m
//  SameCity
//
//  Created by zengchao on 14-6-14.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#import "PublishViewController.h"
#import "UserLogin.h"
#import "CategoryItem.h"
#import "BlockUI.h"
#import "UploadFile.h"
#import "HttpManager.h"
#import "PublishCateViewController.h"
#import "Global.h"
#import "FXZLocationManager.h"

@interface PublishViewController ()<PublishCateViewControllerDelegate>

@end

@implementation PublishViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_uploadImageArr);
    RELEASE_SAFELY(bgScrollView);
//    RELEASE_SAFELY(catePickView);
    RELEASE_SAFELY(titleText);
    RELEASE_SAFELY(descText);
    RELEASE_SAFELY(phoneText);
    RELEASE_SAFELY(addressText);
    RELEASE_SAFELY(priceText);
    RELEASE_SAFELY(cateBtn);
    RELEASE_SAFELY(homepageData);
    RELEASE_SAFELY(isBuySeg);
    RELEASE_SAFELY(imgScrollView);
    
    [super dealloc];
}

- (void)setupNavi
{
    [super setupNavi];
    
    self.title = NSLocalizedString(main_nav_publish, nil);
    
    UIBarButtonItem *right = [UIBarButtonItem createBarButtonItemWithTitle:NSLocalizedString(btn_submit, nil) target:self action:@selector(postAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
//    DLog(@"%d",self.navigationController.viewControllers.count);
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *left = [UIBarButtonItem createBackBarButtonItemTarget:self action:@selector(back:)];
        self.navigationItem.leftBarButtonItem = left;
    }
}

- (void)resetData
{
    [imgScrollView deleteAll];
    
    self.selectCate = nil;
    [self.uploadImageArr removeAllObjects];
    
    [cateBtn setTitle:NSLocalizedString(lab_select_category, nil) forState:UIControlStateNormal];
    isBuySeg.selectedSegmentIndex = 0;
    titleText.text = nil;
    phoneText.text = nil;
    addressText.text = nil;
    priceText.text = nil;
    addressText.text = nil;
    descText.text = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _uploadImageArr = [[NSMutableArray alloc] init];
    
    isBuySeg.selectedFontColor = [UIColor whiteColor];
    isBuySeg.deselectedFontColor = COLOR_THEME;
    
    isBuySeg.selectedColor = COLOR_THEME;
    isBuySeg.deselectedColor = [UIColor whiteColor];
    
    isBuySeg.disabledColor = [UIColor grayColor];
    isBuySeg.borderWidth = 1;
    isBuySeg.borderColor = COLOR_THEME;
    isBuySeg.dividerColor = COLOR_THEME;
    
    isBuySeg.cornerRadius = 5.0;
    
    titleText.background = [ImageWithName(@"input_bg_1") adjustSize];
    phoneText.background = [ImageWithName(@"input_bg_1") adjustSize];
    addressText.background = [ImageWithName(@"input_bg_1") adjustSize];
    priceText.background = [ImageWithName(@"input_bg_1") adjustSize];

    [cateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cateBtn setBackgroundImage:ImageWithName(@"btn_big_normal") forState:UIControlStateNormal];
    [cateBtn setBackgroundImage:ImageWithName(@"btn_big_press") forState:UIControlStateHighlighted];
    [cateBtn setTitle:NSLocalizedString(lab_select_category, nil) forState:UIControlStateNormal];
    
    descText.placeholder = NSLocalizedString(hint_desc, nil);
//    bgScrollView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-49);
    bgScrollView.scrollEnabled = YES;
    
    imageBtn.tag = 100;
    imageBtn.clipsToBounds = YES;
    [imageBtn setBackgroundImage:ImageWithName(@"input_add_icon") forState:UIControlStateNormal];
//    [imageBtn setBackgroundImage:ImageWithName(@"input_add_press") forState:UIControlStateHighlighted];
    [imageBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    catePickView = [[CustomPickView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44-49)];
//    catePickView.datasourse = self;
//    catePickView.delegate = self;
//    [self.view addSubview:catePickView];
    
    cateBtn.tag = 101;
    [cateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    imgScrollView = [[PublishMediaView alloc] initWithFrame:CGRectMake(20, 10, kMainScreenWidth-30, HIGHT)];
    imgScrollView.maxNum = 5;
    imgScrollView.delegate = self;
    imgScrollView.layer.masksToBounds = YES;
//    imgScrollView.layer.borderWidth  = 0.5;
//    imgScrollView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgScrollView.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:imgScrollView];
    
    NSString *city = [Global ShareCenter].city;
    NSString *region = [Global ShareCenter].region;
    NSString *street = [FXZLocationManager sharedManager].street;
    
    addressText.text = street;
    
    [self localisedUI];
    
    homepageData = [[HomePageData alloc] initWithCity:city andRegion:region];
    homepageData.delegate = self;
    
    if ([UserLogin instanse].categoryItems.count == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CateReloadNotificationKey object:nil];
    }
    
    if (self.selectCate && [NSString isNotEmpty:self.selectCate.Title]) {
        [cateBtn setTitle:self.selectCate.Title forState:UIControlStateNormal];
    }
}

- (void)localisedUI
{
    titleText.placeholder =  NSLocalizedString(@"lab_send_title", @"");
    descText.placeholder = NSLocalizedString(lab_send_desc, @"");
    phoneText.placeholder = NSLocalizedString(lab_send_phone, @"");
    addressText.placeholder = NSLocalizedString(lab_send_address, @"");
    priceText.placeholder = NSLocalizedString(lab_send_price, @"");
//
    [isBuySeg setTitle:NSLocalizedString(lab_send_buyers, @"") forSegmentAtIndex:0];
    [isBuySeg setTitle:NSLocalizedString(lab_send_seller, @"") forSegmentAtIndex:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __unsafe_unretained PublishViewController *weakSelf = self;
    
    [[FXZLocationManager sharedManager] refreshUpdatingLocationWithBlock:^(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation) {
        //
        NSString *street = [FXZLocationManager sharedManager].street;
        weakSelf->addressText.text = street;
        
    } errorBlock:^(CLLocationManager *manager, NSError *error) {
        //
    }];
    
    if (self.navigationController.viewControllers.count <= 1) {
        [ApplicationDelegate.tabBarCtl hidesTabBar:NO animated:YES];
    }

    
    if ([NSString isNotEmpty:[UserLogin instanse].phone]) {
        phoneText.text = [UserLogin instanse].phone;
    }
}

- (void)buttonClick:(UIButton *)sender
{
    [[bgScrollView findFirstResponderBeneathView:bgScrollView] resignFirstResponder];
    
    if (sender.tag == 100) {
        //
        UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:NSLocalizedString(btnNO, nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(btn_select_file, nil),NSLocalizedString(btn_camera, nil), nil];
        ac.tag = 1000;
        [ac showInView:ApplicationDelegate.tabBarCtl.view withCompletionHandler:^(NSInteger buttonIndex) {
            //
            
            if (buttonIndex == 0) {
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    NSLog(@"sorry, no camera or camera is unavailable.");
                    return;
                }
                
                if (self.navigationController.viewControllers == 0) {
                    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
                }
                
                //创建图像选取控制器
                UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
                //        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeLow;
                //设置图像选取控制器的来源模式为相机模式
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //设置图像选取控制器的类型为静态图像
                imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
                //允许用户进行编辑
                imagePickerController.allowsEditing = NO;
                //设置委托对象
                imagePickerController.delegate = self;
                //以模视图控制器的形式显示
                [self presentViewController:imagePickerController animated:YES completion:NULL];
                [imagePickerController release];
            }
            else if (buttonIndex == 1) {
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    NSLog(@"sorry, no camera or camera is unavailable.");
                    return;
                }
                
                if (self.navigationController.viewControllers == 0) {
                    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
                }
                
                //创建图像选取控制器
                UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
                //        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeLow;
                //设置图像选取控制器的来源模式为相机模式
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                //设置图像选取控制器的类型为静态图像
                imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
                //允许用户进行编辑
                imagePickerController.allowsEditing = NO;
                //设置委托对象
                imagePickerController.delegate = self;
                //以模视图控制器的形式显示
                [self presentViewController:imagePickerController animated:YES completion:NULL];
                [imagePickerController release];
            }
        }];
        [ac release];
    }
    else if (sender.tag == 101) {

        PublishCateViewController *next = [[PublishCateViewController alloc] init];
        next.level = 0;
        next.delegate = self;
        [self.navigationController pushViewController:next animated:YES];
        [next release];
    }
}

#pragma mark -- pickviewDataSourse
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [UserLogin instanse].categoryItems.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    CategoryItem *item = [UserLogin instanse].categoryItems[row];
    return item.Title;
}

#pragma mark -- CameraDelagate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.navigationController.viewControllers.count <= 1) {
        [ApplicationDelegate.tabBarCtl hidesTabBar:NO animated:YES];
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.navigationController.viewControllers.count <= 1) {
        [ApplicationDelegate.tabBarCtl hidesTabBar:NO animated:YES];
    }

    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (!image) {
            return;
        }

        UIImage *thumb = [image scaleToSize:CGSizeMake(320, image.size.height*320/image.size.width)];
        [imgScrollView addImage:thumb];
        
        UploadFile *imgFile_tmp = [[UploadFile alloc] init];
        imgFile_tmp.image = thumb;
        [self.uploadImageArr addObject:imgFile_tmp];
        RELEASE_SAFELY(imgFile_tmp);
    }
}

- (void)postAction:(id)sender
{
    [[bgScrollView findFirstResponderBeneathView:bgScrollView] resignFirstResponder];
    
    if (![NSString isNotEmpty:titleText.text]) {
        AlertMessage(NSLocalizedString(hint_title, nil));
        return;
    }
    
    if (!_selectCate) {
        AlertMessage(NSLocalizedString(hint_sel_category, nil));
        return;
    }
    
    if (![NSString isNotEmpty:priceText.text]) {
        AlertMessage(NSLocalizedString(msg_send_not_price, nil));
        return;
    }
    
    if (![NSString isNotEmpty:phoneText.text]) {
        AlertMessage(NSLocalizedString(msg_send_not_phone, nil));
        return;
    }
    
    if (![NSString isNotEmpty:addressText.text]) {
        AlertMessage(NSLocalizedString(msg_send_not_address, nil));
        return;
    }
    
    [[UserLogin instanse] loginFrom:self succeed:^{
        //
        [self postImages];
    }];
}

- (void)postImages
{
    if (!self.uploadImageArr || self.uploadImageArr.count==0) {
        [self postNew];
        return;
    }
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"正在上传图片";
    [self startLoadingWithTitle:NSLocalizedString(msg_uploading_file, nil)];
//    [self startLoading];
    
    dispatch_group_t group = dispatch_group_create();
    
    for (int i=0; i<self.uploadImageArr.count; i++) {
        
//        __block PublishViewController *bself = self;
        
        UploadFile *file = self.uploadImageArr[i];
        //        __block UploadFile *bfile = file;
        
        if (!file.image) {
            continue;
        }
        
        if ([NSString isNotEmpty:file.fileId]) {
            continue;
        }
        
        dispatch_group_enter(group);
        
        __unsafe_unretained UploadFile *weakFile = file;
        
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        
        NSString *imageName = [NSString stringWithFormat:@"%d%d.png",(int)time,i];
        
//        DLog(@"imageName : %@" ,imageName);
        
        AFHTTPRequestOperationManager *netManager = [HttpManager instanse].netManager;

        [netManager POST:POST_UPLOAD parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //
            
            if (weakFile.image) {
                
                DLog(@"formData - imageName : %@" ,imageName);
                
                NSData *imageData = UIImageJPEGRepresentation(weakFile.image, 0.6);
                
                [formData appendPartWithFileData:imageData name:@"userfile" fileName:imageName mimeType:@"image/jepg"];
            }
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            
               DLog(@"success - imageName : %@" ,imageName);
            
//            if ([operation.responseString containsString:@"Success"]) {
                //
                weakFile.fileId = imageName;
//            }
            
            dispatch_group_leave(group);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [self postNew];
    });
    
    dispatch_release(group);
}

//- (void)customPickView:(CustomPickView *)pick didSelect:(int)index
//{
//    if (index < [UserLogin instanse].categoryItems.count) {
//        self.selectCate = [UserLogin instanse].categoryItems[index];
//        if ([NSString isNotEmpty:self.selectCate.Title]) {
//            [cateBtn setTitle:self.selectCate.Title forState:UIControlStateNormal];
//        }
//    }
//}

- (void)postNew
{
    NSString *imageString = nil;
    
    if (self.uploadImageArr.count > 0) {
        
        for (int i=0; i<self.uploadImageArr.count; i++) {
            
            UploadFile *uFile = self.uploadImageArr[i];
            
            if (i==0) {
                imageString = uFile.fileId;
            }
            else {
                imageString = [imageString stringByAppendingFormat:@"|%@",uFile.fileId];
            }
        }
    }
    
    if (!homepageData.isLoading) {
        
        [self startLoadingWithTitle:@"正在提交"];
        
        NSString *city = [Global ShareCenter].city;
        NSString *region = [Global ShareCenter].region;
        homepageData.city = city;
        homepageData.region = region;
        
        [homepageData insertNewItemTitle:titleText.text desc:descText.text price:priceText.text images:imageString phone:phoneText.text address:addressText.text cateID:self.selectCate.ID type:isBuySeg.selectedSegmentIndex];
    }
}

- (void)httpService:(HttpService *)target Succeed:(NSObject *)response
{
    [self stopLoading];
    
    if ([NSString isNotEmpty:(NSString *)response]) {
        if ([(NSString *)response containsString:@"true"]) {
            AlertMessage(NSLocalizedString(msg_send_success, nil));
            [Global ShareCenter].mustRefresh = YES;
            [self resetData];
            
            if (_selectCate) {
                [Global ShareCenter].publishedID = self.selectCate.ID;
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(publishedSuccceed:)]) {
                [self.delegate publishedSuccceed:self];
            }
            
            if (self.fromPush) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            return;
        }
    }
     AlertMessage(NSLocalizedString(msg_send_error, nil));
}

- (void)httpService:(HttpService *)target Failed:(NSError *)error
{
    [self stopLoadingWithError:nil];
}

- (void)publishCateViewControllerCitySelect:(CategoryItem *)selectedCateItem
{
    self.selectCate = selectedCateItem;
    if (self.selectCate && [NSString isNotEmpty:self.selectCate.Title]) {
        [cateBtn setTitle:self.selectCate.Title forState:UIControlStateNormal];
    }
}

- (void)pickPhotoAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //                NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    
    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
    
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:NULL];
    [imagePickerController release];
}

- (void)pickCameraPhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //                NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    
    [ApplicationDelegate.tabBarCtl hidesTabBar:YES animated:YES];
    
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:NULL];
    [imagePickerController release];
}

#pragma mark -- PublishMediaViewDeleagte
- (void)publishMediaViewAddBtnClick:(PublishMediaView *)target
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:NSLocalizedString(btnNO, nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(btn_select_file, nil),NSLocalizedString(btn_camera, nil), nil];
    [sheet showInView:ApplicationDelegate.tabBarCtl.view withCompletionHandler:^(NSInteger buttonIndex) {
        //
        if (buttonIndex == 0) {
            
            [self pickPhotoAlbum];
        }
        else if (buttonIndex == 1) {
            [self pickCameraPhoto];
        }
    }];
}

- (void)publishMediaViewImageBtnClick:(PublishMediaView *)target index:(int)index
{
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:NSLocalizedString(btnNO, nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(title_delete, nil), nil];
    [ac showInView:ApplicationDelegate.tabBarCtl.view withCompletionHandler:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {
            [imgScrollView deleteImage:index];
        }
    }];
    [ac release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
