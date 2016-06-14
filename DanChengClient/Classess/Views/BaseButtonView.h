//
//  BaseButtonView.h
//  MenuSifu
//
//  Created by 高磊 on 15/5/13.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BaseButtonType)
{
    BaseButtonHomeType,
    BaseButtonFindType,
    BaseButtonUserType
};

@class BaseButtonView;

@protocol BaseButtonViewDelegate <NSObject>

- (void)baseButtonViewClick:(BaseButtonView *)baseButtonView;

@end

@interface BaseButtonView : UIView

- (id)initWithButtonNomalImage:(NSString *)nomalImage
                     highImage:(NSString *)highImage
                   buttonTitle:(NSString *)title
                baseButtonType:(BaseButtonType)type;

@property (nonatomic,weak)id <BaseButtonViewDelegate>delegate;

@end
