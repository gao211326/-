//
//  FilmResult.m
//  YingPiao2.2
//
//  Created by 高 on 14-7-17.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import "FilmResult.h"

@implementation FilmResult

- (id)initWithCommand:(NSString *)command_ message:(NSString *)message_ data:(id)data_
{
    if (self = [super init])
    {
        self.command = [NSString stringWithString:command_];
        self.message = [NSString stringWithString:message_];
        _data = data_;
    }
    return self;
}

- (BOOL)is:(NSString *)command_ {
    if ([self.command isEqualToString:command_]) {
        return YES;
    }
    return NO;
}

- (BOOL)isSuccess {
    return self.status==FilmRequsetSuccess?YES:NO;
}
@end
