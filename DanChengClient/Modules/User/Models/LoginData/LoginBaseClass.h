//
//  LoginBaseClass.h
//
//  Created by 磊 高 on 15/6/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *d;
@property (nonatomic, strong) NSString *rid;
@property (nonatomic, strong) NSString *ut;
@property (nonatomic, strong) NSString *r;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSArray *tags;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
