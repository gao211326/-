//
//  ShowMessage.h
//  影讯
//
//  Created by 高 on 14-6-10.
//  Copyright (c) 2014年 罗 何. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ShowMessage : UIView

- (id)initPro;

+(void)showMessage:(NSString *)message;

/*view为viewcontroller的view*/
- (void)showProgress:(UIView*)view;

/*用于首页即将上映的，其它页面勿调*/
- (void)showSoonViewProgress:(UIView *)view;

- (void)showTableViewProgress:(UIView *)TableView;

/*隐藏菊花*/
- (void)hideProgress;

- (void)startTurn;

@end
