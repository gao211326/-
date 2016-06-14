//
//  FindViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/13.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "FindViewController.h"
#import "BaseButtonView.h"
#import "FindViewTableViewCell.h"



static NSString *const kFindCellDataList = @"FindViewController";

static CGFloat kTableHeadViewH = 82;
static CGFloat kFindBaseButtonH = 61;
static CGFloat kFindBaseButtonW = 70;//5s标准下

@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *                    _tableHeadView;
    UIView *                    _tableHeadBottomView;
    
    BaseButtonView *            _expressButton;
    BaseButtonView *            _unlockButton;
    BaseButtonView *            _washButton;
    BaseButtonView *            _moveHouseButton;
    
    UITableView *               _mainTableView;
    
    
    NSArray *                   _cellDataArray;
}
@end

@implementation FindViewController

- (id)init
{
    self = [super init];
    if (self) {
        _cellDataArray = [self dataArrayWith:[self dataConfigPathWith:kFindCellDataList]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigateBarBackImage:[UIImage imageWithColor:UICOLOR_FROM_RGB(251, 66, 46) size:CGSizeMake(CURRVIEW_WIDTH, 64)]];
    
    [self setTitleText:[UIFont systemFontOfSize:17] Color:[UIColor whiteColor]];
    [self setTitleTextView:@"发现"];
    
    [self setLeftBarItemWithImage:@"扫一扫" HighlightImage:nil selector:@selector(leftButtonClick:)];
    [self setRightBarItemWithImage:@"mag_glass-副本" HighlightImage:nil selector:@selector(rightButtonClick:)];
    
    [self initViewComponents];
    
}

- (void)initViewComponents
{
    _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                             0,
                                                             CURRVIEW_WIDTH,
                                                             kTableHeadViewH)
                      ];
    
    _expressButton = [[BaseButtonView alloc]initWithButtonNomalImage:@"快递"
                                                           highImage:nil
                                                         buttonTitle:@"快递"
                                                      baseButtonType:BaseButtonFindType];
    [_tableHeadView addSubview:_expressButton];
    
    
    _unlockButton = [[BaseButtonView alloc]initWithButtonNomalImage:@"开锁"
                                                          highImage:nil
                                                        buttonTitle:@"开锁换锁"
                                                     baseButtonType:BaseButtonFindType];
    [_tableHeadView addSubview:_unlockButton];
    
    
    _washButton = [[BaseButtonView alloc]initWithButtonNomalImage:@"洗衣"
                                                        highImage:nil
                                                      buttonTitle:@"洗衣"
                                                   baseButtonType:BaseButtonFindType];
    [_tableHeadView addSubview:_washButton];
    
    
    _moveHouseButton = [[BaseButtonView alloc]initWithButtonNomalImage:@"搬家"
                                                             highImage:nil
                                                           buttonTitle:@"搬家搬场"
                                                        baseButtonType:BaseButtonFindType];
    [_tableHeadView addSubview:_moveHouseButton];
    
    
    [_expressButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(GTReViewXFloat(kFindBaseButtonW), kFindBaseButtonH));
        make.left.equalTo(_tableHeadView.left).offset((CURRVIEW_WIDTH - 4 * GTReViewXFloat(kFindBaseButtonW))/5);
        make.top.equalTo(_tableHeadView.top).offset(11);
    }];
    
    [_unlockButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(GTReViewXFloat(kFindBaseButtonW), kFindBaseButtonH));
        make.left.equalTo(_expressButton.right).offset((CURRVIEW_WIDTH - 4 * GTReViewXFloat(kFindBaseButtonW))/5);
        make.top.equalTo(_expressButton.top);
    }];
    
    [_washButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(GTReViewXFloat(kFindBaseButtonW), kFindBaseButtonH));
        make.left.equalTo(_unlockButton.right).offset((CURRVIEW_WIDTH - 4 * GTReViewXFloat(kFindBaseButtonW))/5);
        make.top.equalTo(_expressButton.top);
    }];
    
    [_moveHouseButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(GTReViewXFloat(kFindBaseButtonW), kFindBaseButtonH));
        make.left.equalTo(_washButton.right).offset((CURRVIEW_WIDTH - 4 * GTReViewXFloat(kFindBaseButtonW))/5);
        make.top.equalTo(_expressButton.top);
    }];
    
    
    _tableHeadBottomView = [[UIView alloc]init];
    _tableHeadBottomView.backgroundColor = UICOLOR_FROM_RGB(234, 234, 234);
    [_tableHeadView addSubview:_tableHeadBottomView];
    
    [_tableHeadBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_tableHeadView.bottom);
        make.height.equalTo(@4);
        make.left.equalTo(_tableHeadView.left);
        make.right.equalTo(_tableHeadView.right);
    }];
    
    
    UIView *_line1 = [[UIView alloc]init];
    _line1.backgroundColor = UICOLOR_FROM_RGB(209, 209, 209);
    [_tableHeadBottomView addSubview:_line1];
    
    [_line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tableHeadBottomView.left);
        make.right.equalTo(_tableHeadBottomView.right);
        make.top.equalTo(_tableHeadBottomView.top);
        make.height.equalTo(@0.5);
    }];
    
    UIView *_line2 = [[UIView alloc]init];
    _line2.backgroundColor = UICOLOR_FROM_RGB(209, 209, 209);
    [_tableHeadBottomView addSubview:_line2];
    
    [_line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tableHeadBottomView.left);
        make.right.equalTo(_tableHeadBottomView.right);
        make.bottom.equalTo(_tableHeadBottomView.bottom);
        make.height.equalTo(@0.5);
    }];
    
    
    
    
    
    _mainTableView = [[UITableView alloc]init];
    _mainTableView.dataSource = (id)self;
    _mainTableView.delegate = (id)self;
    _mainTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_mainTableView];
    
    _mainTableView.tableHeaderView = _tableHeadView;
    
    _mainTableView.tableFooterView = [[UIView alloc]init];
    
    
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
}


#pragma mark ==========================================
#pragma mark ==property accessor
#pragma mark ==========================================
- (NSString *)dataConfigPathWith:(NSString *)pathName
{
    
    NSString * _dataConfigPath = [[NSBundle mainBundle] pathForResource:pathName ofType:@"plist"];
    return _dataConfigPath;
}

- (NSArray *)dataArrayWith:(NSString *)path
{
    NSArray  * _dataArray = [[NSArray alloc] initWithContentsOfFile:path];
    return _dataArray;
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
    
}

- (void)rightButtonClick:(UIButton *)sender
{
    
}


#pragma mark ==========================================
#pragma mark == tableView delegate
#pragma mark ==========================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FindViewTableViewCell findViewCellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindViewTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"findCell"];
    if(!cell){
        cell=[[FindViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"findCell"] ;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dic = [_cellDataArray objectAtIndex:indexPath.row];
    [cell reloadFindCellData:dic];
    return cell;
}




@end
