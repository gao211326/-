//
//  HomeViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/13.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "HomeViewController.h"
#import "UserLoginViewController.h"
#import "RepairViewController.h"
#import "RepairRecordViewController.h"
#import "RepairMessageViewController.h"

#import "UserTransaction.h"
#import "UIImage+Extension.h"

#define HOMEVIEW_BACK_COLOR         UICOLOR_FROM_RGB(234, 234, 234)
#define HOMEVIEW_LINE_COLOR         UICOLOR_FROM_RGB(209, 209, 209)


@interface HomeViewController ()
{
    UIButton *          _repairButton;
    UIButton *          _repairRecordButton;
    UIButton *          _repairMessageButton;
    
    UILabel *           _repairLable;
    UILabel *           _repairRecordLable;
    UILabel *           _repairMessageLable;
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xffffff);
    
    [self setNavigateBarBackImage:[UIImage imageWithColor:UICOLOR_FROM_RGB(251, 66, 46) size:CGSizeMake(CURRVIEW_WIDTH, 64)]];
    
    [self setTitleText:[UIFont systemFontOfSize:17] Color:[UIColor whiteColor]];
    [self setTitleTextView:@"海棠花语" selector:@selector(topButtonClick:)];
    
//    [self setLeftBarItemWithImage:@"扫一扫" HighlightImage:nil selector:@selector(leftButtonClick:)];
//    [self setRightBarItemWithImage:@"mag_glass-副本" HighlightImage:nil selector:@selector(rightButtonClick:)];
    
    
    _repairButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_repairButton addTarget:self action:@selector(repairButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_repairButton setImage:[UIImage imageNamed:@"组-1"] forState:UIControlStateNormal];
    [_repairButton setImage:[UIImage imageNamed:@"组-1-拷贝"] forState:UIControlStateHighlighted];
    [self.view addSubview:_repairButton];
    
    
    _repairRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_repairRecordButton addTarget:self action:@selector(repairRecordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_repairRecordButton setImage:[UIImage imageNamed:@"组-2"] forState:UIControlStateNormal];
    [_repairRecordButton setImage:[UIImage imageNamed:@"组-2-拷贝"] forState:UIControlStateHighlighted];
    [self.view addSubview:_repairRecordButton];
    
    
    _repairMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_repairMessageButton addTarget:self action:@selector(repairMessageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_repairMessageButton setImage:[UIImage imageNamed:@"组-3"] forState:UIControlStateNormal];
    [self.view addSubview:_repairMessageButton];
    
    
    _repairLable = [[UILabel alloc]init];
    _repairLable.text = @"在线报修";
    _repairLable.font = [UIFont systemFontOfSize:14];
    _repairLable.textColor = UICOLOR_FROM_RGB_OxFF(0x3c3c3c);
    _repairLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_repairLable];
    
    _repairRecordLable = [[UILabel alloc]init];
    _repairRecordLable.text = @"报修记录";
    _repairRecordLable.font = [UIFont systemFontOfSize:14];
    _repairRecordLable.textColor = UICOLOR_FROM_RGB_OxFF(0x3c3c3c);
    _repairRecordLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_repairRecordLable];
    
    
    _repairMessageLable = [[UILabel alloc]init];
    _repairMessageLable.text = @"我的消息";
    _repairMessageLable.font = [UIFont systemFontOfSize:14];
    _repairMessageLable.textColor = UICOLOR_FROM_RGB_OxFF(0x3c3c3c);
    _repairMessageLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_repairMessageLable];
    
    
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat padding = (size.width - 67 * 3) / 4;
    
    
    [_repairButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(kNavagationBarH);
        make.size.equalTo(CGSizeMake(67, 67));
        make.left.equalTo(self.view.left).offset(padding);
    }];


    [_repairRecordButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(kNavagationBarH);
        make.size.equalTo(CGSizeMake(67, 67));
        make.centerX.equalTo(self.view.centerX);
    }];
    
    
    [_repairMessageButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(kNavagationBarH);
        make.size.equalTo(CGSizeMake(67, 67));
        make.right.equalTo(self.view.right).offset(-padding);
    }];
    
    
    
    [_repairLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_repairButton.centerX);
        make.top.equalTo(_repairButton.bottom).offset(20);
        make.height.equalTo(@15);
        make.width.equalTo(@100);
    }];

    [_repairRecordLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_repairRecordButton.centerX);
        make.top.equalTo(_repairRecordButton.bottom).offset(20);
        make.height.equalTo(@15);
        make.width.equalTo(@100);
    }];
    
    [_repairMessageLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_repairMessageButton.centerX);
        make.top.equalTo(_repairMessageButton.bottom).offset(20);
        make.height.equalTo(@15);
        make.width.equalTo(@100);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ==========================================
#pragma mark == button actions
#pragma mark ==========================================

- (void)topButtonClick:(UIButton *)sender
{

}

- (void)repairButtonClick:(UIButton *)sender
{
    if ([[UserTransaction sharedInstance] currentUser])
    {
        RepairViewController *repairVc = [[RepairViewController alloc]init];
        [self pushController:repairVc withAnimated:YES];
    }
    else
    {
        UserLoginViewController *loginVc = [[UserLoginViewController alloc] init];
        loginVc.fromType = 0;
        [self pushController:loginVc withAnimated:YES];
    }
}

- (void)repairRecordButtonClick:(UIButton *)sender
{
    if ([[UserTransaction sharedInstance] currentUser])
    {
        RepairRecordViewController *repairRecordVc = [[RepairRecordViewController alloc] init];
        [self pushController:repairRecordVc withAnimated:YES];
    }
    else
    {
        UserLoginViewController *loginVc = [[UserLoginViewController alloc] init];
        loginVc.fromType = 1;
        [self pushController:loginVc withAnimated:YES];
    }
}


- (void)repairMessageButtonClick:(UIButton *)sender
{
    if ([[UserTransaction sharedInstance] currentUser])
    {
        RepairMessageViewController *repairMessageVc = [[RepairMessageViewController alloc]init];
        [self pushController:repairMessageVc withAnimated:YES];
    }
    else
    {
        UserLoginViewController *loginVc = [[UserLoginViewController alloc] init];
        loginVc.fromType = 2;
        [self pushController:loginVc withAnimated:YES];
    }
}

@end
