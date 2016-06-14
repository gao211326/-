//
//  AppDelegate.h
//  DanChengClient
//
//  Created by 高磊 on 15/5/13.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UITabBarController *root;

@property (nonatomic,strong) NSString *deviceToken;

@end

