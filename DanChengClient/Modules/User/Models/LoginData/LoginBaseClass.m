//
//  LoginBaseClass.m
//
//  Created by 磊 高 on 15/6/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginBaseClass.h"


NSString *const kLoginBaseClassD = @"d";
NSString *const kLoginBaseClassRid = @"rid";
NSString *const kLoginBaseClassUt = @"ut";
NSString *const kLoginBaseClassR = @"r";
NSString *const kLoginBaseClassN = @"n";
NSString *const kLoginBaseClassT = @"T";
NSString *const kLoginBaseClassTags = @"tags";


@interface LoginBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginBaseClass

@synthesize d = _d;
@synthesize rid = _rid;
@synthesize ut = _ut;
@synthesize r = _r;
@synthesize n = _n;
@synthesize t = _t;
@synthesize tags = _tags;


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
            self.d = [self objectOrNilForKey:kLoginBaseClassD fromDictionary:dict];
            self.rid = [self objectOrNilForKey:kLoginBaseClassRid fromDictionary:dict];
            self.ut = [self objectOrNilForKey:kLoginBaseClassUt fromDictionary:dict];
            self.r = [self objectOrNilForKey:kLoginBaseClassR fromDictionary:dict];
            self.n = [self objectOrNilForKey:kLoginBaseClassN fromDictionary:dict];
            self.t = [self objectOrNilForKey:kLoginBaseClassT fromDictionary:dict];
            self.tags = [self objectOrNilForKey:kLoginBaseClassTags fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.d forKey:kLoginBaseClassD];
    [mutableDict setValue:self.rid forKey:kLoginBaseClassRid];
    [mutableDict setValue:self.ut forKey:kLoginBaseClassUt];
    [mutableDict setValue:self.r forKey:kLoginBaseClassR];
    [mutableDict setValue:self.n forKey:kLoginBaseClassN];
    [mutableDict setValue:self.t forKey:kLoginBaseClassT];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kLoginBaseClassTags];

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

    self.d = [aDecoder decodeObjectForKey:kLoginBaseClassD];
    self.rid = [aDecoder decodeObjectForKey:kLoginBaseClassRid];
    self.ut = [aDecoder decodeObjectForKey:kLoginBaseClassUt];
    self.r = [aDecoder decodeObjectForKey:kLoginBaseClassR];
    self.n = [aDecoder decodeObjectForKey:kLoginBaseClassN];
    self.t = [aDecoder decodeObjectForKey:kLoginBaseClassT];
    self.tags = [aDecoder decodeObjectForKey:kLoginBaseClassTags];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_d forKey:kLoginBaseClassD];
    [aCoder encodeObject:_rid forKey:kLoginBaseClassRid];
    [aCoder encodeObject:_ut forKey:kLoginBaseClassUt];
    [aCoder encodeObject:_r forKey:kLoginBaseClassR];
    [aCoder encodeObject:_n forKey:kLoginBaseClassN];
    [aCoder encodeObject:_t forKey:kLoginBaseClassT];
    [aCoder encodeObject:_tags forKey:kLoginBaseClassTags];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginBaseClass *copy = [[LoginBaseClass alloc] init];
    
    if (copy) {

        copy.d = [self.d copyWithZone:zone];
        copy.rid = [self.rid copyWithZone:zone];
        copy.ut = [self.ut copyWithZone:zone];
        copy.r = [self.r copyWithZone:zone];
        copy.n = [self.n copyWithZone:zone];
        copy.t = [self.t copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
    }
    
    return copy;
}


@end
