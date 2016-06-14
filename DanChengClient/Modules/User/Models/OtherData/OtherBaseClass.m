//
//  OtherBaseClass.m
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OtherBaseClass.h"
#import "OtherData.h"


NSString *const kOtherBaseClassMessage = @"message";
NSString *const kOtherBaseClassData = @"data";
NSString *const kOtherBaseClassCode = @"code";


@interface OtherBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OtherBaseClass

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
            self.message = [self objectOrNilForKey:kOtherBaseClassMessage fromDictionary:dict];
            self.data = [OtherData modelObjectWithDictionary:[dict objectForKey:kOtherBaseClassData]];
            self.code = [self objectOrNilForKey:kOtherBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kOtherBaseClassMessage];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kOtherBaseClassData];
    [mutableDict setValue:self.code forKey:kOtherBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kOtherBaseClassMessage];
    self.data = [aDecoder decodeObjectForKey:kOtherBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kOtherBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kOtherBaseClassMessage];
    [aCoder encodeObject:_data forKey:kOtherBaseClassData];
    [aCoder encodeObject:_code forKey:kOtherBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    OtherBaseClass *copy = [[OtherBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
