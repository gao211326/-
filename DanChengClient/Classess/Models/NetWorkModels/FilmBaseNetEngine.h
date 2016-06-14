//
//  FilmBaseNetEngine.h
//  YingPiao2.2
//
//  Created by 高 on 14-7-16.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "FilmBaseParam.h"
#import "FilmResult.h"
#import "M1905NetObserver.h"

@class FilmBaseParam;

//将请求返回参数传回
@protocol FilmBaseNetEngineDelegate <NSObject>
@optional
/*处理过*/
-(void)returnRequestData:(id)theRequestData command:(NSString*)command message:(NSString*)message netStatusCode:(NSString*)stacode;


/*未处理过*/
-(void)returnRequestData:(id)theRequestData command:(NSString*)command requestUrl:(NSString*)requseturl;

/*网络连接错误时*/
- (void)requsetNetworkError:(NSString*)command requestStatus:(FilmBaseParam *)status;

/*无网络连接的时候*/
- (void)requsetUnNetWork:(NSString*)command requestStatus:(FilmBaseParam *)status;
@end

@interface FilmBaseNetEngine : MKNetworkEngine<FilmBaseNetEngineDelegate>
{
    id <FilmBaseNetEngineDelegate> delegate;
}

@property(nonatomic,assign)id <FilmBaseNetEngineDelegate> delegate;

-(MKNetworkOperation*) postData:(FilmBaseParam*)filmParam withType:(int)type;
-(MKNetworkOperation*) getData:(FilmBaseParam*)filmParam withType:(int)type;

/*网络请求完成后，发出消息（无论是成功还是失败都要发送）*/
- (void)dispatchTransaction:(FilmResult *)transaction;



/*网络请求完成后的相关处理*/
- (void)dispatchTransaction:(NSString *)command
                     status:(FilmRequestStatus)status
                    message:(NSString *)message
                       data:(id)data;

/*网络连接错误的时候的处理*/
- (void)dispatchNetworkError:(NSString *)command
                      status:(FilmRequestStatus)status
                 withMessage:(NSString *)message;

/*无网络连接的时候的相关处理*/
- (void)dispatchUnNetwork:(NSString *)command
                      status:(FilmRequestStatus)status
                 withMessage:(NSString *)message;

- (void)cancelRequest:(NSString*)command;

- (void)cancelAllRequset;

@end



@interface NSObject (FilmEngineTranstionObserver)

/*注册成为监听器*/
- (void)filmobserveTransactionNotificaiton:(NSString *)command;

- (void)filmobserveTransactionNotificaiton:(id)observer command:(NSString *)command;

/*selector  - (void)reqeustFinished:(NSNotification *)notification */
- (void)filmobserveTransactionNotificaiton:(id)observer command:(NSString *)command selector:(SEL)selector;

- (void)filmunobserveTransactionNotificaiton:(NSString *)command;

- (void)filmunobserveTransactionNotificaiton:(id)observer command:(NSString *)command;

/*重写此方法*/
- (void)filmENgineRequestFinished:(FilmResult *)transaction;

@end
