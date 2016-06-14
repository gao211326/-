//
//  OtherBaseClass.h
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OtherData;

@interface OtherBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) OtherData *data;
@property (nonatomic, strong) NSString *code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
