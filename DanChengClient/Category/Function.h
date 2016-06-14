//
//  NSObject_Function.h
//  MoiveTickets
//
//  Created by 高 on 14-8-14.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define NSLog(...)  {}

#define APP ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define kNaviTranslucentNo self.navigationController.navigationBar.translucent = NO

#define CURRVIEW_WIDTH                       self.view.frame.size.width
#define CURRVIEW_HEIGTH                      self.view.frame.size.height

#define CURRFRAM_WIDTH                       self.frame.size.width
#define CURRFRAM_HEIGTH                      self.frame.size.height

//设置default
#define KEY_IN_USERDEFAULT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define KEY_IN_USERDEFAULT_BOOL(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]

#define  SET_OBJ_FOR_KEY_IN_USERDEFAULT(_obj_,_key_) [[NSUserDefaults standardUserDefaults] setObject:_obj_ forKey:_key_]
#define  SET_VALUE_FOR_KEY_IN_USERDEFAULT(_value_,_key_) [[NSUserDefaults standardUserDefaults] setValue:_value_ forKey:_key_]
#define  SET_BOOL_FOR_KEY_IN_USERDEFAULT(_bool_,_key_) [[NSUserDefaults standardUserDefaults] setBool:_bool_ forKey:_key_]

#define  SET_SYNCHRONIZE(_synchronize) [[NSUserDefaults standardUserDefaults] _synchronize]

//判断设备 iphone5+
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//Ios7+
#define IOS7 ([[UIDevice currentDevice].systemVersion integerValue]>=7.0f)

#define KHEAD_ORIGN     (([[UIDevice currentDevice].systemVersion integerValue]>=7.0f)?20:0)

#define BUNDLE_FILEPATH                     [[NSBundle mainBundle] resourcePath]

//释放
#define RELEASE_SAFELY(__POINTER)           {[__POINTER release]; __POINTER = nil;}


#define  GET_IMAGE_WITH_NAME_AND_TYPE(name,type)  \
[UIImage imageWithContentsOfFile:\
[[NSBundle mainBundle]\
pathForResource:name ofType:type]]

#define  GET_IMAGE_WITH_NAME(name)  \
[UIImage imageWithContentsOfFile:\
[[NSBundle mainBundle]\
pathForResource:name ofType:@"png"]]

