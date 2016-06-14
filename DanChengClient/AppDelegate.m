//
//  AppDelegate.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/13.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeViewController.h"
#import "FindViewController.h"
#import "CommunitiesViewController.h"
#import "UserLoginViewController.h"
#import "AddViewController.h"
#import "RepairMessageViewController.h"

#import "UserTransaction.h"
//sharesdk 短信验证码
#import <SMS_SDK/SMS_SDK.h>
//友盟
#import "UMessage.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

static NSString * const appKey = @"739df978403c";
static NSString * const appSecret = @"8490164326518ea48a6dc9df183f5c3a";


static NSString * const UM_Push_key = @"55ff827767e58ef3710003d2";
static NSString * const UM_Push_Secret = @"uvxxstfnt0xett4ztihkxcuf1enrx6ti";

@interface AppDelegate ()
{

}

@property(nonatomic,strong)NSDictionary *pushInfo;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UserTransaction sharedInstance] cleanUserInfo];
    
    //sharesdk 短信验证码
    [SMS_SDK registerApp:appKey withSecret:appSecret];
    
    
    //友盟推送
    [UMessage startWithAppkey:UM_Push_key launchOptions:launchOptions];
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    
    
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo)
    {
        self.pushInfo = userInfo;
    }
    
    
    NSString *phone = [[UserTransaction sharedInstance] userEmail];
    NSString *pass = [[UserTransaction sharedInstance] userPassword];
    
    if (phone && pass)
    {
        [[UserTransaction sharedInstance] userLogin:phone password:pass];
    }
    
    
    HomeViewController *loginVc = [[HomeViewController alloc]init];
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:loginVc];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    if (self.pushInfo)
    {
        [self performSelector:@selector(pushMethod) withObject:nil afterDelay:1.0];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];;
    
    self.deviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                        stringByReplacingOccurrencesOfString: @" " withString: @""];
}

- (void)pushMethod
{
    if ([[UserTransaction sharedInstance] currentUser])
    {
        RepairMessageViewController *repairVc = [[RepairMessageViewController alloc]init];
        [self.window.rootViewController pushController:repairVc withAnimated:YES];
    }
    else
    {
        UserLoginViewController *loginVc = [[UserLoginViewController alloc] init];
        loginVc.fromType = 2;
        [self.window.rootViewController pushController:loginVc withAnimated:YES];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];

    RepairMessageViewController *messageVc = [[RepairMessageViewController alloc]init];
    [self.window.rootViewController pushController:messageVc withAnimated:YES];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
