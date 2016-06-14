//
//  NSObject+SystemInfo.h
//  socialDemo
//
//  Created by 陈欢 on 13-12-30.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNotificationObject @"kNotificationObject"

@interface NSObject (SystemInfo)

- (NSMutableArray *)attributeList;

/*设备相关*/
/*当前设备的系统版本号*/
- (float)deviceSystemVersion;

/*当前设备模型*/
- (NSString *)deviceModel;

/*当前设备名称*/
- (NSString *)deviceName;

/*当前设备是否为iPad*/
- (BOOL)deviceIsPad;

/*当前设备是否为iPhone*/
- (BOOL)deviceIsPhone;

/*当前设备是否为iPod touch*/
- (BOOL)deviceIsTouch;

/*当前设备是否为视网膜屏*/
- (BOOL)deviceIsRetina;

/*判断是否为iPhone5*/
- (BOOL)deviceIsPhone5;

- (BOOL)deviceIsPhone4;

- (BOOL)deviceIsPhone6;

- (BOOL)deviceIsPhone6plus;

/*md5 加密*/
- (NSString *)md5;

//生成经过3des加密的url
- (NSString *)make3DEString:(NSString *)str;

/*当前系统语言*/
- (NSString *)appleLanguages;

/*判断是否为字符串*/
- (BOOL)isString;

/*判断是否为NSArray*/
- (BOOL)isArray;

/*判断是否为不为空的NSArray*/
- (BOOL)isEmptyArray;

- (BOOL)isNotEmptyArray;

- (BOOL)isDictionary;

//- (BOOL)isEmptyDictionary;

/*判断是否为不为空的NSDictionary*/
- (BOOL)isNotEmptyDictionary;

/*设置Nsuserdefault信息*/
- (void)setNsuserDefault:(id)object forKey:(NSString*)key;

// 获取登录用户的存储信息 返回一个UserInfoData 类型
- (id)fetchLoginUserInfo;

// 保存用户信息
- (void)saveUserInfoWith:(id)data;


/*注册成为指定消息的观察者*/
- (void)observeNotificaiton:(NSString *)name;

- (void)observeNotificaiton:(NSString *)name selector:(SEL)selector;

- (void)unobserveNotification:(NSString *)name;

- (void)unobserveAllNotification;

- (void)postNotification:(NSString *)name;

- (void)postNotification:(NSString *)name object:(id)object;

- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo;

- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

- (void)postNotification:(NSString *)name withObject:(id)object;


//返回字体高度
- (CGFloat)getFontHeight:(UIFont *)font;


- (BOOL)openURL:(NSURL *)url;

- (void)sendMail:(NSString *)mail;

- (void)sendSMS:(NSString *)number;

- (void)callNumber:(NSString *)number;

- (NSURL*)getThequestUrl:(NSString*)middleurl param:(NSString*)str;

/*判断缓存时间*/
- (float)getCacheTime:(NSURL*)keyUrl;

/*计算经纬度间的距离*/
- (float)getCinemaDistance:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;

- (NSString *)ConvertToNSString:(NSData *)data;

- (int)getTextFieldLenth:(NSString*)username;

- (NSString *)converString:(NSObject *)obj;

/*对空值进行相对于的替换 */
- (NSString *)replaceNullData:(NSString *)nullData withRepalceData:(NSString*)replaceData;

- (NSString *)filePath:(NSString *)file;

/*获取缓存图片的路径*/
- (UIImage *)imagePath:(NSString*)directory file:(NSString *)hash;

- (NSString *)getFilePath:(NSString*)directory file:(NSString *)hash;

- (NSString*)urlEncode:(NSString*)url;


- (BOOL)validatePhoneNum:(NSString *)num;

- (BOOL)checkPassWord:(NSString*)password;
/**获取时间的转换*/
- (NSString *)translatePlayTime:(NSString *)playTime;

// 判断该文字是否为中文
- (BOOL)validateChine:(NSString*)username;

- (double)meterToKilometer:(NSInteger)metter;

//获取本地文件信息
- (NSString *)dataConfigPathWith:(NSString *)pathName;

- (NSArray *)dataArrayWith:(NSString *)path;
@end
