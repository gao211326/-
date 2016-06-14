//
//  UserMessageRows.m
//
//  Created by 磊 高 on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserMessageRows.h"


NSString *const kUserMessageRowsEnable = @"enable";
NSString *const kUserMessageRowsContent = @"content";
NSString *const kUserMessageRowsOrderId = @"orderId";
NSString *const kUserMessageRowsRepairUserPhone = @"repairUserPhone";
NSString *const kUserMessageRowsId = @"id";
NSString *const kUserMessageRowsReaded = @"readed";
NSString *const kUserMessageRowsRepairUserId = @"repairUserId";
NSString *const kUserMessageRowsCreateTime = @"createTime";


@interface UserMessageRows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserMessageRows

@synthesize enable = _enable;
@synthesize content = _content;
@synthesize orderId = _orderId;
@synthesize repairUserPhone = _repairUserPhone;
@synthesize rowsIdentifier = _rowsIdentifier;
@synthesize readed = _readed;
@synthesize repairUserId = _repairUserId;
@synthesize createTime = _createTime;


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
            self.enable = [[self objectOrNilForKey:kUserMessageRowsEnable fromDictionary:dict] boolValue];
            self.content = [self objectOrNilForKey:kUserMessageRowsContent fromDictionary:dict];
            self.orderId = [[self objectOrNilForKey:kUserMessageRowsOrderId fromDictionary:dict] doubleValue];
            self.repairUserPhone = [self objectOrNilForKey:kUserMessageRowsRepairUserPhone fromDictionary:dict];
            self.rowsIdentifier = [[self objectOrNilForKey:kUserMessageRowsId fromDictionary:dict] doubleValue];
            self.readed = [[self objectOrNilForKey:kUserMessageRowsReaded fromDictionary:dict] boolValue];
            self.repairUserId = [[self objectOrNilForKey:kUserMessageRowsRepairUserId fromDictionary:dict] doubleValue];
            self.createTime = [self objectOrNilForKey:kUserMessageRowsCreateTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.enable] forKey:kUserMessageRowsEnable];
    [mutableDict setValue:self.content forKey:kUserMessageRowsContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderId] forKey:kUserMessageRowsOrderId];
    [mutableDict setValue:self.repairUserPhone forKey:kUserMessageRowsRepairUserPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rowsIdentifier] forKey:kUserMessageRowsId];
    [mutableDict setValue:[NSNumber numberWithBool:self.readed] forKey:kUserMessageRowsReaded];
    [mutableDict setValue:[NSNumber numberWithDouble:self.repairUserId] forKey:kUserMessageRowsRepairUserId];
    [mutableDict setValue:self.createTime forKey:kUserMessageRowsCreateTime];

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

    self.enable = [aDecoder decodeBoolForKey:kUserMessageRowsEnable];
    self.content = [aDecoder decodeObjectForKey:kUserMessageRowsContent];
    self.orderId = [aDecoder decodeDoubleForKey:kUserMessageRowsOrderId];
    self.repairUserPhone = [aDecoder decodeObjectForKey:kUserMessageRowsRepairUserPhone];
    self.rowsIdentifier = [aDecoder decodeDoubleForKey:kUserMessageRowsId];
    self.readed = [aDecoder decodeBoolForKey:kUserMessageRowsReaded];
    self.repairUserId = [aDecoder decodeDoubleForKey:kUserMessageRowsRepairUserId];
    self.createTime = [aDecoder decodeObjectForKey:kUserMessageRowsCreateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_enable forKey:kUserMessageRowsEnable];
    [aCoder encodeObject:_content forKey:kUserMessageRowsContent];
    [aCoder encodeDouble:_orderId forKey:kUserMessageRowsOrderId];
    [aCoder encodeObject:_repairUserPhone forKey:kUserMessageRowsRepairUserPhone];
    [aCoder encodeDouble:_rowsIdentifier forKey:kUserMessageRowsId];
    [aCoder encodeBool:_readed forKey:kUserMessageRowsReaded];
    [aCoder encodeDouble:_repairUserId forKey:kUserMessageRowsRepairUserId];
    [aCoder encodeObject:_createTime forKey:kUserMessageRowsCreateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserMessageRows *copy = [[UserMessageRows alloc] init];
    
    if (copy) {

        copy.enable = self.enable;
        copy.content = [self.content copyWithZone:zone];
        copy.orderId = self.orderId;
        copy.repairUserPhone = [self.repairUserPhone copyWithZone:zone];
        copy.rowsIdentifier = self.rowsIdentifier;
        copy.readed = self.readed;
        copy.repairUserId = self.repairUserId;
        copy.createTime = [self.createTime copyWithZone:zone];
    }
    
    return copy;
}


@end
