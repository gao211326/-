//
//  UserTransaction.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/17.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "UserTransaction.h"
#import "JSONKit.h"
#import "AppDelegate.h"

#import "LoginDataModels.h"
#import "CommunityDataModels.h"
#import "OtherDataModels.h"
#import "RepairMan/RepairManDataModels.h"
#import "UserMessageDataModels.h"
#import "UIImage+Extran.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface UserTransaction ()

@property (nonatomic, strong) NSUserDefaults    *userDefaults;
@property (nonatomic, strong) NSURLSession *session;

@end

static NSString* const kUserToken = @"kUserToken";
static NSString* const kUserInfo = @"kUserInfo";

static NSString* const kUserEmail = @"kUserEmail";
static NSString* const kUserPassword = @"kUserPassword";

@implementation UserTransaction

MENUSIFU_SYNTHESIZE_SINGLETON_FOR_CLASS(UserTransaction)

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setUserDefaults:[NSUserDefaults standardUserDefaults]];
        [self loadUserEmailAndPassword];
        [self loadCurrentUserInfo];
    }
    return  self;
}

/*网络连接错误时*/
- (void)requsetNetworkError:(NSString*)command requestStatus:(FilmBaseParam *)status
{
    if ([command isEqualToString:STRING_NULL])
    {
        
    }
    else
    {
        [self dispatchNetworkError:command status:FilmRequsetFailed withMessage:nil];
    }
}

/*无网络连接的时候*/
- (void)requsetUnNetWork:(NSString*)command requestStatus:(FilmBaseParam *)status
{
    if ([command isEqualToString:STRING_NULL])
    {
        
    }
    else
    {
        [self dispatchUnNetwork:command status:FilmRequsetFailed withMessage:nil];
    }
}

/*请求成功返回数据*/
- (void)returnRequestData:(id)theRequestData command:(NSString *)command requestUrl:(NSString *)requseturl
{
    if ([command isEqualToString:kRegisterCmd])
    {
        id jsonData = [theRequestData objectFromJSONString];
        
        NSDictionary *jsonDic = (NSDictionary *)jsonData;
        
        NSString *code = [jsonDic objectForKey:@"code"];
        NSString *data = [jsonDic objectForKey:@"data"];
//        NSString *message = [jsonDic objectForKey:@"message"];
        
        if ([code integerValue] == 0)
        {
            [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:nil];
        }
        else
        {
            [self dispatchTransaction:command status:FilmRequsetSuccessNoData message:nil data:data];
        }
        
    }
    else if ([command isEqualToString:kUserLoginCmd])
    {
        id jsonData = [theRequestData objectFromJSONString];
        
            NSLog(@" 打印信息:%@",jsonData);
        
        LoginBaseClass *loginBassdata = [LoginBaseClass modelObjectWithDictionary:jsonData];
        
        if ([@"000000" isEqualToString:loginBassdata.r ])
        {
            [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:loginBassdata];
            
            
            [self setNewPersonalInfo:loginBassdata];
        }
        else
        {
            [self dispatchTransaction:command status:FilmRequsetSuccessNoData message:nil data:nil];
        }
    }
    else if ([command isEqualToString:kUserForgotPasswordCmd])
    {
        id jsonData = [theRequestData objectFromJSONString];
        LoginBaseClass *loginBassdata = [LoginBaseClass modelObjectWithDictionary:jsonData];
        
        if ([@"000000" isEqualToString:loginBassdata.r ])
        {
            [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:loginBassdata.d];
        }
        else
        {
            [self dispatchTransaction:command status:FilmRequsetSuccessNoData message:nil data:nil];
        }
    }
    //房屋信息
    else if ([command isEqualToString:kUserGetCommunityCmd])
    {
        id jsonData = [theRequestData objectFromJSONString];
        
        CommunityBaseClass *communityBassdata = [CommunityBaseClass modelObjectWithDictionary:jsonData];
        
        if ([communityBassdata.code integerValue] == 0)
        {
            [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:communityBassdata.data];
        }
        else
        {
            [self dispatchTransaction:command status:FilmRequsetSuccessNoData message:nil data:nil];
        }

    }
    else if ([command isEqualToString:kUserGetBuildingCmd] ||
             [command isEqualToString:kUserGetUnitCmd] ||
             [command isEqualToString:kUserGetFloorCmd] ||
             [command isEqualToString:kUserGetRoomCmd])
    {
        id jsonData = [theRequestData objectFromJSONString];
        OtherBaseClass *otherBassdata = [OtherBaseClass modelObjectWithDictionary:jsonData];
        
        if ([otherBassdata.code integerValue] == 0)
        {
            [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:otherBassdata.data];
        }
        else
        {
            [self dispatchTransaction:command status:FilmRequsetSuccessNoData message:nil data:nil];
        }
    }
//    else if ([command isEqualToString:kUserRepairCmd])
//    {
//        id jsonData = [theRequestData objectFromJSONString];
//    }
    else if ([command isEqualToString:kUserRepairMessageCmd])
    {
        id jsonData = [theRequestData objectFromJSONString];
        
        UserMessageBaseClass *userMessageBaseClass = [UserMessageBaseClass modelObjectWithDictionary:jsonData];
        
        [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:userMessageBaseClass];
    }
    else if ([command isEqualToString:kUserRepairMansCmd])
    {
        id jsonData = [theRequestData objectFromJSONString];
        
        NSArray *array = (NSArray *)jsonData;
        
        [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:array];
//        if ([otherBassdata.code integerValue] == 0)
//        {
//            [self dispatchTransaction:command status:FilmRequsetSuccess message:nil data:otherBassdata.data];
//        }
//        else
//        {
//            [self dispatchTransaction:command status:FilmRequsetSuccessNoData message:nil data:nil];
//        }
    }
}


#pragma mark ==========================================
#pragma mark ==local data manage
#pragma mark ==========================================
- (void)cleanUserInfo
{
    self.currentUser = nil;
    NSData *storeData = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
    [self.userDefaults setObject:storeData forKey:kUserInfo];
    [self.userDefaults synchronize];
}

- (void)loadUserEmailAndPassword
{
    self.userEmail = [self.userDefaults objectForKey:kUserEmail];
    self.userPassword = [self.userDefaults objectForKey:kUserPassword];
}

- (void)saveUserPhone:(NSString *)phone userPassword:(NSString *)password
{
    self.userEmail = phone;
    self.userPassword = password;
    
    [self.userDefaults setObject:phone forKey:kUserEmail];
    [self.userDefaults setObject:password forKey:kUserPassword];
    [self.userDefaults synchronize];
}

- (void)loadCurrentUserInfo
{
    NSData *userData = [self.userDefaults objectForKey:kUserInfo];
    LoginBaseClass* userInfo  = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    [self setNewPersonalInfo:userInfo];
}

- (void)setNewPersonalInfo:(LoginBaseClass *)personalData
{
    self.currentUser = personalData;
    NSData *storeData = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
    [self.userDefaults setObject:storeData forKey:kUserInfo];
    [self.userDefaults synchronize];
}

- (void)updateUserHeadInfo
{

}

- (NSString *)token
{
    return [self.userDefaults objectForKey:kUserToken];
}

#pragma mark ==========================================
#pragma mark ==property class method
#pragma mark ==========================================

- (void)userGetCommunityList
{
    FilmBaseParam *requestParam = [[FilmBaseParam alloc] initWithCommand:kUserGetCommunityCmd];
    [requestParam setUrlString:kUserGetCommunityUrl];
    
    [self getData:requestParam withType:1];
}

- (void)userGetOtherListInfoWithParentCode:(NSString *)parentCode withCmd:(NSString *)cmd
{
    FilmBaseParam *requestParam = [[FilmBaseParam alloc] initWithCommand:cmd];
    [requestParam setUrlString:kUserGetBuildingUrl];
    [requestParam addParam:@"parentCode" withValue:parentCode];
    [self getData:requestParam withType:1];
}

- (void)userLogin:(NSString *)loginName password:(NSString *)password
{
    FilmBaseParam *requestParam = [[FilmBaseParam alloc] initWithCommand:kUserLoginCmd];
    [requestParam setUrlString:kUserLoginUrl];
    
    [requestParam addParam:@"l" withValue:loginName];
    [requestParam addParam:@"p" withValue:password];
    
    [self postData:requestParam withType:0];
}


- (void)userRegisterWithBuildingCode:(NSString *)buildingCode
                            roomCode:(NSString *)roomcode
                                name:(NSString *)name
                         icardNumber:(NSString *)icardNumber
                            nickName:(NSString *)nickName
                               phone:(NSString *)phone
                            password:(NSString *)password
{
    FilmBaseParam *requestParam = [[FilmBaseParam alloc] initWithCommand:kRegisterCmd];
    [requestParam setUrlString:kRegisterUrl];
    
    [requestParam addParam:@"buildingCode" withValue:buildingCode];
    [requestParam addParam:@"roomCode" withValue:roomcode];
    
    [requestParam addParam:@"name" withValue:name];
    [requestParam addParam:@"idcardNumber" withValue:icardNumber];

    [requestParam addParam:@"nickname" withValue:nickName];
    
    [requestParam addParam:@"ownerPhoneNumber" withValue:phone];
    [requestParam addParam:@"password" withValue:password];

    [requestParam addParam:@"type" withValue:@"IOS"];
    [requestParam addParam:@"token" withValue:APP.deviceToken];
    
    [self postData:requestParam withType:1];

}


- (void)userForgotPassword:(NSString *)phone password:(NSString *)password validateCode:(NSString *)validateCode
{
    FilmBaseParam *requestParam = [[FilmBaseParam alloc] initWithCommand:kUserForgotPasswordCmd];
    [requestParam setUrlString:kUserForgotPasswordUrl];
    
    [requestParam addParam:@"l" withValue:phone];
    [requestParam addParam:@"p" withValue:password];
    [requestParam addParam:@"v" withValue:validateCode];
    
    [self postData:requestParam withType:0];
}


- (void)userGetRepairMessageWithPhone:(NSString *)phone pi:(int)pi ps:(int)ps
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@.do?",kUserRepairMessageUrl,phone];
    
    FilmBaseParam *requestParam = [[FilmBaseParam alloc] initWithCommand:kUserRepairMessageCmd];
    [requestParam setUrlString:requestUrl];
    
    [requestParam addParam:@"page" withValue:[NSString fromInt:pi]];
    [requestParam addParam:@"rows" withValue:[NSString fromInt:ps]];
    
    [self postData:requestParam withType:1];
}

- (void)userGetRepairMans
{
    FilmBaseParam *requestParam = [[FilmBaseParam alloc] initWithCommand:kUserRepairMansCmd];
    [requestParam setUrlString:kUserRepairMansUrl];
    [self postData:requestParam withType:1];
}

- (void)postImage:(NSString *)postUrl
      WithContent:(NSString *)content
        startTime:(NSString *)startTime
          endTime:(NSString *)endTime
          picture:(NSArray *)pictureArray
            phone:(NSString *)phone
      repairManId:(NSString *)repairManid
       requestCmd:(NSString *)cmd
{
    NSDictionary *params = @{@"content"     : content,
                             @"appointmentTime":startTime,
                             @"expectFinishTime":endTime,
                             @"repairManId":repairManid,
                             @"phone"    : phone,};
    
    NSString *boundary = [self generateBoundaryString];
    
    // configure the request
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postUrl]];
    [request setHTTPMethod:@"POST"];
    
    // set content type
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // create body
    
    NSData *httpBody = [self createBodyWithBoundary:boundary parameters:params paths:pictureArray fieldName:@"picture"];
    
    
    self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
    
    NSURLSessionTask *task = [self.session uploadTaskWithRequest:request fromData:httpBody completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"error = %@", error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dispatchTransaction:cmd status:FilmRequsetFailed message:nil data:nil];
                
            });
            return;
        }
        
        id jsonData = [data objectFromJSONData];
        
        NSDictionary *jsonDic = (NSDictionary *)jsonData;
        
        NSString *resultCode = [jsonDic objectForKey:@"code"];
        NSString *resultData = [jsonDic objectForKey:@"data"];
        
        
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([resultCode integerValue] == 0)
            {
                [self dispatchTransaction:cmd status:FilmRequsetSuccess message:nil data:resultData];
            }
            else
            {
                [self dispatchTransaction:cmd status:FilmRequsetSuccessNoData message:nil data:resultData];
            }

        });
//        NSLog(@"result = %@", result);
    }];
    [task resume];
}

- (NSData *)createBodyWithBoundary:(NSString *)boundary
                        parameters:(NSDictionary *)parameters
                             paths:(NSArray *)paths
                         fieldName:(NSString *)fieldName
{
    NSMutableData *httpBody = [NSMutableData data];
    
    // add params (all params are strings)
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // add image data
    
    int  i = 0;
    
    for (UIImage *image in paths)
    {
        NSString *filename  = [NSString stringWithFormat:@"postImage%d",i];//[path lastPathComponent];
//        NSData   *data      = [NSData dataWithContentsOfFile:path];
        
//        NSString *mimetype  = [self mimeTypeForPath:path];
        
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [httpBody appendData:data];
        
        NSData *imageData = nil;
        
//        if (UIImagePNGRepresentation(image) == nil)
//        {
//            imageData = UIImageJPEGRepresentation(image, 0.2);
//        }
//        else
//        {
//            imageData = UIImagePNGRepresentation(image);
//        }

        UIImage *scaleImage = [UIImage image:image imageByScalingAndCroppingForSize:CGSizeMake(400, 400)];
        
        imageData = [scaleImage compressedData];
        
        
        [httpBody appendData:imageData];
        
        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}

//- (NSString *)mimeTypeForPath:(NSString *)path
//{
//    // get a mime type for an extension using MobileCoreServices.framework
//    
//    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
//    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
//    assert(UTI != NULL);
//    
//    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
//    assert(mimetype != NULL);
//    
//    CFRelease(UTI);
//    
//    return mimetype;
//}

- (NSString *)generateBoundaryString
{
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
    
    // if supporting iOS versions prior to 6.0, you do something like:
    //
    // // generate boundary string
    // //
    // adapted from http://developer.apple.com/library/ios/#samplecode/SimpleURLConnections
    //
    // CFUUIDRef  uuid;
    // NSString  *uuidStr;
    //
    // uuid = CFUUIDCreate(NULL);
    // assert(uuid != NULL);
    //
    // uuidStr = CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
    // assert(uuidStr != NULL);
    //
    // CFRelease(uuid);
    //
    // return uuidStr;
}



@end
