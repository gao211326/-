//
//  BaseButtonView.m
//  MenuSifu
//
//  Created by 高磊 on 15/5/13.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "BaseButtonView.h"

@interface BaseButtonView ()
{
    UIButton *          _baseButton;
    UILabel *           _baseLable;
}

@end

@implementation BaseButtonView

- (id)initWithButtonNomalImage:(NSString *)nomalImage
                     highImage:(NSString *)highImage
                   buttonTitle:(NSString *)title
                baseButtonType:(BaseButtonType)type
{
    self = [super init];
    if (self) {
        _baseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_baseButton setBackgroundImage:[UIImage imageNamed:nomalImage] forState:UIControlStateNormal];
        [_baseButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
        [_baseButton addTarget:self action:@selector(baseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_baseButton];
        
        _baseLable = [[UILabel alloc]init];
        _baseLable.textAlignment = NSTextAlignmentCenter;
        _baseLable.font = [UIFont systemFontOfSize:12];
        _baseLable.textColor = [UIColor blackColor];
        [self addSubview:_baseLable];
        
        
        if (BaseButtonUserType == type)
        {
            [_baseButton makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.left);
                make.top.equalTo(@0);
                make.size.equalTo(CGSizeMake(29, 29));
            }];
            
            [_baseLable makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_baseButton.top);
                make.left.equalTo(_baseButton.right).offset(10);
                make.right.equalTo(self.right);
                make.height.equalTo(_baseButton.height);
            }];
            
            [_baseLable setTextAlignment:NSTextAlignmentLeft];
        }
        else
        {
            [_baseButton makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.centerX);
                make.top.equalTo(@0);
                make.size.equalTo(CGSizeMake(36, 36));
            }];
            
            [_baseLable makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_baseButton.bottom);
                make.centerX.equalTo(_baseButton.centerX);
                make.width.equalTo(self.width);
                if (BaseButtonFindType == type)
                {
                    make.height.equalTo(@25);
                }
                else if (BaseButtonHomeType == type)
                {
                    make.height.equalTo(@21);
                }
            }];
        }
        
        

        
        _baseLable.text = title;
        
    }
    return self;
}


#pragma mark ==========================================
#pragma mark == button action
#pragma mark ==========================================
- (void)baseButtonClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseButtonViewClick:)])
    {
        [self.delegate baseButtonViewClick:self];
    }
}

@end
