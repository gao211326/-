//
//  NSObject+SystemInfo.m
//  socialDemo
//
//  Created by 陈欢 on 13-12-30.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import "NSObject+SystemInfo.h"
#import <objc/runtime.h>
#import "NSString+Extension.h"
#import <CoreLocation/CoreLocation.h>
#import "NSString+ThreeDES.h"

@implementation NSObject (SystemInfo)

- (NSMutableArray *)attributeList {
    static NSMutableDictionary *classDictionary = nil;
    if (classDictionary == nil) {
        classDictionary = [[NSMutableDictionary alloc] init];
    }
    
    NSString *className = NSStringFromClass(self.class);
    
    NSMutableArray *propertyList = [classDictionary objectForKey:className];
    
    if (propertyList != nil) {
        return propertyList;
    }
    
    propertyList = [[NSMutableArray alloc] init];
    
    id theClass = object_getClass(self);
    [self getPropertyList:theClass forList:&propertyList];
    
    [classDictionary setObject:propertyList forKey:className];
#if !__has_feature(objc_arc)
    [propertyList release];
#endif
    return propertyList;
}

- (void)getPropertyList:(id)theClass forList:(NSMutableArray **)propertyList {
    id superClass = class_getSuperclass(theClass);
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList(theClass, &count);
    for (i=0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        if (propertyName != nil) {
            [*propertyList addObject:propertyName];
#if !__has_feature(objc_arc)
            [propertyName release];
#endif
            propertyName = nil;
        }
    }
    free(properties);
    
    if (superClass != [NSObject class]) {
        [self getPropertyList:superClass forList:propertyList];
    }
}

/*设备相关*/
- (float)deviceSystemVersion {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

- (NSString *)deviceModel {
    NSString *model = [[UIDevice currentDevice] model];
    model = [model stringByReplacingOccurrencesOfString: @" " withString:@"_"];
    return model;
}

- (NSString *)deviceName {
    NSString *name = [[UIDevice currentDevice] name];
    return name;
}

- (BOOL)deviceIsPad {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (BOOL)deviceIsPhone {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}

- (BOOL)deviceIsTouch {
    return [[self deviceModel] rangeOfString:@"iPod touch"].length > 0;
}

- (BOOL)deviceIsRetina {
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)deviceIsPhone5 {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size):NO);
}

- (BOOL)deviceIsPhone4
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size):NO);
}

- (BOOL)deviceIsPhone6
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size):NO);
}

- (BOOL)deviceIsPhone6plus
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size):NO);
}

/*md5 加密*/
- (NSString *)md5 {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data md5];
}

// 加密
- (NSString *)make3DEString:(NSString *)str
{
    str = [NSString TripleDES:str encryptOrDecrypt:kCCEncrypt key:SERVER_DES_KEY ];
    str = [self urlEncode:str];
    return str;
}

- (NSString *)appleLanguages {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
}

- (void)setNsuserDefault:(id)object forKey:(NSString*)key
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:object forKey:key];
    [user synchronize];
}


- (void)observeNotificaiton:(NSString *)name {
    [self observeNotificaiton:name selector:@selector(handleNotification:)];
}

- (void)observeNotificaiton:(NSString *)name selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:nil];
}

- (void)unobserveNotification:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

- (void)unobserveAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)postNotification:(NSString *)name {
    [self postNotification:name object:nil];
}

- (void)postNotification:(NSString *)name object:(id)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}

- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [self postNotification:name object:nil userInfo:userInfo];
}

- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:object
                                                      userInfo:userInfo];
}

- (void)postNotification:(NSString *)name withObject:(id)object {
    if (object == nil) {
        object = STRING_NULL;
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:object forKey:kNotificationObject];
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:nil
                                                      userInfo:userInfo];
}

- (void)handleNotification:(NSNotification *)noti {
    if ([self respondsToSelector:@selector(handleNotification:object:userInfo:)]) {
        [self handleNotification:noti.name object:noti.object userInfo:noti.userInfo];
    }
}

- (void)handleNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    
}

//字符串判断
- (BOOL)isString {
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}



//数组判断
- (BOOL)isArray {
    if ([self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isNotEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return YES;
    }
    return NO;
}

//字典判断
- (BOOL)isDictionary {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

//- (BOOL)isEmptyDictionary
//{
//    if ([self isDictionary] && self!=nil) {
//        NSDictionary *tempDict = (NSDictionary *)self;
//        if ([tempDict allKeys].count <= 0) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (BOOL)isNotEmptyDictionary {
    if ([self isDictionary] && self!=nil ) {
        NSDictionary *tempDict = (NSDictionary *)self;
        if ([tempDict allKeys].count > 0) {
            return YES;
        }
    }
    return NO;
}

- (CGFloat)getFontHeight:(UIFont *)font
{
    NSString *tmpString = @"0";
    return [tmpString getDrawHeightWithFont:font Width:CGFLOAT_MAX];
}

- (BOOL)openURL:(NSURL *)url {
    return [[UIApplication sharedApplication] openURL:url];
}

- (void)sendMail:(NSString *)mail {
    NSString *url = [NSString stringWithFormat:@"mailto://%@", mail];
    [self openURL:[NSURL URLWithString:url]];
}

- (void)sendSMS:(NSString *)number {
    NSString *url = [NSString stringWithFormat:@"sms://%@", number];
    [self openURL:[NSURL URLWithString:url]];
}

- (void)callNumber:(NSString *)number {
    NSString *url = [NSString stringWithFormat:@"tel://%@", number];
    [self openURL:[NSURL URLWithString:url]];
}


- (NSURL*)getThequestUrl:(NSString*)middleurl param:(NSString*)str
{
    NSString*requestUrl = nil;
    if (nil!=str)
    {
        requestUrl = [NSString stringWithFormat:@"%@/%@?%@",SERVER_ADDRESS,middleurl,str];
    }
    else
    {
        requestUrl = [NSString stringWithFormat:@"%@/%@",SERVER_ADDRESS,middleurl];
    }
    NSURL *Url = [NSURL URLWithString:requestUrl];
    return Url;
}

- (float)getCacheTime:(NSURL*)keyUrl
{
    NSDate *date = KEY_IN_USERDEFAULT([keyUrl absoluteString]);
    NSTimeInterval cacheTime = [date timeIntervalSince1970];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowTime = [nowDate timeIntervalSince1970];
    float moretime = nowTime - cacheTime;
    return moretime;
}

- (float)getCinemaDistance:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2
{
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:lat1  longitude:lon1];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:lat2 longitude:lon2 ];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
    return kilometers;
}

- (NSString *)ConvertToNSString:(NSData *)data {
    
	NSMutableString *strTemp = [NSMutableString stringWithCapacity:[data length]*2];
	const unsigned char *szBuffer = [data bytes];
    
	for (NSInteger i=0; i < [data length]; ++i) {
        
		[strTemp appendFormat:@"%02lx",(unsigned long)szBuffer[i]];
        
	}
    
	return strTemp ;
    
}

- (void)openUrl:(NSString *)string{
    NSURL *url=[NSURL URLWithString:string];
    [[UIApplication sharedApplication]openURL:url];
}

- (NSString *)converString:(NSObject *)obj{
    NSString *str=(NSString *)obj;
    
    if([[obj class] isSubclassOfClass:[NSNumber class]]){
        str=[obj description];
    }
    else if([[obj class] isSubclassOfClass:[NSNull  class]]
            || (obj==nil)
            || ([[obj class] isSubclassOfClass:[NSString class]] && ([(NSString *)obj isEqualToString:@"(null)"]  || [(NSString*)obj isEqualToString:@""]))
            ){
        str= KNULL;
    }
    return str.description;
}

- (NSString *)replaceNullData:(NSString *)nullData withRepalceData:(NSString*)replaceData
{
    if ([[self converString:nullData]isEqualToString:KNULL]) {
        return replaceData;
    }else{
        return nullData;
    }
    return STRING_NULL;
}

- (NSString *)filePath:(NSString *)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *Path=[documentDirectory stringByAppendingPathComponent:file];
    return Path;
}


- (UIImage *)imagePath:(NSString*)directory file:(NSString *)hash{
    NSString *imagePath=[self getFilePath:directory file:hash];
    NSFileManager *fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:imagePath]){
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        return image;
    }
    return nil;
    
}

- (NSString *)getFilePath:(NSString*)directory file:(NSString *)hash{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *imagePath=[documentDirectory stringByAppendingPathComponent:directory];
    imagePath=[imagePath stringByAppendingPathComponent:hash];
    return imagePath;
}


-(NSString*)urlEncode:(NSString*)url{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR("!*'();:@&=+$,/?%#[] "),
                                                              kCFStringEncodingUTF8));
    return result;
}

- (BOOL)validatePhoneNum:(NSString *)num{
    NSString *phoneRegex = @"^[1][3-8]+\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:num];
}

- (int)getTextFieldLenth:(NSString*)username
{
    int length = 0;
    for (int i = 0; i<[username length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [username substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChine:s]) {
            length+=2;
        }else{
            length+=1;
        }
    }
    return length;
}

- (BOOL)validateChine:(NSString*)username
{
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![username isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

// 原来的
//- (BOOL)checkPassWord:(NSString*)password
//{
//    NSString *lpasswordRegEx = @"[^\u4e00-\u9fa5]+$";
//    
//    if (![password isMatchesRegularExp:lpasswordRegEx])
//    {
//        return NO;
//    }
//    return YES;
//}

- (BOOL)checkPassWord:(NSString *)password
{
    BOOL bl = NO;
    for (int i = 0; i < password.length; i ++)
    {
        NSString *one = [password substringWithRange:NSMakeRange(i, 1)];
        NSString * string = @"[A-Za-z0-9]";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", string];
        if ([predicate evaluateWithObject:one])
        {
            bl = YES;
            return YES ;
        }else{
            bl = NO;
        }
    }
    return bl;
}


- (NSString*)removeFirstIsZero:(NSString*)str
{
    NSString *ret = nil;
    NSString *s = [str substringWithRange:NSMakeRange(0, 1)];
    if ([s isEqualToString:@"0"]) {
        ret = [str substringWithRange:NSMakeRange(1, str.length-1)];
        return ret;
    }else
        return str;
}

- (NSString *)translatePlayTime:(NSString *)playTime{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"-: "];
    NSArray *array = [playTime componentsSeparatedByCharactersInSet:set];
    
    return [NSString stringWithFormat:
                @"%@月%@日",
                [self removeFirstIsZero:[array objectAtIndex:1]],
                [self removeFirstIsZero:[array objectAtIndex:2]]];
}

// 获取登录用户的村粗信息
-(id)fetchLoginUserInfo
{
    NSData *data = KEY_IN_USERDEFAULT(kUSER_LOGININFO);
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

// 保存用户信息
- (void)saveUserInfoWith:(id)data
{
    //自定义的 需要序列号
    NSData *dataInfo = [NSKeyedArchiver archivedDataWithRootObject:data];
    [self setNsuserDefault:dataInfo forKey:kUSER_LOGININFO];
}

/*米转为千米*/
- (double)meterToKilometer:(NSInteger)metter{
    double kMeter = 0;
    if (metter>1000) {
        kMeter = metter/1000.0;
    }
    return kMeter;
}

- (NSString *)dataConfigPathWith:(NSString *)pathName
{
    
    NSString * _dataConfigPath = [[NSBundle mainBundle] pathForResource:pathName ofType:@"plist"];
    return _dataConfigPath;
}

- (NSArray *)dataArrayWith:(NSString *)path
{
    NSArray  * _dataArray = [[NSArray alloc] initWithContentsOfFile:path];
    return _dataArray;
}

@end
