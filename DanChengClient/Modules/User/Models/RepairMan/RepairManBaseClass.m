//
//  RepairManBaseClass.m
//
//  Created by 磊 高 on 16/1/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RepairManBaseClass.h"


NSString *const kRepairManBaseClassUserAge = @"userAge";
NSString *const kRepairManBaseClassCreateTime = @"createTime";
NSString *const kRepairManBaseClassRoleId = @"roleId";
NSString *const kRepairManBaseClassUserLoginName = @"userLoginName";
NSString *const kRepairManBaseClassUserQQ = @"userQQ";
NSString *const kRepairManBaseClassUserDeptName = @"userDeptName";
NSString *const kRepairManBaseClassUserPhone = @"userPhone";
NSString *const kRepairManBaseClassUserId = @"userId";
NSString *const kRepairManBaseClassUserGender = @"userGender";
NSString *const kRepairManBaseClassUserName = @"userName";
NSString *const kRepairManBaseClassToken = @"token";
NSString *const kRepairManBaseClassUserEmail = @"userEmail";
NSString *const kRepairManBaseClassModifyTime = @"modifyTime";
NSString *const kRepairManBaseClassUserPicture = @"userPicture";
NSString *const kRepairManBaseClassUserIdcard = @"userIdcard";
NSString *const kRepairManBaseClassUserStatus = @"userStatus";
NSString *const kRepairManBaseClassUserWorkNumber = @"userWorkNumber";
NSString *const kRepairManBaseClassCreateBy = @"createBy";


@interface RepairManBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RepairManBaseClass

@synthesize userAge = _userAge;
@synthesize createTime = _createTime;
@synthesize roleId = _roleId;
@synthesize userLoginName = _userLoginName;
@synthesize userQQ = _userQQ;
@synthesize userDeptName = _userDeptName;
@synthesize userPhone = _userPhone;
@synthesize userId = _userId;
@synthesize userGender = _userGender;
@synthesize userName = _userName;
@synthesize token = _token;
@synthesize userEmail = _userEmail;
@synthesize modifyTime = _modifyTime;
@synthesize userPicture = _userPicture;
@synthesize userIdcard = _userIdcard;
@synthesize userStatus = _userStatus;
@synthesize userWorkNumber = _userWorkNumber;
@synthesize createBy = _createBy;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userAge = [[self objectOrNilForKey:kRepairManBaseClassUserAge fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kRepairManBaseClassCreateTime fromDictionary:dict] doubleValue];
            self.roleId = [[self objectOrNilForKey:kRepairManBaseClassRoleId fromDictionary:dict] doubleValue];
            self.userLoginName = [self objectOrNilForKey:kRepairManBaseClassUserLoginName fromDictionary:dict];
            self.userQQ = [self objectOrNilForKey:kRepairManBaseClassUserQQ fromDictionary:dict];
            self.userDeptName = [self objectOrNilForKey:kRepairManBaseClassUserDeptName fromDictionary:dict];
            self.userPhone = [self objectOrNilForKey:kRepairManBaseClassUserPhone fromDictionary:dict];
            self.userId = [[self objectOrNilForKey:kRepairManBaseClassUserId fromDictionary:dict] doubleValue];
            self.userGender = [[self objectOrNilForKey:kRepairManBaseClassUserGender fromDictionary:dict] doubleValue];
            self.userName = [self objectOrNilForKey:kRepairManBaseClassUserName fromDictionary:dict];
            self.token = [self objectOrNilForKey:kRepairManBaseClassToken fromDictionary:dict];
            self.userEmail = [self objectOrNilForKey:kRepairManBaseClassUserEmail fromDictionary:dict];
            self.modifyTime = [[self objectOrNilForKey:kRepairManBaseClassModifyTime fromDictionary:dict] doubleValue];
            self.userPicture = [self objectOrNilForKey:kRepairManBaseClassUserPicture fromDictionary:dict];
            self.userIdcard = [self objectOrNilForKey:kRepairManBaseClassUserIdcard fromDictionary:dict];
            self.userStatus = [[self objectOrNilForKey:kRepairManBaseClassUserStatus fromDictionary:dict] doubleValue];
            self.userWorkNumber = [self objectOrNilForKey:kRepairManBaseClassUserWorkNumber fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kRepairManBaseClassCreateBy fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userAge] forKey:kRepairManBaseClassUserAge];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kRepairManBaseClassCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.roleId] forKey:kRepairManBaseClassRoleId];
    [mutableDict setValue:self.userLoginName forKey:kRepairManBaseClassUserLoginName];
    [mutableDict setValue:self.userQQ forKey:kRepairManBaseClassUserQQ];
    [mutableDict setValue:self.userDeptName forKey:kRepairManBaseClassUserDeptName];
    [mutableDict setValue:self.userPhone forKey:kRepairManBaseClassUserPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kRepairManBaseClassUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userGender] forKey:kRepairManBaseClassUserGender];
    [mutableDict setValue:self.userName forKey:kRepairManBaseClassUserName];
    [mutableDict setValue:self.token forKey:kRepairManBaseClassToken];
    [mutableDict setValue:self.userEmail forKey:kRepairManBaseClassUserEmail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.modifyTime] forKey:kRepairManBaseClassModifyTime];
    [mutableDict setValue:self.userPicture forKey:kRepairManBaseClassUserPicture];
    [mutableDict setValue:self.userIdcard forKey:kRepairManBaseClassUserIdcard];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userStatus] forKey:kRepairManBaseClassUserStatus];
    [mutableDict setValue:self.userWorkNumber forKey:kRepairManBaseClassUserWorkNumber];
    [mutableDict setValue:self.createBy forKey:kRepairManBaseClassCreateBy];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.userAge = [aDecoder decodeDoubleForKey:kRepairManBaseClassUserAge];
    self.createTime = [aDecoder decodeDoubleForKey:kRepairManBaseClassCreateTime];
    self.roleId = [aDecoder decodeDoubleForKey:kRepairManBaseClassRoleId];
    self.userLoginName = [aDecoder decodeObjectForKey:kRepairManBaseClassUserLoginName];
    self.userQQ = [aDecoder decodeObjectForKey:kRepairManBaseClassUserQQ];
    self.userDeptName = [aDecoder decodeObjectForKey:kRepairManBaseClassUserDeptName];
    self.userPhone = [aDecoder decodeObjectForKey:kRepairManBaseClassUserPhone];
    self.userId = [aDecoder decodeDoubleForKey:kRepairManBaseClassUserId];
    self.userGender = [aDecoder decodeDoubleForKey:kRepairManBaseClassUserGender];
    self.userName = [aDecoder decodeObjectForKey:kRepairManBaseClassUserName];
    self.token = [aDecoder decodeObjectForKey:kRepairManBaseClassToken];
    self.userEmail = [aDecoder decodeObjectForKey:kRepairManBaseClassUserEmail];
    self.modifyTime = [aDecoder decodeDoubleForKey:kRepairManBaseClassModifyTime];
    self.userPicture = [aDecoder decodeObjectForKey:kRepairManBaseClassUserPicture];
    self.userIdcard = [aDecoder decodeObjectForKey:kRepairManBaseClassUserIdcard];
    self.userStatus = [aDecoder decodeDoubleForKey:kRepairManBaseClassUserStatus];
    self.userWorkNumber = [aDecoder decodeObjectForKey:kRepairManBaseClassUserWorkNumber];
    self.createBy = [aDecoder decodeObjectForKey:kRepairManBaseClassCreateBy];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userAge forKey:kRepairManBaseClassUserAge];
    [aCoder encodeDouble:_createTime forKey:kRepairManBaseClassCreateTime];
    [aCoder encodeDouble:_roleId forKey:kRepairManBaseClassRoleId];
    [aCoder encodeObject:_userLoginName forKey:kRepairManBaseClassUserLoginName];
    [aCoder encodeObject:_userQQ forKey:kRepairManBaseClassUserQQ];
    [aCoder encodeObject:_userDeptName forKey:kRepairManBaseClassUserDeptName];
    [aCoder encodeObject:_userPhone forKey:kRepairManBaseClassUserPhone];
    [aCoder encodeDouble:_userId forKey:kRepairManBaseClassUserId];
    [aCoder encodeDouble:_userGender forKey:kRepairManBaseClassUserGender];
    [aCoder encodeObject:_userName forKey:kRepairManBaseClassUserName];
    [aCoder encodeObject:_token forKey:kRepairManBaseClassToken];
    [aCoder encodeObject:_userEmail forKey:kRepairManBaseClassUserEmail];
    [aCoder encodeDouble:_modifyTime forKey:kRepairManBaseClassModifyTime];
    [aCoder encodeObject:_userPicture forKey:kRepairManBaseClassUserPicture];
    [aCoder encodeObject:_userIdcard forKey:kRepairManBaseClassUserIdcard];
    [aCoder encodeDouble:_userStatus forKey:kRepairManBaseClassUserStatus];
    [aCoder encodeObject:_userWorkNumber forKey:kRepairManBaseClassUserWorkNumber];
    [aCoder encodeObject:_createBy forKey:kRepairManBaseClassCreateBy];
}

- (id)copyWithZone:(NSZone *)zone
{
    RepairManBaseClass *copy = [[RepairManBaseClass alloc] init];
    
    if (copy) {

        copy.userAge = self.userAge;
        copy.createTime = self.createTime;
        copy.roleId = self.roleId;
        copy.userLoginName = [self.userLoginName copyWithZone:zone];
        copy.userQQ = [self.userQQ copyWithZone:zone];
        copy.userDeptName = [self.userDeptName copyWithZone:zone];
        copy.userPhone = [self.userPhone copyWithZone:zone];
        copy.userId = self.userId;
        copy.userGender = self.userGender;
        copy.userName = [self.userName copyWithZone:zone];
        copy.token = [self.token copyWithZone:zone];
        copy.userEmail = [self.userEmail copyWithZone:zone];
        copy.modifyTime = self.modifyTime;
        copy.userPicture = [self.userPicture copyWithZone:zone];
        copy.userIdcard = [self.userIdcard copyWithZone:zone];
        copy.userStatus = self.userStatus;
        copy.userWorkNumber = [self.userWorkNumber copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
    }
    
    return copy;
}


@end
