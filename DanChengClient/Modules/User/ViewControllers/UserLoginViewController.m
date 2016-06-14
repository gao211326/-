//
//  UserLoginViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/16.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UserRegisterViewController.h"
#import "ForgotPasswordViewController.h"
#import "RepairViewController.h"
#import "RepairRecordViewController.h"
#import "RepairMessageViewController.h"

#import "ShowMessage.h"
#import "BaseFieldView.h"

#import "UserTransaction.h"
#import "LoginDataModels.h"

@interface UserLoginViewController ()
{
    BaseFieldView *         _userNameBaseFieldView;
    BaseFieldView *         _passWordBaseFieldView;
    
    UIButton *              _forgotPassButton;
    UIButton *              _loginButton;
    UIButton *              _wechatButton;
    
    UIActivityIndicatorView *   _activity;
}
@end

@implementation UserLoginViewController

- (id)init{
    self = [super init];
    if (self)
    {
        _fromType = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xeeeeee);
    
    [self setNavigateBarBackImage:[UIImage imageWithColor:UICOLOR_FROM_RGB(251, 66, 46) size:CGSizeMake(CURRVIEW_WIDTH, 64)]];
    
    [self setTitleText:[UIFont systemFontOfSize:17] Color:[UIColor whiteColor]];
    [self setTitleTextView:@"登录"];
    
    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    
    [self initViewComponents];
    
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
    
}

- (void)initViewComponents
{
    _userNameBaseFieldView = [[BaseFieldView alloc]initWithHeadImage:@"用户名"
                                                            headName:@"用户"
                                                           fieldText:@"请输入手机号"];
    _userNameBaseFieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_userNameBaseFieldView];
    
    _passWordBaseFieldView = [[BaseFieldView alloc]initWithHeadImage:@"锁"
                                                            headName:@"密码"
                                                           fieldText:@"请输入登录密码"];
    _passWordBaseFieldView.backgroundColor = [UIColor whiteColor];
    [_passWordBaseFieldView secureTextEntry:YES];
    [self.view addSubview:_passWordBaseFieldView];
    
    UIView *_line = [[UIView alloc]init];
    _line.backgroundColor = UICOLOR_FROM_RGB(209, 209, 209);
    [self.view addSubview:_line];
    
    
    _forgotPassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgotPassButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_forgotPassButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_forgotPassButton setTitleColor:UICOLOR_FROM_RGB_OxFF(0xff5838) forState:UIControlStateNormal];
    [_forgotPassButton addTarget:self action:@selector(forgotButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotPassButton];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_loginButton setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
//    [_loginButton setBackgroundImage:[UIImage imageNamed:@"登录按下"] forState:UIControlStateHighlighted];
    [_loginButton setCornerRadius:5];
    _loginButton.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xffae00);
    [_loginButton setTitle:@"确认" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    
    _wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatButton setCornerRadius:5];
    _wechatButton.backgroundColor = UICOLOR_FROM_RGB_OxFF(0x14be96);
    [_wechatButton setTitle:@"和美家用户注册" forState:UIControlStateNormal];
    [_wechatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_wechatButton addTarget:self action:@selector(wechatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatButton];
    
    
    
    [_userNameBaseFieldView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(27);
        make.height.equalTo(@49);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
    }];
    
    [_passWordBaseFieldView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameBaseFieldView.bottom);
        make.height.equalTo(_userNameBaseFieldView.height);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
    }];
    
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passWordBaseFieldView.bottom);
        make.height.equalTo(@0.5);
        make.width.equalTo(_passWordBaseFieldView.width);
        make.left.equalTo(_passWordBaseFieldView.left);
    }];
    
    
    [_forgotPassButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(GTReViewXFloat(85), 25));
        make.top.equalTo(_line.bottom).offset(7);
        make.right.equalTo(self.view.right);
    }];
    
    
    [_loginButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_forgotPassButton.bottom).offset(11.5);
        make.size.equalTo(CGSizeMake(GTReViewXFloat(587/2), 75/2));
        make.centerX.equalTo(self.view.centerX);
    }];
    
    [_wechatButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginButton.bottom).offset(35);
        make.size.equalTo(CGSizeMake(GTReViewXFloat(587/2), 75/2));
        make.centerX.equalTo(self.view.centerX);
    }];
    
    
    NSString *phone = [[UserTransaction sharedInstance] userEmail];
    NSString *password = [[UserTransaction sharedInstance] userPassword];
    
    if (phone && password)
    {
        [_userNameBaseFieldView reloadInputText:phone];
        
        [_passWordBaseFieldView reloadInputText:password];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark ==========================================
#pragma mark == button actions
#pragma mark ==========================================

- (void)leftButtonClick:(UIButton *)sender
{
    [self popControllerWithAnimated:YES];
}

//- (void)rightButtonClick:(UIButton *)sender
//{
//    UserRegisterViewController *registerVc = [[UserRegisterViewController alloc]initWithRegisterType:RegisterVcType];
//    registerVc.hidesBottomBarWhenPushed = YES;
//    [self pushController:registerVc withAnimated:YES];
//}

- (void)forgotButtonClick:(UIButton *)sender
{
    ForgotPasswordViewController *forgotVc = [[ForgotPasswordViewController alloc]initWithRegisterType:ForgotVcType];
    [self pushController:forgotVc withAnimated:YES];
}

- (void)loginButtonClick:(UIButton *)sender
{
    NSString *userName = [_userNameBaseFieldView getInputText];
    NSString *password = [_passWordBaseFieldView getInputText];
    
    if (![userName isCellPhoneNumber])
    {
        [ShowMessage showMessage:@"请输入正确的手机号"];
        return;
    }
    
    if (password.length <= 0)
    {
        [ShowMessage showMessage:@"请输入密码"];
        return;
    }
    
    [[UserTransaction sharedInstance] saveUserPhone:userName userPassword:password];
    
    [_activity startAnimating];
    
    [self filmobserveTransactionNotificaiton:kUserLoginCmd];
    [[UserTransaction sharedInstance]userLogin:[_userNameBaseFieldView getInputText]
                                      password:[_passWordBaseFieldView getInputText]];
}

- (void)wechatButtonClick:(UIButton *)sender
{
    //注册
    UserRegisterViewController *registerVc = [[UserRegisterViewController alloc]init];
    [self pushController:registerVc withAnimated:YES];
}

#pragma mark ==========================================
#pragma mark == request finish
#pragma mark ==========================================
- (void)filmENgineRequestFinished:(FilmResult *)transaction
{
    if ([transaction.command isEqualToString:kUserLoginCmd])
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
                [userinfo setObject:[_userNameBaseFieldView getInputText]  forKey:@"username"];
            }
            
            
            if (self.fromType == 0)
            {
                RepairViewController *repairVc = [[RepairViewController alloc]init];
                [self pushController:repairVc withAnimated:YES];
            }
            else if (self.fromType == 1)
            {
                RepairRecordViewController *repairRecordVc = [[RepairRecordViewController alloc] init];
                [self pushController:repairRecordVc withAnimated:YES];
            }
            else if (self.fromType == 2)
            {
                RepairMessageViewController *repairMessageVc = [[RepairMessageViewController alloc]init];
                [self pushController:repairMessageVc withAnimated:YES];
            }
            
//            [self postNotification:@"kuserlogin" userInfo:userinfo];
        }
        else
        {
            [ShowMessage showMessage:@"登录失败"];
        }
    }
}

@end
