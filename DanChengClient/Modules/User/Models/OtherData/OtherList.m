//
//  OtherList.m
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OtherList.h"


NSString *const kOtherListUpdateDate = @"updateDate";
NSString *const kOtherListCreateBy = @"createBy";//
NSString *const kOtherListId = @"relevanceId";//@"id";
NSString *const kOtherListCode = @"sonCode";//
NSString *const kOtherListParentName = @"parentName";//
NSString *const kOtherListUpdateBy = @"modifyBy";//@"updateBy";
NSString *const kOtherListOrderIndex = @"orderIndex";
NSString *const kOtherListCreateDate = @"createBy";//@"createDate";
NSString *const kOtherListName = @"sonName";//
NSString *const kOtherListParentCode = @"parentCode";//


@interface OtherList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OtherList

@synthesize updateDate = _updateDate;
@synthesize createBy = _createBy;
@synthesize listIdentifier = _listIdentifier;
@synthesize code = _code;
@synthesize parentName = _parentName;
@synthesize updateBy = _updateBy;
@synthesize orderIndex = _orderIndex;
@synthesize createDate = _createDate;
@synthesize name = _name;
@synthesize parentCode = _parentCode;


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
            self.updateDate = [self objectOrNilForKey:kOtherListUpdateDate fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kOtherListCreateBy fromDictionary:dict];
            self.listIdentifier = [[self objectOrNilForKey:kOtherListId fromDictionary:dict] doubleValue];
            self.code = [self objectOrNilForKey:kOtherListCode fromDictionary:dict];
            self.parentName = [self objectOrNilForKey:kOtherListParentName fromDictionary:dict];
            self.updateBy = [self objectOrNilForKey:kOtherListUpdateBy fromDictionary:dict];
            self.orderIndex = [self objectOrNilForKey:kOtherListOrderIndex fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kOtherListCreateDate fromDictionary:dict];
            self.name = [self objectOrNilForKey:kOtherListName fromDictionary:dict];
            self.parentCode = [self objectOrNilForKey:kOtherListParentCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.updateDate forKey:kOtherListUpdateDate];
    [mutableDict setValue:self.createBy forKey:kOtherListCreateBy];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kOtherListId];
    [mutableDict setValue:self.code forKey:kOtherListCode];
    [mutableDict setValue:self.parentName forKey:kOtherListParentName];
    [mutableDict setValue:self.updateBy forKey:kOtherListUpdateBy];
    [mutableDict setValue:self.orderIndex forKey:kOtherListOrderIndex];
    [mutableDict setValue:self.createDate forKey:kOtherListCreateDate];
    [mutableDict setValue:self.name forKey:kOtherListName];
    [mutableDict setValue:self.parentCode forKey:kOtherListParentCode];

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

    self.updateDate = [aDecoder decodeObjectForKey:kOtherListUpdateDate];
    self.createBy = [aDecoder decodeObjectForKey:kOtherListCreateBy];
    self.listIdentifier = [aDecoder decodeDoubleForKey:kOtherListId];
    self.code = [aDecoder decodeObjectForKey:kOtherListCode];
    self.parentName = [aDecoder decodeObjectForKey:kOtherListParentName];
    self.updateBy = [aDecoder decodeObjectForKey:kOtherListUpdateBy];
    self.orderIndex = [aDecoder decodeObjectForKey:kOtherListOrderIndex];
    self.createDate = [aDecoder decodeObjectForKey:kOtherListCreateDate];
    self.name = [aDecoder decodeObjectForKey:kOtherListName];
    self.parentCode = [aDecoder decodeObjectForKey:kOtherListParentCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_updateDate forKey:kOtherListUpdateDate];
    [aCoder encodeObject:_createBy forKey:kOtherListCreateBy];
    [aCoder encodeDouble:_listIdentifier forKey:kOtherListId];
    [aCoder encodeObject:_code forKey:kOtherListCode];
    [aCoder encodeObject:_parentName forKey:kOtherListParentName];
    [aCoder encodeObject:_updateBy forKey:kOtherListUpdateBy];
    [aCoder encodeObject:_orderIndex forKey:kOtherListOrderIndex];
    [aCoder encodeObject:_createDate forKey:kOtherListCreateDate];
    [aCoder encodeObject:_name forKey:kOtherListName];
    [aCoder encodeObject:_parentCode forKey:kOtherListParentCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    OtherList *copy = [[OtherList alloc] init];
    
    if (copy) {

        copy.updateDate = [self.updateDate copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
        copy.listIdentifier = self.listIdentifier;
        copy.code = [self.code copyWithZone:zone];
        copy.parentName = [self.parentName copyWithZone:zone];
        copy.updateBy = [self.updateBy copyWithZone:zone];
        copy.orderIndex = [self.orderIndex copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.parentCode = [self.parentCode copyWithZone:zone];
    }
    
    return copy;
}


@end
