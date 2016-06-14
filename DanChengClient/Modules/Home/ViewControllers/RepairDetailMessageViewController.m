//
//  RepairDetailMessageViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/11/9.
//  Copyright © 2015年 高磊. All rights reserved.
//

#import "RepairDetailMessageViewController.h"
#import "UserMessageDataModels.h"

@interface RepairDetailMessageViewController ()
{
    UILabel *           _desLable;
    
    UserMessageRows *   _rowsData;
}
@end

@implementation RepairDetailMessageViewController

- (id)initWithRowsData:(UserMessageRows *)rows
{
    self = [super init];
    if (self) {
        _rowsData = rows;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    [self setTitleTextView:@"我的消息"];
    
    _desLable = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                         20,
                                                         CURRVIEW_WIDTH - 20,
                                                         CURRVIEW_HEIGTH - 20)];
    _desLable.font = [UIFont systemFontOfSize:15];
    _desLable.textColor = UICOLOR_FROM_RGB_OxFF(0x333333);
    _desLable.numberOfLines = 0;
    [self.view addSubview:_desLable];
    
    [_desLable setText:_rowsData.content];
    
    
    CGFloat height = [_rowsData.content getDrawHeightWithFont:[UIFont systemFontOfSize:15] Width:CURRVIEW_WIDTH - 20];
    [_desLable setHeight:height];
}

- (void)leftButtonClick:(UIButton *)sender
{
    [self popControllerWithAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
