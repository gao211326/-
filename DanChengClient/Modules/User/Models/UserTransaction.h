//
//  UserTransaction.h
//  DanChengClient
//
//  Created by 高磊 on 15/5/17.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "FilmBaseNetEngine.h"

//-----------------登录注册相关
//注册
#define kRegisterCmd                            @"kRegisterCmd"
#define kRegisterUrl                            @"crm/api/repair/registerUser.do"

//登录
#define kUserLoginCmd                           @"kUserLoginCmd"
#define kUserLoginUrl                           @"login.json"

//找回密码
#define kUserForgotPasswordCmd                  @"kUserForgotPasswordCmd"
#define kUserForgotPasswordUrl                  @"restPassword.json"

//小区
#define kUserGetCommunityCmd                    @"kUserGetCommunityCmd"
#define kUserGetCommunityUrl                    @"crm/api/residence/communities.do"

//楼栋
#define kUserGetBuildingCmd                     @"kUserGetBuildingCmd"
//单元
#define kUserGetUnitCmd                         @"kUserGetUnitCmd"
//楼层
#define kUserGetFloorCmd                        @"kUserGetFloorCmd"
//房号
#define kUserGetRoomCmd                         @"kUserGetRoomCmd"

#define kUserGetBuildingUrl                     @"crm/api/residence/subcodes.do"

#define kUserRepairCmd                          @"kUserRepairCmd"
#define kUserRepairUrl                          @"mobile/repair/applyForRepair.json"



#define kUserRepairMessageCmd                   @"kUserRepairMessageCmd"
#define kUserRepairMessageUrl                   @"crm/api/repair/repairUserMessage/list/"


#define kUserRepairMansCmd                      @"kUserRepairMansCmd"
#define kUserRepairMansUrl                      @"crm/api/repair/repairMans.do"

@class LoginBaseClass;
@interface UserTransaction : FilmBaseNetEngine

MENUSIFU_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(UserTransaction);

@property (nonatomic,strong) NSString * userEmail;
@property (nonatomic,strong) NSString * userPassword;

@property (nonatomic,strong)NSString *          token;

@property (nonatomic,strong)LoginBaseClass *    currentUser;


- (void)cleanUserInfo;
/**
 *  保存个人信息
 *
 *  @param personalData
 */
- (void)setNewPersonalInfo:(LoginBaseClass *)personalData;

/**
 *  保存用户登录密码和账号
 *
 *  @param phone
 *  @param password
 */
- (void)saveUserPhone:(NSString *)phone userPassword:(NSString *)password;

/**
 *  小区信息
 */
- (void)userGetCommunityList;

/**
 *  获取楼栋 单元 楼层 房号信息
 *
 *  @param parentCode
 */
- (void)userGetOtherListInfoWithParentCode:(NSString *)parentCode withCmd:(NSString *)cmd;

- (void)userLogin:(NSString *)loginName password:(NSString *)password;

- (void)userRegisterWithBuildingCode:(NSString *)buildingCode
                            roomCode:(NSString *)roomcode
                                name:(NSString *)name
                         icardNumber:(NSString *)icardNumber
                            nickName:(NSString *)nickName
                               phone:(NSString *)phone
                            password:(NSString *)password;

- (void)userForgotPassword:(NSString *)phone
                  password:(NSString *)password
              validateCode:(NSString *)validateCode;


- (void)postImage:(NSString *)postUrl
      WithContent:(NSString *)content
        startTime:(NSString *)startTime
          endTime:(NSString *)endTime
          picture:(NSArray *)pictureArray
            phone:(NSString *)phone
      repairManId:(NSString *)repairManid
       requestCmd:(NSString *)cmd;


- (void)userGetRepairMessageWithPhone:(NSString *)phone pi:(int)pi ps:(int)ps;

//回去维修人员
- (void)userGetRepairMans;

@end
