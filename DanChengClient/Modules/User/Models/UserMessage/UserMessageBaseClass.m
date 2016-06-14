//
//  UserMessageBaseClass.m
//
//  Created by 磊 高 on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserMessageBaseClass.h"
#import "UserMessageRows.h"


NSString *const kUserMessageBaseClassPreviousPageAvailable = @"previousPageAvailable";
NSString *const kUserMessageBaseClassIndex = @"index";
NSString *const kUserMessageBaseClassNextPageAvailable = @"nextPageAvailable";
NSString *const kUserMessageBaseClassPageSize = @"pageSize";
NSString *const kUserMessageBaseClassLastPage = @"lastPage";
NSString *const kUserMessageBaseClassTotalPage = @"totalPage";
NSString *const kUserMessageBaseClassMiddlePage = @"middlePage";
NSString *const kUserMessageBaseClassTotalItem = @"totalItem";
NSString *const kUserMessageBaseClassNextPage = @"nextPage";
NSString *const kUserMessageBaseClassPreviousPage = @"previousPage";
NSString *const kUserMessageBaseClassRows = @"rows";
NSString *const kUserMessageBaseClassStartRow = @"startRow";
NSString *const kUserMessageBaseClassFirstPage = @"firstPage";
NSString *const kUserMessageBaseClassEndRow = @"endRow";


@interface UserMessageBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserMessageBaseClass

@synthesize previousPageAvailable = _previousPageAvailable;
@synthesize index = _index;
@synthesize nextPageAvailable = _nextPageAvailable;
@synthesize pageSize = _pageSize;
@synthesize lastPage = _lastPage;
@synthesize totalPage = _totalPage;
@synthesize middlePage = _middlePage;
@synthesize totalItem = _totalItem;
@synthesize nextPage = _nextPage;
@synthesize previousPage = _previousPage;
@synthesize rows = _rows;
@synthesize startRow = _startRow;
@synthesize firstPage = _firstPage;
@synthesize endRow = _endRow;


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
            self.previousPageAvailable = [[self objectOrNilForKey:kUserMessageBaseClassPreviousPageAvailable fromDictionary:dict] boolValue];
            self.index = [[self objectOrNilForKey:kUserMessageBaseClassIndex fromDictionary:dict] doubleValue];
            self.nextPageAvailable = [[self objectOrNilForKey:kUserMessageBaseClassNextPageAvailable fromDictionary:dict] boolValue];
            self.pageSize = [[self objectOrNilForKey:kUserMessageBaseClassPageSize fromDictionary:dict] doubleValue];
            self.lastPage = [[self objectOrNilForKey:kUserMessageBaseClassLastPage fromDictionary:dict] boolValue];
            self.totalPage = [[self objectOrNilForKey:kUserMessageBaseClassTotalPage fromDictionary:dict] doubleValue];
            self.middlePage = [[self objectOrNilForKey:kUserMessageBaseClassMiddlePage fromDictionary:dict] boolValue];
            self.totalItem = [[self objectOrNilForKey:kUserMessageBaseClassTotalItem fromDictionary:dict] doubleValue];
            self.nextPage = [[self objectOrNilForKey:kUserMessageBaseClassNextPage fromDictionary:dict] doubleValue];
            self.previousPage = [[self objectOrNilForKey:kUserMessageBaseClassPreviousPage fromDictionary:dict] doubleValue];
    NSObject *receivedUserMessageRows = [dict objectForKey:kUserMessageBaseClassRows];
    NSMutableArray *parsedUserMessageRows = [NSMutableArray array];
    if ([receivedUserMessageRows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedUserMessageRows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedUserMessageRows addObject:[UserMessageRows modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedUserMessageRows isKindOfClass:[NSDictionary class]]) {
       [parsedUserMessageRows addObject:[UserMessageRows modelObjectWithDictionary:(NSDictionary *)receivedUserMessageRows]];
    }

    self.rows = [NSArray arrayWithArray:parsedUserMessageRows];
            self.startRow = [[self objectOrNilForKey:kUserMessageBaseClassStartRow fromDictionary:dict] doubleValue];
            self.firstPage = [[self objectOrNilForKey:kUserMessageBaseClassFirstPage fromDictionary:dict] boolValue];
            self.endRow = [[self objectOrNilForKey:kUserMessageBaseClassEndRow fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.previousPageAvailable] forKey:kUserMessageBaseClassPreviousPageAvailable];
    [mutableDict setValue:[NSNumber numberWithDouble:self.index] forKey:kUserMessageBaseClassIndex];
    [mutableDict setValue:[NSNumber numberWithBool:self.nextPageAvailable] forKey:kUserMessageBaseClassNextPageAvailable];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kUserMessageBaseClassPageSize];
    [mutableDict setValue:[NSNumber numberWithBool:self.lastPage] forKey:kUserMessageBaseClassLastPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPage] forKey:kUserMessageBaseClassTotalPage];
    [mutableDict setValue:[NSNumber numberWithBool:self.middlePage] forKey:kUserMessageBaseClassMiddlePage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalItem] forKey:kUserMessageBaseClassTotalItem];
    [mutableDict setValue:[NSNumber numberWithDouble:self.nextPage] forKey:kUserMessageBaseClassNextPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.previousPage] forKey:kUserMessageBaseClassPreviousPage];
    NSMutableArray *tempArrayForRows = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rows) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRows addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRows addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRows] forKey:kUserMessageBaseClassRows];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startRow] forKey:kUserMessageBaseClassStartRow];
    [mutableDict setValue:[NSNumber numberWithBool:self.firstPage] forKey:kUserMessageBaseClassFirstPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endRow] forKey:kUserMessageBaseClassEndRow];

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

    self.previousPageAvailable = [aDecoder decodeBoolForKey:kUserMessageBaseClassPreviousPageAvailable];
    self.index = [aDecoder decodeDoubleForKey:kUserMessageBaseClassIndex];
    self.nextPageAvailable = [aDecoder decodeBoolForKey:kUserMessageBaseClassNextPageAvailable];
    self.pageSize = [aDecoder decodeDoubleForKey:kUserMessageBaseClassPageSize];
    self.lastPage = [aDecoder decodeBoolForKey:kUserMessageBaseClassLastPage];
    self.totalPage = [aDecoder decodeDoubleForKey:kUserMessageBaseClassTotalPage];
    self.middlePage = [aDecoder decodeBoolForKey:kUserMessageBaseClassMiddlePage];
    self.totalItem = [aDecoder decodeDoubleForKey:kUserMessageBaseClassTotalItem];
    self.nextPage = [aDecoder decodeDoubleForKey:kUserMessageBaseClassNextPage];
    self.previousPage = [aDecoder decodeDoubleForKey:kUserMessageBaseClassPreviousPage];
    self.rows = [aDecoder decodeObjectForKey:kUserMessageBaseClassRows];
    self.startRow = [aDecoder decodeDoubleForKey:kUserMessageBaseClassStartRow];
    self.firstPage = [aDecoder decodeBoolForKey:kUserMessageBaseClassFirstPage];
    self.endRow = [aDecoder decodeDoubleForKey:kUserMessageBaseClassEndRow];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_previousPageAvailable forKey:kUserMessageBaseClassPreviousPageAvailable];
    [aCoder encodeDouble:_index forKey:kUserMessageBaseClassIndex];
    [aCoder encodeBool:_nextPageAvailable forKey:kUserMessageBaseClassNextPageAvailable];
    [aCoder encodeDouble:_pageSize forKey:kUserMessageBaseClassPageSize];
    [aCoder encodeBool:_lastPage forKey:kUserMessageBaseClassLastPage];
    [aCoder encodeDouble:_totalPage forKey:kUserMessageBaseClassTotalPage];
    [aCoder encodeBool:_middlePage forKey:kUserMessageBaseClassMiddlePage];
    [aCoder encodeDouble:_totalItem forKey:kUserMessageBaseClassTotalItem];
    [aCoder encodeDouble:_nextPage forKey:kUserMessageBaseClassNextPage];
    [aCoder encodeDouble:_previousPage forKey:kUserMessageBaseClassPreviousPage];
    [aCoder encodeObject:_rows forKey:kUserMessageBaseClassRows];
    [aCoder encodeDouble:_startRow forKey:kUserMessageBaseClassStartRow];
    [aCoder encodeBool:_firstPage forKey:kUserMessageBaseClassFirstPage];
    [aCoder encodeDouble:_endRow forKey:kUserMessageBaseClassEndRow];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserMessageBaseClass *copy = [[UserMessageBaseClass alloc] init];
    
    if (copy) {

        copy.previousPageAvailable = self.previousPageAvailable;
        copy.index = self.index;
        copy.nextPageAvailable = self.nextPageAvailable;
        copy.pageSize = self.pageSize;
        copy.lastPage = self.lastPage;
        copy.totalPage = self.totalPage;
        copy.middlePage = self.middlePage;
        copy.totalItem = self.totalItem;
        copy.nextPage = self.nextPage;
        copy.previousPage = self.previousPage;
        copy.rows = [self.rows copyWithZone:zone];
        copy.startRow = self.startRow;
        copy.firstPage = self.firstPage;
        copy.endRow = self.endRow;
    }
    
    return copy;
}


@end
