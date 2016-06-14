//
//  UserRegisterViewController.h
//  DanChengClient
//
//  Created by 高磊 on 15/5/16.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "BaseViewController.h"
#import "UserRegisterViewController.h"


@interface ForgotPasswordViewController : BaseViewController

- (id)initWithRegisterType:(RegisterType)type;

@property (nonatomic,assign)RegisterType registerVcType;

@end
