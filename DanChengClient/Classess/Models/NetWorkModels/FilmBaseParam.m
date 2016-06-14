//
//  FilmBaseParam.m
//  YingPiao2.2
//
//  Created by 高 on 14-7-16.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import "FilmBaseParam.h"
#import "UserTransaction.h"
#import "OpenUDID.h"

#define kHttpPost @"POST"
#define kHttpGet @"GET"

@implementation FilmBaseParam


- (id)initWithCommand:(NSString*)command{
    if (self =[super init]) {
        _method = kHttpGet;
        
        self.command  = command;
        self.T = [[UserTransaction sharedInstance]token];
//        self.did = [FilmBaseParam did_header];
//        self.key = [FilmBaseParam key_header];
//        self.pid = [FilmBaseParam pid_header];
//        self.ver = [FilmBaseParam ver_header];
        self.ua = @"iphone";
    }
    return self;
}

- (BOOL)isGet {
    if ([_method isEqualToString:kHttpGet]) {
        return YES;
    }
    return NO;
}

- (BOOL)isPost {
    if ([_method isEqualToString:kHttpPost]) {
        return YES;
    }
    return NO;
}

- (void)addCommand:(NSString*)command
{
    command = command;
}

- (void)addParam:(NSString *)key withValue:(id)value {
    if (_bodyParam == nil) {
        _bodyParam = [[NSMutableDictionary alloc] init];
    }
    
    if (value == nil) {
        value = STRING_NULL;
    }
    
    if (value != nil && key != nil) {
        [_bodyParam setObject:value forKey:key];
    }
}

#pragma mark ==============================
#pragma mark 【Get 和 Post】
#pragma mark ==============================

- (NSString *)paramOfGet {
    NSDictionary *param = [self paramOfPost];
    
    NSString *paramString = STRING_NULL;
    if (param.count > 0) {
        paramString = @"?";
        NSUInteger length = [[param allKeys] count];
        
        NSString    *key;
        id          value;
        NSString    *separate = @"&";
        
        for (int i=0; i<length; i++) {
            key = [[param allKeys] objectAtIndex:i];
            
            if ([key isEqualToString:@"urlString"]
                || [key isEqualToString:@"method"]
                || [key isEqualToString:@"timeout"]
                || [key isEqualToString:@"requestType"]
                || [key isEqualToString:@"command"]) {
                continue;
            }
            
            value = [param valueForKey:key];
            if (i == length-1) {
                separate = STRING_NULL;
            }
            paramString = [NSString stringWithFormat:@"%@%@=%@%@", paramString, key, value, separate];
        }
    }
    
    return paramString;
}

- (NSDictionary *)paramOfPost {
    if (_postParam == nil) {
        _postParam = [[NSMutableDictionary alloc] init];
    }
    
    [_postParam removeAllObjects];
    
    if (_bodyParam != nil) {
        for (NSString *key in [_bodyParam allKeys]) {
            id value = [_bodyParam objectForKey:key];
            if (value == nil) {
                value = STRING_NULL;
            }
            [_postParam setObject:value forKey:key];
        }
    }
    
    return _postParam;
}

- (NSDictionary *)paramOfHeader {
    
    NSMutableDictionary *paramOfHeader = [[NSMutableDictionary alloc] init];
    
    NSString *propertyName = nil;
    NSString *propertyValue = nil;
    
    NSArray *propertyList = [self attributeList];
    NSUInteger count = propertyList.count;
    
    for (int i=0; i<count; i++) {
        propertyName = [propertyList objectAtIndex:i];
        
        if ([propertyName isEqualToString:@"urlString"]
            || [propertyName isEqualToString:@"method"]
            || [propertyName isEqualToString:@"timeout"]
            || [propertyName isEqualToString:@"requestType"]
            || [propertyName isEqualToString:@"command"]) {
            continue;
        }
        
        propertyValue =[self valueForKey:propertyName];
        
        if (propertyValue == nil) {
            propertyValue = STRING_NULL;
            //            continue;
        }
        [paramOfHeader setObject:propertyValue forKey:propertyName];
    }
    
    return paramOfHeader;
}


#pragma mark ==============================
#pragma mark 【通用请求heder】
#pragma mark ==============================


+ (NSString *)key_header{
    NSString *key = [NSString stringWithFormat:TWO_STRING_LINK,[FilmBaseParam did_header],KEY];
    return [key md5String];
}

+ (NSString *)did_header{
    return [OpenUDID value];
}

+ (NSString *)ver_header{
    return [NSString stringWithFormat:@"%d/%d/%@",VERSIONID,VERSIONCODE,VERSIONMINI];
}

+ (NSString *)pid_header{
    return PID;
}

+ (NSString*)urlEncode:(NSString*)url{
    CFStringRef result =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)url,
                                            NULL,
                                            CFSTR("!*'();:@&=+$,/?%#[] "),
                                            kCFStringEncodingUTF8);
    return (CFAutorelease(result));
}
@end
