
//
//  NSObject_Constant.h
//  MoiveTickets
//
//  Created by 高 on 14-8-14.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define FILM_SERVER_ADDRESS @"testmapps.m1905.cn"
#define FILM_SERVER_ADDRESS @"182.150.24.137:8089/app-services/app"

//"@"112.74.64.25/app-services/app"//@"118.123.13.162:51209/app-services/app"

#define FILM_SERVER_REGIETER    @"182.150.24.137:8089"//@"www.datawormhole.com"

//域名  （在后面获取请求地址时，需要用，勿删）
//#define SERVER_ADDRESS            @"http://testmapps.m1905.cn"
#define SERVER_ADDRESS              @"http://mapps.m1905.cn"

#define SERVER_ABOUT_ADDRESS        @"http://www.m1905.com"

//初始化相关
#define PID                         @"178"
#define KEY                         @"menusifu_2015"
#define NETWORK                     1
#define LANGUAGE                    @"chinese/ch"
//开启审核模式
#define DEFAULT_ISVERIFY            @"isVerify"
//version相关参数
#define VERSIONID                   300
#define VERSIONCODE                 1
#define VERSIONMINI                 @"20141104001"
#define DEFAULT_VERSIONMINI         @"VersionMini"


#define GOOGLE_MAP_APIKEY           @"AIzaSyAkvTh1sSRWADp6xSxj5OBq6P8Zlxvhqso"

//字体
#define OpenSansBold               @"OpenSans-Bold"
#define OpenSansBoldItalic         @"OpenSans-BoldItalic"
#define OpenSansExtraBold          @"OpenSans-ExtraBold"
#define OpenSansExtraBoldItalic    @"OpenSans-ExtraBoldItalic"
#define OpenSansItalic             @"OpenSans-Italic"
#define OpenSansLight              @"OpenSans-Light"
#define OpenSansLightItalic        @"OpenSansLight-Italic"
#define OpenSansRegular            @"OpenSans"//OpenSans-Regular
#define OpenSansSemibold           @"OpenSans-Semibold"
#define OpenSansSemiboldItalic     @"OpenSans-SemiboldItalic"




//结果代码
#define NET_RES_SUCCESS 0
//#define NET_RES_SUCCESS 1  //文档中标示1标示成功，但实际为0
#define NET_RES_SERVER_MAINTAINANCE 99      //服务器维护
#define NET_RES_PARAM_WRONG 101     //参数错误
#define NET_RES_ILLEGAL_ASK 102    //非法请求
#define NET_RES_UNAUTH_USER 103     //未授权用户
#define NET_RES_NODATA 404          //无数据
#define NET_RES_SERVER_PROBLEM 500  //服务器错误
#define NET_RES_UNDENIED 600     //自定义错误



#define HEAD_HEIGTH                         43.5f
#define TIME_REQUEST                        15.0f

//几个界面相关的常用高度
#define kNavagationBarH             77

#define Number_One                  @"1"
#define Number_Zero                 @"0"
#define Number_Two                  @"2"

/*key值相关*/

/*保存是否提示升级的key*/
#define UPDATE_NOTICE               @"notice"


#define DESKEY                      @"WWDRQDQ7ES0E224E67W901YR"

#define MONEY_SIGN                  @"￥%@"
#define ONE_FLOAT                   @"%0.1f"
#define ONE_FLOAT_SCORE             @"%0.1f分"
#define ONE_FLOAT_PRICE             @"%0.2f元起"
#define TWO_STRING_LINK             @"%@%@"
#define TWO_FLOAT_KM                @"%.2f km"
#define ALL_COMMENT                 @"全部评论(%d)"
#define FLOAT_LINK                  @"%f"
#define FLOAT_0_LINK                @"%0.f"
#define INT_INT_LINK                @"%d/%d"
#define INT_LINK                    @"%d"
#define LINT_LINT_LINK              @"%ld/%ld"

//加解密用到的key
#define SERVER_DES_KEY              @"iufles8787rewjk1qkq9dj76"

//#define NSLog(...)  {}

//解析数据时用到的 字典的key
#define SERVER_RES                  @"res"
#define SERVER_RESULT               @"result"
#define SERVER_MESSAGE              @"message"
#define SERVER_DATA                 @"data"

#define STRING_NULL                 @""
#define STRING_SPACE                @" "
#define STRING_DOT                  @","

#define KNULL                       @"错误"

#define kUSER_LOGININFO          @"kUSER_LOGININFO" // 储存用户的登录信息

