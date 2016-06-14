//
//  UserMessageBaseClass.h
//
//  Created by 磊 高 on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserMessageBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL previousPageAvailable;
@property (nonatomic, assign) double index;
@property (nonatomic, assign) BOOL nextPageAvailable;
@property (nonatomic, assign) double pageSize;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, assign) double totalPage;
@property (nonatomic, assign) BOOL middlePage;
@property (nonatomic, assign) double totalItem;
@property (nonatomic, assign) double nextPage;
@property (nonatomic, assign) double previousPage;
@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) double startRow;
@property (nonatomic, assign) BOOL firstPage;
@property (nonatomic, assign) double endRow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
