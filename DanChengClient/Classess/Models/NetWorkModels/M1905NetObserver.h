//
//  M1905NetObserver.h
//  Dingding
//
//  Created by 陈欢 on 14-3-5.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M1905NetObserver : NSObject

MENUSIFU_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(M1905NetObserver)

+ (void)startListenNetworkStatus;

+ (void)addNetworkObserverBlock:(void(^)(int status))block forKey:(NSString *)key;

+ (BOOL)isReachable;

+ (BOOL)isReachableViaWWAN;

+ (BOOL)isReachableViaWiFi;

@end
