//
//  NSData+Encrypt.h
//  socialDemo
//
//  Created by 陈欢 on 13-12-30.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

/*md5 加密*/
- (NSString *)md5;

/*base64 加密*/
- (NSString *)base64Encoded;

/*base64 解密*/
- (NSData *)base64Decoded;

@end
