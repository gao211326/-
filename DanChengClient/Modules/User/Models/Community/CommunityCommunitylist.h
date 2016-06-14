//
//  CommunityCommunitylist.h
//
//  Created by 磊 高 on 15/9/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommunityCommunitylist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *communityCode;
@property (nonatomic, strong) NSString *communityName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
