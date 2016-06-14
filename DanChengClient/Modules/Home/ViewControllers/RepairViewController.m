//
//  RepairViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/8/24.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "RepairViewController.h"
#import "RepairView.h"
#import "ShowMessage.h"
#import "UserTransaction.h"
#import "RepairManDataModels.h"

@interface RepairViewController ()
{
    RepairView *                _repairView;
    
    RepairManBaseClass *        _repariData;

    UIActivityIndicatorView *   _activity;
}
@end

@implementation RepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xeeeeee);
    
    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    [self setRightBarItemWithTitle:@"提交" selector:@selector(repairButtonClick:)];
    
    [self setTitleTextView:@"在线报修"];
    
    
    _repairView = [[RepairView alloc] init];
    [self.view addSubview:_repairView];
    
    [_repairView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
    
    [_activity startAnimating];
    
    [self filmobserveTransactionNotificaiton:kUserRepairMansCmd];
    [[UserTransaction sharedInstance] userGetRepairMans];
}


#pragma mark == event response

- (void)leftButtonClick:(UIButton *)sender
{
//    [self popControllerWithAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)repairButtonClick:(UIButton *)sender
{
    NSString *content = [_repairView getContentText];
    NSMutableArray *imageArray = [_repairView getImageArray];
    NSString *phone = [[UserTransaction sharedInstance] userEmail];
    
    if (content.length <= 0)
    {
        [ShowMessage showMessage:@"请输入报修内容"];
        return;
    }
    
    if (!_repairView.startTimeString)
    {
        [ShowMessage showMessage:@"请选择预约维修时间"];
        return;
    }
    
    
    if (!_repairView.endTimeString)
    {
        [ShowMessage showMessage:@"请选择维修完成时间"];
        return;
    }

    
    if (!_repairView.selected)
    {
        [ShowMessage showMessage:@"请选择维修人员"];
        return;
    }
    
    if (imageArray.count <= 0)
    {
        [ShowMessage showMessage:@"请至少提供一张照片"];
        return;
    }
    
    
    [_activity startAnimating];
    
    [self filmobserveTransactionNotificaiton:kUserRepairCmd];

    
    [[UserTransaction sharedInstance] postImage:@"http://182.150.24.137:8089/crm/api/repair/applyForRepair.do"
                                    WithContent:content
                                      startTime:_repairView.startTimeString
                                        endTime:_repairView.endTimeString
                                        picture:imageArray
                                          phone:phone
                                    repairManId:_repairView.repairId
                                     requestCmd:kUserRepairCmd];
}


#pragma mark == request finish

- (void)filmENgineRequestFinished:(FilmResult *)transaction
{
    if ([transaction.command isEqualToString:kUserRepairCmd])
    {
        [self filmunobserveTransactionNotificaiton:kUserRepairCmd];
        
        [_activity stopAnimating];
        
        if (FilmRequsetSuccess == transaction.status)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ShowMessage showMessage:@"提交失败"];
        }
    }
    else if ([transaction.command isEqualToString:kUserRepairMansCmd])
    {
        [self filmunobserveTransactionNotificaiton:kUserRepairMansCmd];
        
        [_activity stopAnimating];
        
        if (FilmRequsetSuccess == transaction.status)
        {
            NSArray *array = transaction.data;
            [_repairView reloadRepaorData:array];
        }
        else
        {
            [ShowMessage showMessage:@"获取维修人员信息失败"];
        }
    }
    
}

@end
