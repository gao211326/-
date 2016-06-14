//
//  CommunityData.m
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CommunityData.h"
#import "CommunityCommunitylist.h"


NSString *const kCommunityDataCommunitylist = @"communitylist";


@interface CommunityData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommunityData

@synthesize communitylist = _communitylist;


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
    NSObject *receivedCommunityCommunitylist = [dict objectForKey:kCommunityDataCommunitylist];
    NSMutableArray *parsedCommunityCommunitylist = [NSMutableArray array];
    if ([receivedCommunityCommunitylist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCommunityCommunitylist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCommunityCommunitylist addObject:[CommunityCommunitylist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCommunityCommunitylist isKindOfClass:[NSDictionary class]]) {
       [parsedCommunityCommunitylist addObject:[CommunityCommunitylist modelObjectWithDictionary:(NSDictionary *)receivedCommunityCommunitylist]];
    }

    self.communitylist = [NSArray arrayWithArray:parsedCommunityCommunitylist];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCommunitylist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.communitylist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCommunitylist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCommunitylist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCommunitylist] forKey:kCommunityDataCommunitylist];

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

    self.communitylist = [aDecoder decodeObjectForKey:kCommunityDataCommunitylist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_communitylist forKey:kCommunityDataCommunitylist];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommunityData *copy = [[CommunityData alloc] init];
    
    if (copy) {

        copy.communitylist = [self.communitylist copyWithZone:zone];
    }
    
    return copy;
}


@end
