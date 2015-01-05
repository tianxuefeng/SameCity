//
//  HttpConstant.h
//  samecity
//
//  Created by zengchao on 14-4-20.
//  Copyright (c) 2014年 com.nanjingbroadcast. All rights reserved.
//

#ifndef samecity_HttpConstant_h
#define samecity_HttpConstant_h

#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

#define PER_PAGE_SIZE      12

//请求标记
#define HOME_DATA_TAG                   1000
#define LOGIN_DATA_TAG                  1001
#define REGISTER_DATA_TAG               1002
#define CATEGORY_DATA_TAG               1003
#define CATEGORY_INSERT_TAG             1004

#define MEMBER_DETIAL_TAG               1010
#define MEMBER_PASSWORD_TAG             1011

#define WALL_LIST_DATA_TAG              1004
#define WALL_INSERT_DATA_TAG            1005
#define WALL_REPLY_DATA_TAG             1006

#define MYFAV_LIST_TAG                  1020
#define MYFAV_INSERT_TAG                1021
#define MYFAV_DELETE_TAG                1022

//字符串合成
#define combineStr(a,b)                 [NSString stringWithFormat:@"%@/%@",a,b]

//#define HOST                            @"xuefengjushi.g6.namepu.com"

//#define HOST                            @"50.62.160.29"

#define HOST                            @"stefancity123.com"

//#define HOST                            @"stefancity.com"

#define ITEM_SERVICE_URL                @"srvs/ItemSrv.asmx"

#define GET_PAGE_LIST_URL               @"getItemListByCategoryIDWithPage"

#define POST_NEWITEM_URL                @"InsertItem"

#define GET_ALL_LIST_URL                @"getItemList"

#define LOGIN_SERVICE_URL               @"srvs/membersrv.asmx"

#define POST_LOGIN_URL                  @"Login"

#define POST_PASSWORD_URL               @"ChangePassword"

#define GET_MYPUB_LIST_URL              @"getMyPublishedItems"

#define POST_REGISTER_URL               @"InsertMember"

#define GET_CATEGORY_LIST_URL           @"getCategoryList"

#define CATE_SERVICE_URL                @"srvs/categorysrv.asmx"

#define MY_FAV_URL                      @"srvs/favoritesrv.asmx"

#define POST_INSERT_CATE_URL            @"InsertCategory"

#define GET_FAV_LIST_URL                @"getFavoriteList"

#define POST_ADD_FAV_URL                @"InsertFavorite"

#define POST_DEL_FAV_URL                @"DeleteFavorite"

#define WALL_SERVICE_URL                @"srvs/wallsrv.asmx"

#define GET_WALL_LIST_URL               @"getWallList"

#define POST_ADD_WALL_URL               @"InsertMessage"

#define POST_REPLY_WALL_URL             @"ReplayMessage"

#define POST_UPLOAD                     @"upload.aspx"

#define GET_MEMBER_DETAIL_URL           @"MemberDetail"

#define GET_USER_PUBLISHED_URL          @"getMyPublishedItems"

#define REGION_SERVICE_URL              @"srvs/regionsrv.asmx"

#define GET_INSERT_REGION_URL           @"InsertRegion"

#define GET_REGION_LIST_URL             @"getRegionList"

#endif
