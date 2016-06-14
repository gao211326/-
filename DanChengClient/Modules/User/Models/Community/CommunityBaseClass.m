//
//  CommunityBaseClass.m
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CommunityBaseClass.h"
#import "CommunityData.h"


NSString *const kCommunityBaseClassMessage = @"message";
NSString *const kCommunityBaseClassData = @"data";
NSString *const kCommunityBaseClassCode = @"code";


@interface CommunityBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommunityBaseClass

@synthesize message = _message;
@synthesize data = _data;
@synthesize code = _code;


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
            self.message = [self objectOrNilForKey:kCommunityBaseClassMessage fromDictionary:dict];
            self.data = [CommunityData modelObjectWithDictionary:[dict objectForKey:kCommunityBaseClassData]];
            self.code = [self objectOrNilForKey:kCommunityBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kCommunityBaseClassMessage];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kCommunityBaseClassData];
    [mutableDict setValue:self.code forKey:kCommunityBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kCommunityBaseClassMessage];
    self.data = [aDecoder decodeObjectForKey:kCommunityBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kCommunityBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kCommunityBaseClassMessage];
    [aCoder encodeObject:_data forKey:kCommunityBaseClassData];
    [aCoder encodeObject:_code forKey:kCommunityBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommunityBaseClass *copy = [[CommunityBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
