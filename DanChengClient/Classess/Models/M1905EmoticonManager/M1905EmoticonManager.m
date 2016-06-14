//
//  M1905EmoticonManager.m
//  Dingding
//
//  Created by 陈欢 on 14-2-25.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "M1905EmoticonManager.h"

@interface M1905EmoticonManager()
{
    NSString        *_emoticonConfigPath;
    NSArray         *_emoticon;
    NSMutableArray  *_emoticonGroupNameList;
}
@end

@implementation M1905EmoticonManager

MENUSIFU_SYNTHESIZE_SINGLETON_FOR_CLASS(M1905EmoticonManager)

- (id)init {
    if (instance == nil)
    {
        if (self = [super init])
        {
            instance = self;
        }
    }
    return instance;
}

#pragma mark ==========================================
#pragma mark ==getter
#pragma mark ==========================================
- (NSString *)emojiConfigPath {
    if (_emoticonConfigPath == nil) {
        _emoticonConfigPath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"plist"];
    }
    return _emoticonConfigPath;
}

- (NSArray *)emoji {
    if (_emoticon == nil) {
        _emoticon = [[NSArray alloc] initWithContentsOfFile:[self emojiConfigPath]];
    }
    return _emoticon;
}

- (NSArray *)emoticonGroupNameList {
    if (_emoticonGroupNameList == nil) {
        _emoticonGroupNameList = [[NSMutableArray alloc] init];
        for (int i=0; i<[self emoji].count; i++)
        {
            [_emoticonGroupNameList addObject:[[self emoticonGroupInfoAtIndex:i] objectForKey:kEmoticonImageTitle]];
        }
    }
    return _emoticonGroupNameList;
}

#pragma mark ==========================================
#pragma mark ==internal function
#pragma mark ==========================================
- (NSDictionary *)emoticonGroupInfoAtIndex:(NSUInteger)index {
    return [[self emoji] objectAtIndex:index];
}

#pragma mark ==========================================
#pragma mark ==public function
#pragma mark ==========================================
- (NSString *)emoticonPathWithTitle:(NSString *)title {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSArray *items = [(NSDictionary *)evaluatedObject objectForKey:@"Items"];
        
        NSPredicate *subPredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[evaluatedObject objectForKey:@"Title"] isEqualToString:title]) {
                return YES;
            }
            return NO;
        }];
        
        NSArray *results = [items filteredArrayUsingPredicate:subPredicate];
        
        if (results != nil && results.count > 0) {
            return YES;
        }
        return NO;
    }];
    
    
    NSArray *results = [[self emoji] filteredArrayUsingPredicate:predicate];
    
    if (results != nil && results.count > 0) {
        NSDictionary *emoticonGroup = [results objectAtIndex:0];
        NSString *groupTitle = [emoticonGroup objectForKey:@"Title"];
        NSArray *items = [emoticonGroup objectForKey:@"Items"];
        
        items = [items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Title==%@", title]];
        
        if (items != nil && items.count > 0) {
            NSDictionary *item = [items objectAtIndex:0];
            
            NSString *imageName = [item objectForKey:@"ImageName"];
            
            NSString *filepath = [NSString stringWithFormat:@"%@/Emoticons.bundle/%@/%@", [[NSBundle mainBundle] bundlePath], groupTitle, imageName];
            
            return filepath;
        }
        
    }
    
    return nil;
}

- (UIImage *)emoticonImageWithGroupTitle:(NSString *)groupTitle ImageName:(NSString *)imageName
{
    NSString *filepath = [NSString stringWithFormat:@"%@/Emoticons.bundle/%@/%@", [[NSBundle mainBundle] bundlePath], groupTitle, imageName];
    return [UIImage imageWithContentsOfFile:filepath];
}

@end
