//
//  FilmBaseParam.h
//  YingPiao2.2
//
//  Created by 高 on 14-7-16.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilmBaseParam : NSObject
{
    /*datas*/
    NSMutableDictionary *_postParam;
    /*网络请求的参数*/
    NSMutableDictionary*_bodyParam;
}

@property (nonatomic, strong) NSString              *urlString;
@property (nonatomic, strong) NSString              *method;
//@property (nonatomic, strong) NSString              *uid;
//@property (nonatomic, strong) NSString              *did;
//@property (nonatomic, strong) NSString              *key;
@property (nonatomic, strong) NSString              *command;
//@property (nonatomic, strong) NSString              *ver;
//@property (nonatomic, strong) NSString              *pid;
@property (nonatomic, strong) NSString              *T;
@property (nonatomic, strong) NSString              *ua;

- (id)initWithCommand:(NSString*)command;

- (BOOL)isGet;

- (BOOL)isPost;

- (void)addCommand:(NSString*)command;

- (void)addParam:(NSString *)key withValue:(id)value;

- (NSString *)paramOfGet;//get返回 字符串

- (NSDictionary *)paramOfPost;//post返回 字典

- (NSDictionary *)paramOfHeader;
// 提供给外部使用

+ (NSString *)key_header;

+ (NSString *)did_header;

+ (NSString *)ver_header;

+ (NSString *)pid_header;

+ (NSString*)urlEncode:(NSString*)url;

@end
