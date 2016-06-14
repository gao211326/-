//
//  OtherList.h
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OtherList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id updateDate;
@property (nonatomic, assign) id createBy;
@property (nonatomic, assign) double listIdentifier;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) id parentName;
@property (nonatomic, assign) id updateBy;
@property (nonatomic, strong) NSString *orderIndex;
@property (nonatomic, assign) id createDate;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *parentCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
