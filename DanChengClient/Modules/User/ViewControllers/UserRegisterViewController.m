//
//  UserRegisterViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/16.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "IcardNumberViewController.h"

#import "SetInputView.h"
#import "HeadSelectView.h"
#import "ShowMessage.h"
#import "ZHPickView.h"

#import "UserTransaction.h"
#import "CommunityDataModels.h"
#import "OtherDataModels.h"

#import <SMS_SDK/SMS_SDK.h>

@interface UserRegisterViewController ()<SetInputViewDelegate,ZHPickViewDelegate
>
{
    UIScrollView *          _mainScrollView;
    UIView *                _mainView;
    
    HeadSelectView *        _headSelectView;
    
    UILabel *               _chooseAddressLable;
    
    SetInputView *          _cityInputView;
    SetInputView *          _communityInputView;
    SetInputView *          _roomNumberInputView;
    SetInputView *          _buildingInputView;
    SetInputView *          _unitInputView;
    SetInputView *          _floorInputView;

    UIButton *              _besureButton;
    
    
    NSMutableArray *        _communityArray;
    NSMutableArray *        _buildingArray;
    NSMutableArray *        _unitArray;
    NSMutableArray *        _floorArray;
    NSMutableArray *        _roomNumberArray;

    ZHPickView *            _pickView;//小区
    ZHPickView *            _buildingPickView;//楼栋
    ZHPickView *            _unitPickView;//单元
    ZHPickView *            _floorPickView;//楼层
    ZHPickView *            _roomNumberPickView;//房号
    
    UIActivityIndicatorView *   _activity;
    
    
    NSString *              _buildingCode;
    NSString *              _roomNumberCode;
}
@end

@implementation UserRegisterViewController

- (id)init
{
    self = [super init];
    if (self) {
        _communityArray = [NSMutableArray array];
        _buildingArray = [NSMutableArray array];
        _unitArray = [NSMutableArray array];
        _floorArray = [NSMutableArray array];
        _roomNumberArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xededed);
    
    [self setNavigateBarBackImage:[UIImage imageWithColor:UICOLOR_FROM_RGB(251, 66, 46) size:CGSizeMake(CURRVIEW_WIDTH, 64)]];
    
    [self setTitleText:[UIFont systemFontOfSize:17] Color:[UIColor whiteColor]];
    
    [self setTitleTextView:@"注册"];

    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    
    [self initViewComponents];
    
    [self reloadInputData];
    
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_activity startAnimating];
    
    [self filmobserveTransactionNotificaiton:kUserGetCommunityCmd];
    [[UserTransaction sharedInstance] userGetCommunityList];
}


#pragma mark == private method
- (void)initViewComponents
{
    _mainScrollView = [[UIScrollView alloc]init];
    _mainScrollView.showsHorizontalScrollIndicator =
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    [_mainScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view.width);
    }];
    
    _mainView = [[UIView alloc]init];
    [_mainScrollView addSubview:_mainView];

    
    _headSelectView = [[HeadSelectView alloc] initWithSelectType:0];
    [_mainView addSubview:_headSelectView];
    
    _chooseAddressLable = [[UILabel alloc] init];
    _chooseAddressLable.textColor = UICOLOR_FROM_RGB_OxFF(0x525252);
    _chooseAddressLable.font = [UIFont systemFontOfSize:14];
    _chooseAddressLable.text = @"选择您的住处:";
    [_mainView addSubview:_chooseAddressLable];
    
    
    
    
    
    _cityInputView = [[SetInputView alloc]initWithInputType:SetInPutViewNotInputType];
    _cityInputView.delegate = (id)self;
    [_mainView addSubview:_cityInputView];
    
    _communityInputView = [[SetInputView alloc]initWithInputType:SetInPutViewNotInputType];
    _communityInputView.delegate = (id)self;
    [_mainView addSubview:_communityInputView];
    

    _buildingInputView = [[SetInputView alloc]initWithInputType:SetInPutViewNotInputType];
    _buildingInputView.delegate = (id)self;
    [_mainView addSubview:_buildingInputView];
    
    _unitInputView = [[SetInputView alloc]initWithInputType:SetInPutViewNotInputType];
    _unitInputView.delegate = (id)self;
    [_mainView addSubview:_unitInputView];
    
    _floorInputView = [[SetInputView alloc]initWithInputType:SetInPutViewNotInputType];
    _floorInputView.delegate = (id)self;
    [_mainView addSubview:_floorInputView];

    
    _roomNumberInputView = [[SetInputView alloc]initWithInputType:SetInPutViewNotInputType];
    _roomNumberInputView.delegate = (id)self;
    [_mainView addSubview:_roomNumberInputView];
    
    _besureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
    [_besureButton setBackgroundImage:[UIImage imageNamed:@"登录按下"] forState:UIControlStateHighlighted];
    
    [_besureButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [_besureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_besureButton addTarget:self action:@selector(besureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_besureButton];
    
    
    
    
    [_headSelectView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mainView.top).offset(8);
        make.height.equalTo(@34);
        make.left.equalTo(_mainView.left);
        make.right.equalTo(_mainView.right);
    }];
    
    
    [_chooseAddressLable makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@55);
        make.left.equalTo(_mainView.left).offset(GTReViewXFloat(6.5));
        make.right.equalTo(_roomNumberInputView.right);
        make.top.equalTo(_headSelectView.bottom);
    }];
    
    
    [_cityInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chooseAddressLable.bottom);
        make.height.equalTo(@49);
        make.width.equalTo(_mainView.width);
        make.left.equalTo(_mainView.left);
    }];
    
    [_communityInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cityInputView.bottom);
        make.height.equalTo(@49);
        make.width.equalTo(_mainView.width);
        make.left.equalTo(_mainView.left);
    }];
    
    
    [_buildingInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_communityInputView.bottom);
        make.height.equalTo(@49);
        make.width.equalTo(_mainView.width);
        make.left.equalTo(_mainView.left);
    }];

    
    [_unitInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buildingInputView.bottom);
        make.height.equalTo(@49);
        make.width.equalTo(_mainView.width);
        make.left.equalTo(_mainView.left);
    }];

    [_floorInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_unitInputView.bottom);
        make.height.equalTo(@49);
        make.width.equalTo(_mainView.width);
        make.left.equalTo(_mainView.left);
    }];

    
    [_roomNumberInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_floorInputView.bottom);
        make.height.equalTo(@49);
        make.width.equalTo(_mainView.width);
        make.left.equalTo(_mainView.left);
    }];

    [_besureButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_roomNumberInputView.bottom).offset(45);
        make.size.equalTo(CGSizeMake(GTReViewXFloat(587/2), 75/2));
        make.centerX.equalTo(_mainView.centerX);
    }];
    
    
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainScrollView);
        make.width.equalTo(_mainScrollView.width);
        make.bottom.equalTo(_besureButton.bottom).offset(30);
    }];
}

- (void)reloadInputData
{
    [_cityInputView reloadTitleName:@"城市" inputNomalName:@"攀枝花"];
    [_communityInputView reloadTitleName:@"小区" inputNomalName:@""];
    [_buildingInputView reloadTitleName:@"楼栋" inputNomalName:@""];
    [_unitInputView reloadTitleName:@"单元" inputNomalName:@""];
    [_floorInputView reloadTitleName:@"楼层" inputNomalName:@""];
    [_roomNumberInputView reloadTitleName:@"房号" inputNomalName:@""];
}

#pragma mark ==========================================
#pragma mark == button actions
#pragma mark ==========================================

- (void)leftButtonClick:(UIButton *)sender
{
    [self popControllerWithAnimated:YES];
}

- (void)besureButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if (_buildingCode && _roomNumberCode)
    {
        IcardNumberViewController *icardVc = [[IcardNumberViewController alloc]init];
        icardVc.buildingCode = _buildingCode;
        icardVc.roomNumberCode = _roomNumberCode;
        [self pushController:icardVc withAnimated:YES];
    }
    else
    {
        [ShowMessage showMessage:@"请填入完整的住址信息"];
    }
}

#pragma mark == SetInputViewDelegate

- (void)setInputViewTap:(SetInputView *)inputView
{
    if (_communityInputView == inputView)
    {
        if (_communityArray.count == 0)
        {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        
        for (CommunityCommunitylist *list in _communityArray)
        {
            NSString *name = list.communityName;
            
            [array addObject:name];
        }

        if (!_pickView)
        {
            _pickView = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickView.delegate = (id)self;
        }
        [_pickView show];
    }
    else if (_buildingInputView == inputView)
    {
        if (_buildingArray.count == 0)
        {
            return;
        }
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (OtherList *list in _buildingArray)
        {
            NSString *name = list.name;
            
            [array addObject:name];
        }
        
        if (!_buildingPickView)
        {
            _buildingPickView = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _buildingPickView.delegate = (id)self;
        }
        [_buildingPickView show];

    }
    else if (_unitInputView == inputView)
    {
        if (_unitArray.count == 0)
        {
            return;
        }

        NSMutableArray *array = [NSMutableArray array];
        
        for (OtherList *list in _unitArray)
        {
            NSString *name = list.name;
            
            [array addObject:name];
        }
        
        if (!_unitPickView)
        {
            _unitPickView = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _unitPickView.delegate = (id)self;
        }
        [_unitPickView show];
        
    }

    else if (_floorInputView == inputView)
    {
        if (_floorArray.count == 0)
        {
            return;
        }

        NSMutableArray *array = [NSMutableArray array];
        
        for (OtherList *list in _floorArray)
        {
            NSString *name = list.name;
            
            [array addObject:name];
        }
        
        if (!_floorPickView)
        {
            _floorPickView = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _floorPickView.delegate = (id)self;
        }
        [_floorPickView show];
        
    }

    else if (_roomNumberInputView == inputView)
    {
        if (_roomNumberArray.count == 0)
        {
            return;
        }

        NSMutableArray *array = [NSMutableArray array];
        
        for (OtherList *list in _roomNumberArray)
        {
            NSString *name = list.name;
            
            [array addObject:name];
        }
        
        if (!_roomNumberPickView)
        {
            _roomNumberPickView = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _roomNumberPickView.delegate = (id)self;
        }
        [_roomNumberPickView show];
    }
}


#pragma mark == ZHPickViewDelegate
- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if (_pickView == pickView)
    {
        [_communityInputView reloadTitleName:@"小区" inputNomalName:resultString];
        
        CommunityCommunitylist *list = [_communityArray objectAtIndex:pickView.selectIndex];
    
        [_activity startAnimating];
        [self filmobserveTransactionNotificaiton:kUserGetBuildingCmd];
        [[UserTransaction sharedInstance] userGetOtherListInfoWithParentCode:list.communityCode withCmd:kUserGetBuildingCmd];
    }
    else if (_buildingPickView == pickView)
    {
        [_buildingInputView reloadTitleName:@"楼栋" inputNomalName:resultString];
        
        OtherList *list = [_buildingArray objectAtIndex:pickView.selectIndex];
        
        _buildingCode = list.code;
        
        [_activity startAnimating];
        [self filmobserveTransactionNotificaiton:kUserGetUnitCmd];
        [[UserTransaction sharedInstance] userGetOtherListInfoWithParentCode:list.code withCmd:kUserGetUnitCmd];
    }
    else if (_unitPickView == pickView)
    {
        [_unitInputView reloadTitleName:@"单元" inputNomalName:resultString];
        
        OtherList *list = [_unitArray objectAtIndex:pickView.selectIndex];
        
        [_activity startAnimating];
        [self filmobserveTransactionNotificaiton:kUserGetFloorCmd];
        [[UserTransaction sharedInstance] userGetOtherListInfoWithParentCode:list.code withCmd:kUserGetFloorCmd];
    }
    else if (_floorPickView == pickView)
    {
        [_floorInputView reloadTitleName:@"楼层" inputNomalName:resultString];
        
        OtherList *list = [_floorArray objectAtIndex:pickView.selectIndex];
        
        [_activity startAnimating];
        [self filmobserveTransactionNotificaiton:kUserGetRoomCmd];
        [[UserTransaction sharedInstance] userGetOtherListInfoWithParentCode:list.code withCmd:kUserGetRoomCmd];
    }
    else if (_roomNumberPickView == pickView)
    {
        [_roomNumberInputView reloadTitleName:@"房号" inputNomalName:resultString];
        
        OtherList *list = [_floorArray objectAtIndex:pickView.selectIndex];
        
        _roomNumberCode = list.code;
    }
}

#pragma mark ==========================================
#pragma mark == request finish
#pragma mark ==========================================
- (void)filmENgineRequestFinished:(FilmResult *)transaction
{
    if ([transaction.command isEqualToString:kUserGetCommunityCmd])
    {
        [_activity stopAnimating];
        [self filmunobserveTransactionNotificaiton:kUserGetCommunityCmd];
        if (FilmRequsetSuccess == transaction.status)
        {
            CommunityData *communityData = transaction.data;
            
            _communityArray = [NSMutableArray arrayWithArray:communityData.communitylist];
            
            if (_communityArray.count > 0)
            {
                CommunityCommunitylist *list = [_communityArray objectAtIndex:0];
                
                [_communityInputView reloadTitleName:@"小区" inputNomalName:list.communityName];
            }
        }
        else
        {
            [ShowMessage showMessage:transaction.message];
        }
    }
    else if ([transaction.command isEqualToString:kUserGetBuildingCmd])
    {
        [_activity stopAnimating];
        [self filmunobserveTransactionNotificaiton:kUserGetBuildingCmd];
        if (FilmRequsetSuccess == transaction.status)
        {
            OtherData *otherData = transaction.data;
            
            _buildingArray = [NSMutableArray arrayWithArray:otherData.list];
            
            if (_buildingArray.count > 0)
            {
                OtherList *list = [_buildingArray objectAtIndex:0];
                
                [_buildingInputView reloadTitleName:@"楼栋" inputNomalName:list.name];
                
                _buildingCode = list.code;
            }
        }
        else
        {
            [ShowMessage showMessage:transaction.message];
        }
    }
    else if ([transaction.command isEqualToString:kUserGetUnitCmd])
    {
        [_activity stopAnimating];
        [self filmunobserveTransactionNotificaiton:kUserGetUnitCmd];
        if (FilmRequsetSuccess == transaction.status)
        {
            OtherData *otherData = transaction.data;
            
            _unitArray = [NSMutableArray arrayWithArray:otherData.list];
            
            if (_unitArray.count > 0)
            {
                OtherList *list = [_unitArray objectAtIndex:0];
                
                [_unitInputView reloadTitleName:@"单元" inputNomalName:list.name];
            }
        }
        else
        {
            [ShowMessage showMessage:transaction.message];
        }
    }
    else if ([transaction.command isEqualToString:kUserGetFloorCmd])
    {
        [_activity stopAnimating];
        [self filmunobserveTransactionNotificaiton:kUserGetFloorCmd];
        if (FilmRequsetSuccess == transaction.status)
        {
            OtherData *otherData = transaction.data;
            
            _floorArray = [NSMutableArray arrayWithArray:otherData.list];
            
            if (_floorArray.count > 0)
            {
                OtherList *list = [_floorArray objectAtIndex:0];
                
                [_floorInputView reloadTitleName:@"楼层" inputNomalName:list.name];
            }
        }
        else
        {
            [ShowMessage showMessage:transaction.message];
        }
    }
    else if ([transaction.command isEqualToString:kUserGetRoomCmd])
    {
        [_activity stopAnimating];
        [self filmunobserveTransactionNotificaiton:kUserGetRoomCmd];
        if (FilmRequsetSuccess == transaction.status)
        {
            OtherData *otherData = transaction.data;
            
            _roomNumberArray = [NSMutableArray arrayWithArray:otherData.list];
            
            if (_roomNumberArray.count > 0)
            {
                OtherList *list = [_roomNumberArray objectAtIndex:0];
                
                [_roomNumberInputView reloadTitleName:@"房号" inputNomalName:list.name];
                _roomNumberCode = list.code;
            }
        }
        else
        {
            [ShowMessage showMessage:transaction.message];
        }
    }

}

@end
