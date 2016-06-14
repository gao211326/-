//
//  M1905NetObserver.m
//  Dingding
//
//  Created by 陈欢 on 14-3-5.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "M1905NetObserver.h"
#import "Reachability.h"

NSString *const kNetStatueChangedNotification = @"kNetStatueChangedNotification";

@interface M1905NetObserver()
{
    Reachability *_reachability;
    NSMutableDictionary *_keyDict;
}
@end

@implementation M1905NetObserver

MENUSIFU_SYNTHESIZE_SINGLETON_FOR_CLASS(M1905NetObserver)

+ (void)startListenNetworkStatus {
    [[M1905NetObserver sharedInstance] startNotifier];
}

+ (void)addNetworkObserverBlock:(void(^)(int status))block forKey:(NSString *)key {
    [[M1905NetObserver sharedInstance] addNetworkObserverBlock:block forKey:key];
}

+ (BOOL)isReachable {
//    return [[[M1905NetObserver sharedInstance] reachability] isReachable];
    return [[Reachability reachabilityForInternetConnection] isReachable];
}

+ (BOOL)isReachableViaWWAN {
    return [[[M1905NetObserver sharedInstance] reachability] isReachableViaWWAN];
}

+ (BOOL)isReachableViaWiFi {
    return [[[M1905NetObserver sharedInstance] reachability] isReachableViaWiFi];
}

- (id)init {
    if (instance == nil) {
        if (self = [super init]) {
            _keyDict = [[NSMutableDictionary alloc] init];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(reachabilityChanaged:)
                                                         name:kReachabilityChangedNotification
                                                       object:nil];
            
            [self reachability];
            [self updateInterfaceWithReachability:_reachability];
            
            instance = self;
        }
    }
    return instance ;
}

- (void)addNetworkObserverBlock:(void(^)(int status))block forKey:(NSString *)key {
    [_keyDict setObject:block forKey:key];
}

- (Reachability *)reachability {
    if (_reachability == nil) {
        NSString *host = @"www.baidu.com";
        _reachability = [Reachability reachabilityWithHostname:host];//[Reachability reachabilityWithHostName:host];
    }
    return _reachability;
}

- (void)startNotifier {
    [[self reachability] startNotifier];
}

- (void)reachabilityChanaged:(NSNotification *)noti {
    Reachability *reachability = [noti object];
    if ([reachability isKindOfClass:[Reachability class]]) {
        [self updateInterfaceWithReachability:reachability];
    }
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetStatueChangedNotification
                                                        object:[NSNumber numberWithInt:status]];
    
//    
//    BOOL isCustomerMsg = NO;
//    
    for (NSString *key in [_keyDict allKeys]) {
        void(^networkBlock)(int status) = [_keyDict objectForKey:key];
        networkBlock(status);
//        isCustomerMsg = YES;
    }
}


- (void)dealloc {
    [_reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
}
@end
