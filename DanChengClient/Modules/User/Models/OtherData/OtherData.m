//
//  OtherData.m
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OtherData.h"
#import "OtherList.h"


NSString *const kOtherDataList = @"list";


@interface OtherData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OtherData

@synthesize list = _list;


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
    NSObject *receivedOtherList = [dict objectForKey:kOtherDataList];
    NSMutableArray *parsedOtherList = [NSMutableArray array];
    if ([receivedOtherList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOtherList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOtherList addObject:[OtherList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOtherList isKindOfClass:[NSDictionary class]]) {
       [parsedOtherList addObject:[OtherList modelObjectWithDictionary:(NSDictionary *)receivedOtherList]];
    }

    self.list = [NSArray arrayWithArray:parsedOtherList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kOtherDataList];

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

    self.list = [aDecoder decodeObjectForKey:kOtherDataList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_list forKey:kOtherDataList];
}

- (id)copyWithZone:(NSZone *)zone
{
    OtherData *copy = [[OtherData alloc] init];
    
    if (copy) {

        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
