//
//  RepairManBaseClass.h
//
//  Created by 磊 高 on 16/1/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RepairManBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double userAge;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double roleId;
@property (nonatomic, strong) NSString *userLoginName;
@property (nonatomic, strong) NSString *userQQ;
@property (nonatomic, strong) NSString *userDeptName;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double userGender;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, assign) double modifyTime;
@property (nonatomic, strong) NSString *userPicture;
@property (nonatomic, strong) NSString *userIdcard;
@property (nonatomic, assign) double userStatus;
@property (nonatomic, strong) NSString *userWorkNumber;
@property (nonatomic, strong) NSString *createBy;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
