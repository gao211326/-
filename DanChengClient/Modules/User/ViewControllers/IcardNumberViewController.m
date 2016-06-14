//
//  IcardNumberViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/8/24.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "IcardNumberViewController.h"
#import "UserRegisterInfoViewController.h"

#import "SetInputView.h"
#import "HeadSelectView.h"
#import "ShowMessage.h"


@interface IcardNumberViewController ()
{
    HeadSelectView *        _headSelectView;
    
    SetInputView *          _nameInputView;
    SetInputView *          _icardNumberInputView;
    
    UIButton *              _besureButton;
}
@end

@implementation IcardNumberViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xededed);
    
    [self setNavigateBarBackImage:[UIImage imageWithColor:UICOLOR_FROM_RGB(251, 66, 46) size:CGSizeMake(CURRVIEW_WIDTH, 64)]];
    
    [self setTitleText:[UIFont systemFontOfSize:17] Color:[UIColor whiteColor]];
    
    [self setTitleTextView:@"身份信息"];
    
    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    
    [self initViewComponents];
    
    [self reloadInputData];
}


#pragma mark == private method
- (void)initViewComponents
{
    _headSelectView = [[HeadSelectView alloc] initWithSelectType:1];
    [self.view addSubview:_headSelectView];
    
    
    _nameInputView = [[SetInputView alloc] initWithInputType:SetInPutViewInputLeftType];
    [self.view addSubview:_nameInputView];
    
    _icardNumberInputView = [[SetInputView alloc] initWithInputType:SetInPutViewInputLeftType];
    [self.view addSubview:_icardNumberInputView];
    
    
    
    _besureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录按下"] forState:UIControlStateHighlighted];
    
    [_besureButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [_besureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_besureButton addTarget:self action:@selector(besureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_besureButton];
    
    
    [_headSelectView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(8);
        make.height.equalTo(@34);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
    }];
    
    
    [_nameInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headSelectView.bottom).offset(35);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@49);
    }];
    
    [_icardNumberInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameInputView.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@49);
    }];
    
    [_besureButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icardNumberInputView.bottom).offset(45);
        make.size.equalTo(CGSizeMake(GTReViewXFloat(587/2), 75/2));
        make.centerX.equalTo(self.view.centerX);
    }];
}

- (void)reloadInputData
{
    [_nameInputView reloadTitleName:@"姓名       " inputName:@"请输入您的姓名"];
    [_icardNumberInputView reloadTitleName:@"身份证号" inputName:@"请输入您的身份证编号"];
}

#pragma mark == event response

- (void)leftButtonClick:(UIButton *)sender
{
    [self popControllerWithAnimated:YES];
}

- (void)besureButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    NSString *name = [_nameInputView getInputText];
    NSString *icardNumber = [_icardNumberInputView getInputText];
    
    if (name.length <= 0)
    {
        [ShowMessage showMessage:@"请输入您的姓名"];
        return;
    }
    
    if (![icardNumber validateIdentityCard])
    {
        [ShowMessage showMessage:@"请输入正确的身份证信息"];
        return;
    }
    
    UserRegisterInfoViewController *registerInfoVc = [[UserRegisterInfoViewController alloc] init];
    registerInfoVc.buildingCode = self.buildingCode;
    registerInfoVc.roomNumberCode = self.roomNumberCode;
    registerInfoVc.userName = name;
    registerInfoVc.userIcardNumber = icardNumber;
    [self pushController:registerInfoVc withAnimated:YES];
}



@end
