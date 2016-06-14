//
//  HeadSelectView.m
//  DanChengClient
//
//  Created by 高磊 on 15/8/25.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "HeadSelectView.h"

@interface HeadSelectView ()
{
    UIButton *              _houseLable;
    UIButton *              _icardLable;
    UIButton *              _numberLable;
}
@end

@implementation HeadSelectView


- (id)initWithSelectType:(int)type
{
    self = [super init];
    if (self) {
        _houseLable = [UIButton buttonWithType:UIButtonTypeCustom];
        _houseLable.titleLabel.font = [UIFont systemFontOfSize:13];
        [_houseLable setTitle:@"房屋信息:" forState:UIControlStateNormal];
        _houseLable.userInteractionEnabled = NO;
        [self addSubview:_houseLable];
        
        
        
        _icardLable = [UIButton buttonWithType:UIButtonTypeCustom];
        _icardLable.titleLabel.font = [UIFont systemFontOfSize:13];
        [_icardLable setTitle:@"身份信息" forState:UIControlStateNormal];
        _icardLable.userInteractionEnabled = NO;
        [self addSubview:_icardLable];
        
        
        
        _numberLable = [UIButton buttonWithType:UIButtonTypeCustom];
        _numberLable.titleLabel.font = [UIFont systemFontOfSize:13];
        [_numberLable setTitle:@"账号信息" forState:UIControlStateNormal];
        _numberLable.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _numberLable.userInteractionEnabled = NO;
        [self addSubview:_numberLable];
        
        
        
        if (type == 0)
        {
            [_houseLable setBackgroundImage:[UIImage imageNamed:@"1-anxia"] forState:UIControlStateNormal];
            [_icardLable setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
            [_numberLable setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        }
        else if (type == 1)
        {
            [_houseLable setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
            [_icardLable setBackgroundImage:[UIImage imageNamed:@"3anxia"] forState:UIControlStateNormal];
            [_numberLable setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        }
        else if (type == 2)
        {
            [_houseLable setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
            [_icardLable setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
            [_numberLable setBackgroundImage:[UIImage imageNamed:@"3-anxia"] forState:UIControlStateNormal];
        }
       
        
        
        [self makeViewConstraint];
    }
    return self;
}

- (void)makeViewConstraint
{
    [_houseLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left).offset(GTReViewXFloat(6.5));
        make.size.equalTo(CGSizeMake(GTReViewXFloat(107), 34));
    }];
    
    [_icardLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_houseLable.top);
        make.height.equalTo(@34);
        make.left.equalTo(_houseLable.right).offset(-GTReViewXFloat(15));
        make.right.equalTo(_numberLable.left).offset(GTReViewXFloat(15));
    }];
    
    [_numberLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_houseLable.top);
        make.right.equalTo(self.right).offset(-GTReViewXFloat(6.5));
        make.size.equalTo(CGSizeMake(GTReViewXFloat(102), 34));
    }];
}



@end
