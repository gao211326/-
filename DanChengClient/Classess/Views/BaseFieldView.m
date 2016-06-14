//
//  BaseFieldView.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/16.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "BaseFieldView.h"


@interface BaseFieldView ()
{
    UIView *                _line;
    UIImageView *           _headImageView;
    UITextField *           _inputField;
    UILabel *               _tipNameLable;
}
@end

@implementation BaseFieldView

- (id)initWithHeadImage:(NSString *)headImage
               headName:(NSString *)headname
              fieldText:(NSString *)fieldtext
{
    self = [super init];
    if (self) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UICOLOR_FROM_RGB(209, 209, 209);
        [self addSubview:_line];
        
        
        _headImageView = [[UIImageView alloc]init];
        _headImageView.image = [UIImage imageNamed:headImage];
        [self addSubview:_headImageView];
        
        
        _tipNameLable = [[UILabel alloc]init];
        _tipNameLable.text = headname;
        _tipNameLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:_tipNameLable];
        
        
        _inputField = [[UITextField alloc]init];
        _inputField.placeholder = fieldtext;
        _inputField.font = [UIFont systemFontOfSize:14];
        [self addSubview:_inputField];
        
        [_line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.top.equalTo(self.top);
            make.height.equalTo(@0.5);
        }];
        
        [_headImageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(17, 17));
            make.centerY.equalTo(self.centerY);
            make.left.equalTo(@9);
        }];
        
        [_tipNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.right).offset(6);
            make.width.equalTo(@49);
            make.centerY.equalTo(_headImageView.centerY);
            make.height.equalTo(self.height);
        }];
        
        [_inputField makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tipNameLable.right);
            make.right.equalTo(self.right).offset(-9);
            make.height.equalTo(_tipNameLable.height);
            make.centerY.equalTo(self.centerY);
        }];
    }
    
    return self;
}

- (void)reloadInputText:(NSString *)inputText
{
    _inputField.text = inputText;
}

- (NSString *)getInputText
{
    return _inputField.text;
}

- (void)secureTextEntry:(BOOL)secure
{
    [_inputField setSecureTextEntry:secure];
}

@end
