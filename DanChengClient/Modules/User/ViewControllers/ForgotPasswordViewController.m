//
//  UserRegisterViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/16.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "BaseFieldView.h"
#import "ShowMessage.h"

#import "UserTransaction.h"
#import "LoginDataModels.h"

#import <SMS_SDK/SMS_SDK.h>

@interface ForgotPasswordViewController ()
{
    BaseFieldView *         _phoneBaseFieldView;
    BaseFieldView *         _passWordBaseFieldView;
    BaseFieldView *         _validationBaseFieldView;
    UIButton *              _agreeButton;
    UILabel *               _agreeLable;
    UIButton *              _besureButton;
    UIButton *              _getValidation;
    
    UIActivityIndicatorView *   _activity;
}
@end

@implementation ForgotPasswordViewController

- (id)initWithRegisterType:(RegisterType)type
{
    self = [super init];
    if (self) {
        self.registerVcType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_FROM_RGB(234, 234, 234);
    
    [self setNavigateBarBackImage:[UIImage imageWithColor:UICOLOR_FROM_RGB(251, 66, 46) size:CGSizeMake(CURRVIEW_WIDTH, 64)]];
    
    [self setTitleText:[UIFont systemFontOfSize:17] Color:[UIColor whiteColor]];
    
    [self setTitleTextView:@"找回密码"];

    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    
    [self initViewComponents];
    
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
}

- (void)initViewComponents
{
    _phoneBaseFieldView = [[BaseFieldView alloc]initWithHeadImage:@"用户名"
                                                            headName:@"手机号"
                                                           fieldText:@"请输入手机号"];
    _phoneBaseFieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_phoneBaseFieldView];
    
    _passWordBaseFieldView = [[BaseFieldView alloc]initWithHeadImage:@"锁"
                                                            headName:@"密码"
                                                           fieldText:@"不少于6位"];
    _passWordBaseFieldView.backgroundColor = [UIColor whiteColor];
    [_passWordBaseFieldView secureTextEntry:YES];
    [self.view addSubview:_passWordBaseFieldView];
    
    
    _validationBaseFieldView = [[BaseFieldView alloc]initWithHeadImage:@"验证"
                                                            headName:@"验证码"
                                                           fieldText:@"请输入验证码"];
    _validationBaseFieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_validationBaseFieldView];
    
    
    _getValidation = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getValidation.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_getValidation setBackgroundImage:[UIImage imageNamed:@"获取验证码"] forState:UIControlStateNormal];
    [_getValidation setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getValidation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getValidation addTarget:self action:@selector(getValidationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_validationBaseFieldView addSubview:_getValidation];
    
    
    
    UIView *_line = [[UIView alloc]init];
    _line.backgroundColor = UICOLOR_FROM_RGB(209, 209, 209);
    [self.view addSubview:_line];
    
    
    
    _besureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录按下"] forState:UIControlStateHighlighted];
    
    [_besureButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [_besureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_besureButton addTarget:self action:@selector(besureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_besureButton];
    
    
    
    
    [_phoneBaseFieldView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(27);
        make.height.equalTo(@49);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
    }];
    
    [_passWordBaseFieldView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneBaseFieldView.bottom);
        make.height.equalTo(_phoneBaseFieldView.height);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
    }];
    
    [_validationBaseFieldView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passWordBaseFieldView.bottom);
        make.height.equalTo(_phoneBaseFieldView.height);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
    }];
    
    
    [_getValidation makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(155/2, 63/2));
        make.right.equalTo(_validationBaseFieldView.right).offset(-7);
        make.centerY.equalTo(_validationBaseFieldView.centerY);
    }];
    
    
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_validationBaseFieldView.bottom);
        make.height.equalTo(@0.5);
        make.width.equalTo(_validationBaseFieldView.width);
        make.left.equalTo(_validationBaseFieldView.left);
    }];
    
    

    [_besureButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_validationBaseFieldView.bottom).offset(33);
        make.size.equalTo(CGSizeMake(GTReViewXFloat(587/2), 75/2));
        make.centerX.equalTo(self.view.centerX);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ==========================================
#pragma mark == button actions
#pragma mark ==========================================

- (void)leftButtonClick:(UIButton *)sender
{
    [self popControllerWithAnimated:YES];
}

- (void)getValidationButtonClick:(UIButton *)sender
{
    if (![self validatePhoneNum:[_phoneBaseFieldView getInputText]])
    {
        [ShowMessage showMessage:@"请输入正确的手机号"];
    }
    else
    {
        [SMS_SDK getVerificationCodeBySMSWithPhone:[_phoneBaseFieldView getInputText]
                                              zone:@"86"
                                            result:^(SMS_SDKError *error) {
                                                if (!error)
                                                {
                                                    [ShowMessage showMessage:@"验证码发送成功"];
                                                }
                                                else
                                                {
                                                    [ShowMessage showMessage:@"获取验证码失败"];
//                                                    [ShowMessage showMessage:error.description];
                                                }
            
        }];
    }
}

- (void)arrgeButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)besureButtonClick:(UIButton *)sender
{
    if (![[_phoneBaseFieldView getInputText] isCellPhoneNumber])
    {
        [ShowMessage showMessage:@"请输入正确的手机号"];
        return;
    }
    
    if ([_validationBaseFieldView getInputText].length <= 0)
    {
        [ShowMessage showMessage:@"请输入验证码"];
        return;
    }
    
    if ([_passWordBaseFieldView getInputText].length <= 0)
    {
        [ShowMessage showMessage:@"请输入您的新密码"];
        return;
    }
    
    [_activity startAnimating];
    
    [self filmobserveTransactionNotificaiton:kUserForgotPasswordCmd];
    
    [[UserTransaction sharedInstance]userForgotPassword:[_phoneBaseFieldView getInputText]
                                               password:[_passWordBaseFieldView getInputText]
                                           validateCode:[_validationBaseFieldView getInputText]];
    
    //        [SMS_SDK commitVerifyCode:[_validationBaseFieldView getInputText] result:^(enum SMS_ResponseState state) {
    //            if (1==state)
    //            {
    //                NSLog(@"验证成功");
    //
    //                [self filmobserveTransactionNotificaiton:kUserForgotPasswordCmd];
    //                [[UserTransaction sharedInstance]userForgotPassword:[_phoneBaseFieldView getInputText]
    //                                                           password:[_passWordBaseFieldView getInputText]
    //                                                       validateCode:[_validationBaseFieldView getInputText]];
    //            }
    //            else if(0==state)
    //            {
    //                NSLog(@"验证失败");
    //                [ShowMessage showMessage:@"验证码错误"];
    //            }
    //        }];
}

#pragma mark ==========================================
#pragma mark == request finish
#pragma mark ==========================================
- (void)filmENgineRequestFinished:(FilmResult *)transaction
{
    if ([transaction.command isEqualToString:kUserForgotPasswordCmd])
    {
        [_activity stopAnimating];
        
        [self filmunobserveTransactionNotificaiton:kUserForgotPasswordCmd];
        
        if (FilmRequsetSuccess == transaction.status)
        {
            [ShowMessage showMessage:@"修改成功"];
            
            [self popControllerWithAnimated:YES];
        }
        else
        {
            [ShowMessage showMessage:transaction.data];
        }
    }
}
@end
