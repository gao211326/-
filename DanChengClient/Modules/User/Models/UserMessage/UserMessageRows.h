//
//  UserMessageRows.h
//
//  Created by 磊 高 on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserMessageRows : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double orderId;
@property (nonatomic, strong) NSString *repairUserPhone;
@property (nonatomic, assign) double rowsIdentifier;
@property (nonatomic, assign) BOOL readed;
@property (nonatomic, assign) double repairUserId;
@property (nonatomic, strong) NSString *createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
