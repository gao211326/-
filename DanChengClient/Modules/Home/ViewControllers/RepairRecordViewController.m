//
//  RepairRecordViewController.m
//  DanChengClient
//
//  Created by 高磊 on 15/8/27.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "RepairRecordViewController.h"
#import "HMSegmentedControl.h"

#import "UserTransaction.h"

//#define kWebViewUrl         @"http://47.88.0.119/crm-web/mobile/repair/orderList/"

#define kWebViewUrl         @"http://182.150.24.137:8089/crm/api/repair/repairRecord/"


@interface RepairRecordViewController ()
{
    HMSegmentedControl *    _hmsegmentedControl;
    
    UIScrollView *          _baseScrollView;
    
    UIWebView *             _leftWebView;
    UIWebView *             _rightWebView;
    
}
@end

@implementation RepairRecordViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xeeeeee);
    
    [self setLeftBarItemWithImage:@"back" HighlightImage:nil selector:@selector(leftButtonClick:)];
    
    [self setTitleTextView:@"海棠花语"];
    
//    NSArray *titlesArray = [NSArray arrayWithObjects:@"所有报修",@"我的报修", nil];
    
//    _hmsegmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:titlesArray];
//    _hmsegmentedControl.frame = CGRectMake(0, 0, CURRVIEW_WIDTH, 43);
//    _hmsegmentedControl.selectedTextColor = UICOLOR_FROM_RGB_OxFF(0xff5b3b);
//    _hmsegmentedControl.textColor = UICOLOR_FROM_RGB_OxFF(0x3c3c3c);
//    _hmsegmentedControl.selectionIndicatorColor = UICOLOR_FROM_RGB_OxFF(0xff5b3b);
//    _hmsegmentedControl.selectionIndicatorHeight = 4;
//    _hmsegmentedControl.font = [UIFont systemFontOfSize:15];
//    _hmsegmentedControl.selectFont = [UIFont systemFontOfSize:15];
//    _hmsegmentedControl.selectionIndicatorLocation =HMSegmentedControlSelectionIndicatorLocationDown;
//    _hmsegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
//    [_hmsegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:_hmsegmentedControl];
    
//    
//    UIView *line = [[UIView alloc]init];
//    line.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xe0e0e0);
//    [_hmsegmentedControl addSubview:line];
//    
//    [line makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@17);
//        make.width.equalTo(@1);
//        make.centerX.equalTo(_hmsegmentedControl.centerX);
//        make.centerY.equalTo(_hmsegmentedControl.centerY);
//    }];
    
    
    _baseScrollView = [[UIScrollView alloc]init];
    [_baseScrollView setContentSize:CGSizeMake(2 * CURRVIEW_WIDTH, 0)];
    _baseScrollView.showsHorizontalScrollIndicator = _baseScrollView.showsVerticalScrollIndicator = NO;
    _baseScrollView.delegate = (id)self;
    _baseScrollView.pagingEnabled = YES;
    [self.view addSubview:_baseScrollView];
    
    [_baseScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    _leftWebView = [[UIWebView alloc] init];
    [_leftWebView setScalesPageToFit:YES];
    _leftWebView.delegate = (id)self;
    [_baseScrollView addSubview:_leftWebView];
 
//    
//    _rightWebView = [[UIWebView alloc] init];
//    [_rightWebView setScalesPageToFit:YES];
//    _rightWebView.delegate = (id)self;
//    [_baseScrollView addSubview:_rightWebView];
    
    
    [_leftWebView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_baseScrollView.left);
        make.width.equalTo(@(CURRVIEW_WIDTH));
        make.height.equalTo(_baseScrollView.height);
        make.top.equalTo(_baseScrollView.top);
    }];
    
//    
//    [_rightWebView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_leftWebView.right);
//        make.width.equalTo(@(CURRVIEW_WIDTH));
//        make.height.equalTo(_baseScrollView.height);
//        make.top.equalTo(_baseScrollView.top);
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadWebView];
}


#pragma mark == private method
- (void)reloadWebView
{
    NSString *phone = [[UserTransaction sharedInstance] userEmail];
    
    NSString *_urlSring = [NSString stringWithFormat:@"%@%@.do",kWebViewUrl,phone];
    
    NSURL *url = [NSURL URLWithString:_urlSring];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [_leftWebView loadRequest:urlRequest];
//    [_rightWebView loadRequest:urlRequest];
}


#pragma mark == event response

- (void)leftButtonClick:(UIButton *)sender
{
//    [self popControllerWithAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//- (void)segmentedControlChangedValue:(HMSegmentedControl *)segementedControl
//{
//    if (segementedControl.selectedSegmentIndex == 0)
//    {
//        [_baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
//    else if (segementedControl.selectedSegmentIndex == 1)
//    {
//        [_baseScrollView setContentOffset:CGPointMake(CURRVIEW_WIDTH, 0) animated:YES];
//    }
//}

@end
