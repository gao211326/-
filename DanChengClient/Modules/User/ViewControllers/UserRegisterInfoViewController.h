//
//  UserRegisterInfoViewController.h
//  DanChengClient
//
//  Created by 高磊 on 15/8/25.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "BaseViewController.h"

@interface UserRegisterInfoViewController : BaseViewController

@property (nonatomic,strong)NSString *buildingCode;
@property (nonatomic,strong)NSString *roomNumberCode;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *userIcardNumber;

@property (nonatomic,assign)int fromType;

@end
