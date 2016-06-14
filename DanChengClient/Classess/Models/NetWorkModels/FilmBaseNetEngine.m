//
//  FilmBaseNetEngine.m
//  YingPiao2.2
//
//  Created by 高 on 14-7-16.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import "FilmBaseNetEngine.h"
 
#import "NSString+ThreeDES.h"
#import "JSONKit.h"



@interface FilmBaseNetEngine()
{

}

@property(nonatomic,strong)NSMutableDictionary *requestList;
@end

@implementation FilmBaseNetEngine

@synthesize delegate = _delegate;

- (NSMutableDictionary*)requestList
{
    if (nil==_requestList)
    {
        _requestList = [[NSMutableDictionary alloc]init];
    }
    return _requestList;
}

- (id)init {
    if (self = [super init])
    {
        self.delegate = self;
    }
    return self;
}

#pragma mark ^^^^^^___^^^^^
#pragma mark 网络请求完成后，发出通知
#pragma mark ^^^^^^___^^^^^
- (void)dispatchTransaction:(FilmResult *)transaction {
    [[NSNotificationCenter defaultCenter] postNotificationName:transaction.command
                                                        object:nil
                                                      userInfo:[NSDictionary dictionaryWithObject:transaction forKey:@"transaction"]];
}

#pragma mark ^^^^^^___^^^^^
#pragma mark 网络请求完成后的相关处理
#pragma mark ^^^^^^___^^^^^
- (void)dispatchTransaction:(NSString *)command status:(FilmRequestStatus)status message:(NSString *)message data:(id)data
{
    FilmResult *result = [[FilmResult alloc]init];
    [result setCommand:command];
    [result setStatus:status];
    [result setMessage:message];
    [result setData:data];
    [self dispatchTransaction:result];
}

#pragma mark ^^^^^^___^^^^^
#pragma mark 网络连接错误时（网络连接失败，超时等）
#pragma mark ^^^^^^___^^^^^
/*网络连接错误*/
- (void)dispatchNetworkError:(NSString *)command status:(FilmRequestStatus)status withMessage:(NSString *)message
{
    FilmResult *result = [[FilmResult alloc]init];
    [result setCommand:command];
    [result setStatus:status];
    [result setData:nil];
    if (message == nil
        ||[[message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:STRING_NULL])
    {
        message = @"您的网络连接有问题。";
    }
    [result setMessage:message];
    [self dispatchTransaction:result];
}

/*没有网络时*/
- (void)dispatchUnNetwork:(NSString *)command status:(FilmRequestStatus)status withMessage:(NSString *)message
{
    FilmResult *result = [[FilmResult alloc]init];
    [result setCommand:command];
    [result setStatus:status];
    [result setData:nil];
    if (message == nil
        ||[[message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:STRING_NULL])
    {
        message = @"您还没有连接网络。";
    }
    [result setMessage:message];
    [self dispatchTransaction:result];
}

#pragma mark ^^^^^^___^^^^^
#pragma mark 网络请求失败的代理执行函数
#pragma mark ^^^^^^___^^^^^

-(MKNetworkOperation*) postData:(FilmBaseParam*)filmParam withType:(int)type
{
    if ([M1905NetObserver isReachable])
    {
        NSString *urlAddress = nil;
        if (type == 0)
        {
            urlAddress = FILM_SERVER_ADDRESS;
        }
        else if (type == 1)
        {
            urlAddress = FILM_SERVER_REGIETER;
        }
        
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:urlAddress
                                                         customHeaderFields:filmParam.paramOfHeader];
        MKNetworkOperation *op = [engine operationWithPath:filmParam.urlString
                                params:filmParam.paramOfPost
                            httpMethod:@"POST"];

        
        [self.requestList setObject:op forKey:filmParam.command];
        __weak __typeof(self)weakSelf = self;
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
            
             NSLog(@"--==POST==+++++%@",completedOperation.url);
            [weakSelf.requestList removeObjectForKey:filmParam.command];
            NSString *responseString = [completedOperation responseString];
            [weakSelf dispatchData:responseString command:filmParam.command requestUrl:completedOperation.url];
        }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
            [weakSelf.requestList removeObjectForKey:filmParam.command];
            [weakSelf dispathRequestNetError:filmParam.command Param:filmParam];
        }];
        
        [self enqueueOperation:op];
        return op;
    }
    else
    {
        [self dispathRequestUnNetWork:filmParam.command param:filmParam];
        return nil;
    }
}

-(MKNetworkOperation*) getData:(FilmBaseParam*)filmParam withType:(int)type
{
    if ([M1905NetObserver isReachable])
    {
        
        NSString *urlAddress = nil;
        if (type == 0)
        {
            urlAddress = FILM_SERVER_ADDRESS;
        }
        else if (type == 1)
        {
            urlAddress = FILM_SERVER_REGIETER;
        }

        
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:urlAddress
                                                         customHeaderFields:filmParam.paramOfHeader];
//        [engine useCache];
        
        MKNetworkOperation *op = [engine operationWithPath:[NSString stringWithFormat:TWO_STRING_LINK,filmParam.urlString,filmParam.paramOfGet] params:nil httpMethod:filmParam.method];
        
        
        __weak __typeof(self)weakSelf = self;
        
        [self.requestList setObject:op forKey:filmParam.command];//将请求添加到字典中  以便取消
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
            
            [weakSelf.requestList removeObjectForKey:filmParam.command];//请求完成后，删除字典中对应的请求
            
            NSString *responseString = [completedOperation responseString];
            [weakSelf dispatchData:responseString command:filmParam.command requestUrl:completedOperation.url];
            
            NSLog(@"--====+++++%@",completedOperation.url);
            
        }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
            [weakSelf.requestList removeObjectForKey:filmParam.command];
            [weakSelf dispathRequestNetError:filmParam.command Param:filmParam];
        }];
        [engine enqueueOperation:op];
        return op;
    }
    else
    {
        [self dispathRequestUnNetWork:filmParam.command param:filmParam];
        return nil;
    }
}

/*返回处理过的数据*/
- (void)dispatchData:(id)theRequestData command:(NSString *)command message:(NSString *)message netStatusCode:(NSString *)stacode
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnRequestData:command:message:netStatusCode:)])
    {
        [self.delegate returnRequestData:(id)theRequestData
                                 command:command
                                 message:message
                           netStatusCode:stacode];
    }
}

/*返回未处理的数据*/
- (void)dispatchData:(id)theRequestData command:(NSString *)command requestUrl:(NSString*)requestUrl
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnRequestData:command:requestUrl:)])
    {
        [self.delegate returnRequestData:theRequestData command:command requestUrl:requestUrl];
    }
}

/*处理网络请求失败*/
- (void)dispathRequestNetError:(NSString*)command Param:(FilmBaseParam*)filmParam
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requsetNetworkError:requestStatus:)])
    {
        [self.delegate requsetNetworkError:command requestStatus:filmParam];
    }
}

/*处理没有网络的时候*/
- (void)dispathRequestUnNetWork:(NSString*)command param:(FilmBaseParam*)filmparam
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requsetUnNetWork:requestStatus:)])
    {
        [self.delegate requsetUnNetWork:command requestStatus:filmparam];
    }
}

/*取消请求*/
- (void)cancelRequest:(NSString*)command
{
    [self filmunobserveTransactionNotificaiton:command];
    MKNetworkOperation *op = [self.requestList objectForKey:command];
    if (nil!=op)
    {
        [op cancel];
        op = nil;
    }
}

- (void)cancelAllRequset
{
    for (NSString *key in [self.requestList allKeys])
    {
        [self cancelRequest:key];
    }
}
@end


#pragma mark ^^^^^^___^^^^^
#pragma mark 关于各项通知
#pragma mark ^^^^^^___^^^^^



@implementation NSObject (FilmEngineTranstionObserver)

- (void)filmobserveTransactionNotificaiton:(NSString *)command {
    [self filmobserveTransactionNotificaiton:self command:command];
}

- (void)filmobserveTransactionNotificaiton:(id)observer command:(NSString *)command {
    [self filmobserveTransactionNotificaiton:observer
                                 command:command
                                selector:@selector(filmtRequestFinished:)];
}

- (void)filmobserveTransactionNotificaiton:(id)observer command:(NSString *)command selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:command object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector
                                                 name:command
                                               object:nil];
}

- (void)filmtRequestFinished:(NSNotification *)noti {
    FilmResult *transaction = [[noti userInfo] objectForKey:@"transaction"];
    [self filmENgineRequestFinished:transaction];
}

- (void)filmunobserveTransactionNotificaiton:(NSString *)command {
    [self filmunobserveTransactionNotificaiton:self command:command];
}

- (void)filmunobserveTransactionNotificaiton:(id)observer command:(NSString *)command {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:command object:nil];
}

- (void)filmENgineRequestFinished:(FilmResult *)transaction
{
    
}

@end


