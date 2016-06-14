//
//  FilmResult.h
//  YingPiao2.2
//
//  Created by 高 on 14-7-17.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FilmRequsetSuccess,
    FilmRequsetFailed,
    FilmRequsetSuccessNoData,
    FilmRequsetCacheNotNetWork
}FilmRequestStatus;

@interface FilmResult : NSObject

@property (nonatomic, strong) NSString              *command;
@property (nonatomic, assign) FilmRequestStatus     status;
@property (nonatomic, strong) NSString              *message;
@property (nonatomic, strong) id                    data;

- (id)initWithCommand:(NSString *)_command message:(NSString *)_message data:(id)_data;

- (BOOL)is:(NSString *)command;

- (BOOL)isSuccess;

@end
