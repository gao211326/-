//
//  M1905EmoticonManager.h
//  Dingding
//
//  Created by 陈欢 on 14-2-25.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kEmoticonGroupTitle    @"Title"
#define kEmoticonGroupItem     @"Items"
#define kEmoticonImageTitle    @"Title"
#define kEmoticonImageName     @"ImageName"
#define kEmoticonImageURL      @"URL"

#define EmotionImageWidth   (15.0f)

@interface M1905EmoticonManager : NSObject

MENUSIFU_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(M1905EmoticonManager)

- (NSArray *)emoji;
- (NSString *)emoticonPathWithTitle:(NSString *)title;
- (UIImage *)emoticonImageWithGroupTitle:(NSString *)groupTitle ImageName:(NSString *)imageName;
@end
