//
//  RepairMessageViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/10/12.
//  Copyright © 2015年 高磊. All rights reserved.
//

#import "RepairMessageViewController.h"
#import "RepairDetailMessageViewController.h"

#import "UserTransaction.h"
#import "UserMessageDataModels.h"
#import "JSONKit.h"

#import "SVPullToRefresh.h"

@interface RepairMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *           _mainTableView;
    
    int                     _pi;
    int                     _ps;
}

@property (nonatomic,strong) NSMutableArray *rowArray;

@end

@implementation RepairMessageViewController

- (NSMutableArray *)rowArray
{
    if (nil == _rowArray)
    {
        _rowArray = [[NSMutableArray alloc]init];
    }
    return _rowArray;
}

- (id)init
{
    self = [super init];
    if (self) {
        _pi = 1;
        _ps = 20;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    [self setTitleTextView:@"我的消息"];
    
    
    _mainTableView = [[UITableView alloc]init];
    _mainTableView.dataSource = (id)self;
    _mainTableView.delegate = (id)self;
    [self.view addSubview:_mainTableView];
    
    _mainTableView.tableFooterView = [[UIView alloc]init];
    
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [_mainTableView addPullToRefreshWithActionHandler:^{
        [weakSelf pullToRefresh];
    }];
    
    [_mainTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf InfiniteScrolling];
    }];
    
//-----------------
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"Messgae" ofType:@"json"];
//    
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    
//    NSDictionary *dic = [data objectFromJSONData];
//    
//
//    UserMessageBaseClass *baseMessage = [UserMessageBaseClass modelObjectWithDictionary:dic];
//    
//    if (_pi == 1)
//    {
//        [self.rowArray removeAllObjects];
//        self.rowArray = [NSMutableArray arrayWithArray:baseMessage.rows];
//    }
//    else
//    {
//        [self.rowArray addObjectsFromArray:baseMessage.rows];
//    }
//    
//    if (baseMessage.rows == 0)
//    {
//        _pi --;
//    }
//    
//    
//    [_mainTableView reloadData];
//-----------------
    
    
    
    NSString *phone = [[UserTransaction sharedInstance] userEmail];
    
    [self filmobserveTransactionNotificaiton:kUserRepairMessageCmd];
    [[UserTransaction sharedInstance] userGetRepairMessageWithPhone:phone pi:_pi ps:_ps];
}


#pragma mark == private method
- (void)pullToRefresh
{
    _pi = 1;
    _ps = 10;
    
    [_mainTableView.pullToRefreshView startAnimating];
    [_mainTableView.infiniteScrollingView stopAnimating];
    
    NSString *phone = [[UserTransaction sharedInstance] userEmail];
    
    [self filmobserveTransactionNotificaiton:kUserRepairMessageCmd];
    [[UserTransaction sharedInstance] userGetRepairMessageWithPhone:phone pi:_pi ps:_ps];}

- (void)InfiniteScrolling
{
    _pi ++;
    
    [_mainTableView.pullToRefreshView stopAnimating];
    [_mainTableView.infiniteScrollingView startAnimating];
    
    NSString *phone = [[UserTransaction sharedInstance] userEmail];
    
    [self filmobserveTransactionNotificaiton:kUserRepairMessageCmd];
    [[UserTransaction sharedInstance] userGetRepairMessageWithPhone:phone pi:_pi ps:_ps];
}



#pragma mark == event response
- (void)leftButtonClick:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark ==========================================
#pragma mark == UITableViewDataSource
#pragma mark ==========================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const iDentifirtString = @"repairMessageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDentifirtString];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iDentifirtString];
    }
    
    UserMessageRows *rowsData = [self.rowArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = rowsData.content;
    
    return cell;
}

#pragma mark ==========================================
#pragma mark == UITableViewDelegate
#pragma mark ==========================================
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UserMessageRows *rowsData = [self.rowArray objectAtIndex:indexPath.row];
    
    RepairDetailMessageViewController *deailMessVc = [[RepairDetailMessageViewController alloc]initWithRowsData:rowsData];
    [self pushController:deailMessVc withAnimated:YES];
    
}


#pragma mark == request finish
- (void)filmENgineRequestFinished:(FilmResult *)transaction
{
    if ([transaction.command isEqualToString:kUserRepairMessageCmd])
    {
        [self filmunobserveTransactionNotificaiton:kUserRepairMessageCmd];
        
        [_mainTableView.pullToRefreshView stopAnimating];
        [_mainTableView.infiniteScrollingView stopAnimating];
        
//        [_activity stopAnimating];
        
        if (FilmRequsetSuccess == transaction.status)
        {
            UserMessageBaseClass *baseMessage = transaction.data;
            
            if (_pi == 1)
            {
                [self.rowArray removeAllObjects];
                self.rowArray = [NSMutableArray arrayWithArray:baseMessage.rows];
            }
            else
            {
                [self.rowArray addObjectsFromArray:baseMessage.rows];
            }
            
            if (baseMessage.rows == 0)
            {
                _pi --;
            }
          
            if (self.rowArray.count == 0)
            {
                [ShowMessage showMessage:@"暂无维修消息~"];
            }
            
        }
        else
        {
            [ShowMessage showMessage:@"获取失败~"];
//            [ShowMessage showMessage:@"提交失败"];
        }
    }
}


@end
