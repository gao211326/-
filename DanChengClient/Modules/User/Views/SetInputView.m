//
//  SetIputView.m
//  BaishitongClient
//
//  Created by 高磊 on 15/7/29.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "SetInputView.h"


@interface SetInputView ()
{
    UILabel *       _titleNameLable;
    UITextField *   _inputField;
    
    UILabel *       _desLable;
    UIImageView *   _rightImageView;
    
    UIView*         _line;
}
@end


@implementation SetInputView

- (id)initWithInputType:(SetInputViewType)inputType
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.inputType = inputType;
        
        _titleNameLable = [[UILabel alloc]init];
        _titleNameLable.textColor = UICOLOR_FROM_RGB_OxFF(0x525252);
        _titleNameLable.font = [UIFont systemFontOfSize:14];
        _titleNameLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:_titleNameLable];
        
        _inputField = [[UITextField alloc]init];
        _inputField.textColor = UICOLOR_FROM_RGB_OxFF(0x333333);
        _inputField.font = [UIFont systemFontOfSize:14];
        [self addSubview:_inputField];
        
        
        if (inputType == SetInPutViewNotInputType)
        {
            
            _desLable = [[UILabel alloc]init];
            _desLable.textColor = UICOLOR_FROM_RGB_OxFF(0x646464);
            _desLable.font = [UIFont systemFontOfSize:14];
            _desLable.textAlignment = NSTextAlignmentRight;
            [self addSubview:_desLable];
            
            _rightImageView = [[UIImageView alloc]init];
            [_rightImageView setImage:[UIImage imageNamed:@"next"]];
            [self addSubview:_rightImageView];
            
            
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            
            [self addGestureRecognizer:tap];
        }
        
        if (inputType == SetInPutViewInputLeftType)
        {
            _titleNameLable.textAlignment = NSTextAlignmentLeft;
        }
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xe9e9e9);
        [self addSubview:_line];
        
        [self makeViewConstraint];
    }
    return self;
}


#pragma mark == event response
- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    [self endEditing:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setInputViewTap:)])
    {
        [self.delegate setInputViewTap:self];
    }
}


#pragma mark == private method
- (void)makeViewConstraint
{
    if (self.inputType == SetInPutViewNotInputType)
    {
        [_rightImageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(17/2, 31/2));
            make.right.equalTo(self.right).equalTo(-13);
            make.centerY.equalTo(self.centerY);
        }];
    }

    
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.width);
        make.height.equalTo(@1);
        make.left.equalTo(self.left);
        make.bottom.equalTo(self.bottom);
    }];
}

#pragma mark == public method

- (NSString *)getInputText
{
    return _inputField.text;
}

- (NSString *)getInputLable
{
    return _desLable.text;
}

- (void)setInputFieldEnable:(BOOL)enable
{
    [_inputField setEnabled:enable];
}

- (void)setInputSecret
{
    _inputField.secureTextEntry = YES;
}

- (void)reloadTitleName:(NSString *)title inputName:(NSString *)inputName
{
    if (self.inputType == SetInPutViewInputType || self.inputType == SetInPutViewInputLeftType)
    {
        [_titleNameLable setText:title];
        [_inputField setPlaceholder:inputName];
        
        
        float titleW = [_titleNameLable.text getDrawWidthWithFont:[UIFont systemFontOfSize:14]];
        
        [_titleNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(17);
            make.height.equalTo(self.height);
            make.width.equalTo(@(titleW));
            make.top.equalTo(self.top);
        }];
        
        
        [_inputField makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleNameLable.right).offset(17);
            make.height.equalTo(_titleNameLable.height);
            make.right.equalTo(self.right).offset(-17);
            make.top.equalTo(self.top);
        }];
    }
    else
    {
        [_titleNameLable setText:title];
        [_desLable setText:inputName];
        
        float titleW = [_titleNameLable.text getDrawWidthWithFont:[UIFont systemFontOfSize:14]];
        
        [_titleNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(17);
            make.height.equalTo(self.height);
            make.width.equalTo(@(titleW));
            make.top.equalTo(self.top);
        }];
        
        
        [_desLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleNameLable.right).offset(17);
            make.height.equalTo(_titleNameLable.height);
            make.right.equalTo(_rightImageView.left);
            make.top.equalTo(self.top);
        }];
    }
}

- (void)reloadTitleName:(NSString *)title inputNomalName:(NSString *)inputNomalName
{
    if (self.inputType == SetInPutViewInputType || self.inputType == SetInPutViewInputLeftType)
    {
        [_titleNameLable setText:title];
        [_inputField setText:inputNomalName];
        
        
        float titleW = [_titleNameLable.text getDrawWidthWithFont:[UIFont systemFontOfSize:14]];
        
        [_titleNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(17);
            make.height.equalTo(self.height);
            make.width.equalTo(@(titleW));
            make.top.equalTo(self.top);
        }];
        
        
        [_inputField makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleNameLable.right).offset(17);
            make.height.equalTo(_titleNameLable.height);
            make.right.equalTo(self.right).offset(-17);
            make.top.equalTo(self.top);
        }];
    }
    else
    {
        [_titleNameLable setText:title];
        [_desLable setText:inputNomalName];
        
        float titleW = [_titleNameLable.text getDrawWidthWithFont:[UIFont systemFontOfSize:14]];
        
        [_titleNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(17);
            make.height.equalTo(self.height);
            make.width.equalTo(@(titleW));
            make.top.equalTo(self.top);
        }];
        
        
        [_desLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleNameLable.right).offset(17);
            make.height.equalTo(_titleNameLable.height);
            make.right.equalTo(_rightImageView.left).offset(-10);
            make.top.equalTo(self.top);
        }];
    }
}

@end
