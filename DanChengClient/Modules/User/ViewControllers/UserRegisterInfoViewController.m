//
//  UserRegisterInfoViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/8/25.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "UserRegisterInfoViewController.h"
#import "RepairViewController.h"
#import "RepairRecordViewController.h"

#import "SetInputView.h"
#import "HeadSelectView.h"
#import "ShowMessage.h"

#import "UserTransaction.h"
#import "LoginDataModels.h"

@interface UserRegisterInfoViewController ()
{
    HeadSelectView *        _headSelectView;
    
    SetInputView *          _phoneInputView;
    SetInputView *          _nickNameInputView;
    SetInputView *          _passwordInputView;
    
    UIButton *              _besureButton;
    
    UIActivityIndicatorView *   _activity;
}
@end

@implementation UserRegisterInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xededed);
    
    [self setNavigateBarBackImage:[UIImage imageWithColor:UICOLOR_FROM_RGB(251, 66, 46) size:CGSizeMake(CURRVIEW_WIDTH, 64)]];
    
    [self setTitleText:[UIFont systemFontOfSize:17] Color:[UIColor whiteColor]];
    
    [self setTitleTextView:@"账号信息"];
    
    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    
    [self initViewComponents];
    
    
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
    
    
    [self reloadInputData];
}


#pragma mark == private method
- (void)initViewComponents
{
    _headSelectView = [[HeadSelectView alloc] initWithSelectType:2];
    [self.view addSubview:_headSelectView];
    
    
    _phoneInputView = [[SetInputView alloc] initWithInputType:SetInPutViewInputLeftType];
    [self.view addSubview:_phoneInputView];
    
    _nickNameInputView = [[SetInputView alloc] initWithInputType:SetInPutViewInputLeftType];
    [self.view addSubview:_nickNameInputView];
    
    _passwordInputView = [[SetInputView alloc] initWithInputType:SetInPutViewInputLeftType];
    [_passwordInputView setInputSecret];
    [self.view addSubview:_passwordInputView];
    
    
    
    _besureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录按下"] forState:UIControlStateHighlighted];
    
    [_besureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [_besureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_besureButton addTarget:self action:@selector(besureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_besureButton];
    
    
    [_headSelectView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(8);
        make.height.equalTo(@34);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
    }];
    
    
    [_phoneInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headSelectView.bottom).offset(35);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@49);
    }];
    
    [_nickNameInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneInputView.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@49);
    }];
    
    [_passwordInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameInputView.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@49);
    }];
    
    [_besureButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordInputView.bottom).offset(45);
        make.size.equalTo(CGSizeMake(GTReViewXFloat(587/2), 75/2));
        make.centerX.equalTo(self.view.centerX);
    }];
}

- (void)reloadInputData
{
    [_phoneInputView reloadTitleName:@"手机号" inputName:@"请输入手机号"];
    [_nickNameInputView reloadTitleName:@"昵称   " inputName:@"请输入昵称"];
    [_passwordInputView reloadTitleName:@"密码   " inputName:@"请设定您的初始密码"];
}

#pragma mark == event response

- (void)leftButtonClick:(UIButton *)sender
{
    [self popControllerWithAnimated:YES];
}

- (void)besureButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    NSString *phone = [_phoneInputView getInputText];
    NSString *nickName = [_nickNameInputView getInputText];
    NSString *password = [_passwordInputView getInputText];
    
    
    
    if (![phone isCellPhoneNumber])
    {
        [ShowMessage showMessage:@"请输入正确的手机号"];
        return;
    }
    
    if (nickName.length == 0)
    {
        [ShowMessage showMessage:@"请输入昵称"];
        return;
    }
    
    if (password.length == 0)
    {
        [ShowMessage showMessage:@"请输入密码"];
        return;
    }
    
    [_activity startAnimating];
    
    [self filmobserveTransactionNotificaiton:kRegisterCmd];
    [[UserTransaction sharedInstance] userRegisterWithBuildingCode:self.buildingCode
                                                          roomCode:self.roomNumberCode
                                                              name:self.userName
                                                       icardNumber:self.userIcardNumber nickName:nickName
                                                             phone:phone
                                                          password:password];
}

#pragma mark ==========================================
#pragma mark == request finish
#pragma mark ==========================================
- (void)filmENgineRequestFinished:(FilmResult *)transaction
{
    if ([transaction.command isEqualToString:kRegisterCmd])
    {
        [_activity stopAnimating];
        
        [self filmunobserveTransactionNotificaiton:kRegisterCmd];
        
        if (FilmRequsetSuccess == transaction.status)
        {
            [ShowMessage showMessage:@"注册成功"];
            
            NSString *phone = [_phoneInputView getInputText];
            NSString *password = [_passwordInputView getInputText];
            
            [[UserTransaction sharedInstance] saveUserPhone:phone userPassword:password];
            
            [self filmobserveTransactionNotificaiton:kUserLoginCmd];
            [[UserTransaction sharedInstance] userLogin:phone password:password];
        }
        else
        {
            [ShowMessage showMessage:transaction.data];
        }
    }
    else if ([transaction.command isEqualToString:kUserLoginCmd])
    {
        [_activity stopAnimating];
        
        [self filmunobserveTransactionNotificaiton:kUserLoginCmd];
        
        if (FilmRequsetSuccess == transaction.status)
        {
            [ShowMessage showMessage:@"登录成功"];
            
            LoginBaseClass *loginData = [transaction data];
            
            NSMutableDictionary *userinfo = [NSMutableDictionary dictionary];
            
            if (loginData.n)
            {
                [userinfo setObject:loginData.n forKey:@"username"];
            }
            else
            {
                [userinfo setObject:[_phoneInputView getInputText]  forKey:@"username"];
            }
            
            if (self.fromType == 0)
            {
                RepairRecordViewController *repairRecordVc = [[RepairRecordViewController alloc] init];
                [self pushController:repairRecordVc withAnimated:YES];
            }
            else if (self.fromType == 1)
            {
                RepairViewController *repairVc = [[RepairViewController alloc]init];
                [self pushController:repairVc withAnimated:YES];
            }
        }
        else
        {
            [ShowMessage showMessage:@"登录失败"];
        }
    }
}

@end
