//
//  SetIputView.h
//  BaishitongClient
//
//  Created by 高磊 on 15/7/29.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SetInPutViewInputType,
    SetInPutViewNotInputType,
    SetInPutViewInputLeftType,
} SetInputViewType;

@class SetInputView;
@protocol SetInputViewDelegate <NSObject>

@optional

- (void)setInputViewTap:(SetInputView *)inputView;

@end

@interface SetInputView : UIView

- (id)initWithInputType:(SetInputViewType)inputType;

@property (nonatomic,weak)id <SetInputViewDelegate>delegate;

@property (nonatomic,assign)SetInputViewType inputType;

@property (nonatomic,strong) NSString *areaId;

/**
 *  设置默认值
 *
 *  @param title
 *  @param inputName 灰色给用户提示输入信息
 */
- (void)reloadTitleName:(NSString *)title inputName:(NSString *)inputName;

/**
 *  设置默认值
 *
 *  @param title
 *  @param inputNomalName
 */
- (void)reloadTitleName:(NSString *)title inputNomalName:(NSString *)inputNomalName;

- (void)setInputFieldEnable:(BOOL)enable;

- (void)setInputSecret;
- (NSString *)getInputText;
- (NSString *)getInputLable;
@end
