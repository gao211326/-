//
//  CommunityCommunitylist.m
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CommunityCommunitylist.h"


NSString *const kCommunityCommunitylistCommunityCode = @"communityCode";
NSString *const kCommunityCommunitylistCommunityName = @"communityName";


@interface CommunityCommunitylist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommunityCommunitylist

@synthesize communityCode = _communityCode;
@synthesize communityName = _communityName;


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
            self.communityCode = [self objectOrNilForKey:kCommunityCommunitylistCommunityCode fromDictionary:dict];
            self.communityName = [self objectOrNilForKey:kCommunityCommunitylistCommunityName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.communityCode forKey:kCommunityCommunitylistCommunityCode];
    [mutableDict setValue:self.communityName forKey:kCommunityCommunitylistCommunityName];

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

    self.communityCode = [aDecoder decodeObjectForKey:kCommunityCommunitylistCommunityCode];
    self.communityName = [aDecoder decodeObjectForKey:kCommunityCommunitylistCommunityName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_communityCode forKey:kCommunityCommunitylistCommunityCode];
    [aCoder encodeObject:_communityName forKey:kCommunityCommunitylistCommunityName];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommunityCommunitylist *copy = [[CommunityCommunitylist alloc] init];
    
    if (copy) {

        copy.communityCode = [self.communityCode copyWithZone:zone];
        copy.communityName = [self.communityName copyWithZone:zone];
    }
    
    return copy;
}


@end
