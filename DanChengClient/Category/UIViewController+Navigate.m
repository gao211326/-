//
//  UIViewController+Navigate.m
//  socialDemo
//
//  Created by 陈欢 on 14-1-2.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "UIViewController+Navigate.h"
#import "ArcDefine.h"
#import "UIView+Appearance.h"
#import "NSNull+Expand.h"

@implementation UIViewController (Navigate)

- (void)setTitleFont:(UIFont*)font
{
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      font, NSFontAttributeName, nil]];
}

- (void)setTitleColor:(UIColor*)color
{
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      color, NSForegroundColorAttributeName,
                                                                      nil]];
}

- (void)setTitleText:(UIFont*)font Color:(UIColor*)color
{
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           color, NSForegroundColorAttributeName,
                                                           font, NSFontAttributeName, nil]];
}

- (void)setTitleTextView:(NSString *)title
{
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                    0.0f,
                                                                    200.f,
                                                                    40.f)];
    UIFont *titleFont = [self.navigationController.navigationBar.titleTextAttributes objectForKey:NSFontAttributeName];
    UIColor *titleColor = [self.navigationController.navigationBar.titleTextAttributes objectForKey:NSForegroundColorAttributeName];
    [titleLable setFont:titleFont];
    [titleLable setTextColor:titleColor];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setText:title];
    self.navigationItem.titleView = titleLable;
    
    
#if !__has_feature(objc_arc)
    [titleLable release];
#endif
    titleLable = nil;
}

- (void)setTitleTextView:(NSString *)title selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, CURRVIEW_WIDTH - 100, 40);
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIFont *titleFont = [self.navigationController.navigationBar.titleTextAttributes objectForKey:NSFontAttributeName];
    UIColor *titleColor = [self.navigationController.navigationBar.titleTextAttributes objectForKey:NSForegroundColorAttributeName];
    
    float width = [title getDrawWidthWithFont:titleFont];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:
                           CGRectMake((CGRectGetWidth(button.frame) - width) / 2,
                                      0.0f,
                                      width,
                                      40.f)];

    [titleLable setFont:titleFont];
    [titleLable setTextColor:titleColor];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setText:title];
    [button addSubview:titleLable];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLable.frame) + 4, 17, 12, 6)];
    imageView.image = [UIImage imageNamed:@"bottom"];
    [button addSubview:imageView];
    self.navigationItem.titleView = button;

    
    
#if !__has_feature(objc_arc)
    [titleLable release];
#endif
    titleLable = nil;
}
- (void)setNavigateBarBackImage:(UIImage *)image
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setLeftBarItemWithTitle:(NSString *)title selector:(SEL)selector {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:selector];
    barItem.tintColor = [UIColor whiteColor];//h
    self.navigationItem.leftBarButtonItem = barItem;
#if !__has_feature(objc_arc)
    [barItem release];
#endif
    barItem = nil;
}

- (UIBarButtonItem *)leftBarItem {
    return self.navigationItem.leftBarButtonItem;
}

- (void)setRightBarItemWithTitle:(NSString *)title selector:(SEL)selector {
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:title
//                                                                style:UIBarButtonItemStylePlain
//                                                               target:self
//                                                               action:selector];
//
//    barItem.tintColor = [UIColor whiteColor];//h
//    self.navigationItem.rightBarButtonItem = barItem;
    
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
    backButton.frame = CGRectMake(0, 0, 80, 40);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    barItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = barItem;
#if !__has_feature(objc_arc)
    [barItem release];
#endif
    barItem = nil;
}


//设置导航栏上面的点击按钮图片
- (void)setLeftBarItemTitleWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector{
    

    NSString *topString = @"返回";
    NSArray *array = self.navigationController.viewControllers;
    UIViewController *targetViewController = nil;
    for(int i = 0;i < array.count ;i++){
        UIViewController *controller = [array objectAtIndex:i];
        if([controller isMemberOfClass:[self class]]){
            targetViewController = [array objectAtIndex_conver:i - 1];
            topString = targetViewController.title;
            if(topString.length < 1) topString = @"返回";
            break;
        }
    }
    CGSize size = [topString sizeWithFont:[UIFont systemFontOfSize:18.0f]];
    
    UIImage *backImg = [UIImage imageNamed:Image];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, backImg.size.width + size.width, MAX(backImg.size.height, size.height))];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
    backBtn.contentMode = UIViewContentModeLeft;
    [backBtn setImage:backImg forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];

    [backBtn setTitle:topString forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:79.0f/255 green:139.0f/255 blue:233.0f/255 alpha:1.0f]
                  forState:UIControlStateHighlighted];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    barItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = barItem;
    
#if !__has_feature(objc_arc)
    [barItem release];
#endif
    barItem = nil;
}

- (void)setLeftBarItemWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([Image isEqualToString:@"back"])
    {
        backButton.frame = CGRectMake(0, 0, 13, 25);
    }
    else
    {
        backButton.frame = CGRectMake(0, 0, 25, 25);
    }

    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [backButton setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    barItem.style = UIBarButtonItemStylePlain;
    
    self.navigationItem.leftBarButtonItem = barItem;
    
#if !__has_feature(objc_arc)
    [barItem release];
#endif
    barItem = nil;
}

- (void)setRightBarItemWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton setImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    barItem.style = UIBarButtonItemStylePlain;
    
    self.navigationItem.rightBarButtonItem = barItem;
    
#if !__has_feature(objc_arc)
    [barItem release];
#endif
    barItem = nil;
}

- (void)setRightBarItemWithImage:(NSString *)leftImage :(NSString *)rightImage
                  HighlightImage:(NSString*)leftHighImage :(NSString *)rightHighImage
                        selector:(SEL)leftSelector :(SEL)rightSelector
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:leftHighImage] forState:UIControlStateHighlighted];
    
    [backButton addTarget:self action:leftSelector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    leftBarItem.style = UIBarButtonItemStylePlain;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:rightHighImage] forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:rightSelector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    rightBarItem.style = UIBarButtonItemStylePlain;
    
    self.navigationItem.rightBarButtonItems = @[rightBarItem,leftBarItem];
    
#if !__has_feature(objc_arc)
    [leftBarItem release];
    [rightBarItem release];
#endif
    leftBarItem = nil;
    rightBarItem = nil;
}

- (UIBarButtonItem *)rightBarItem {
    return self.navigationItem.rightBarButtonItem;
}

- (void)setLeftBarItemWithTitle:(NSString *)title
                backgroundImage:(UIImage *)image
               backgroundImageH:(UIImage *)imageH
                           icon:(UIImage *)icon
                          iconH:(UIImage *)iconH
                       selector:(SEL)selector {
    self.navigationItem.leftBarButtonItem = [self barButtonItemWithTitle:title
                                                         backgroundImage:image
                                                        backgroundImageH:imageH
                                                                    icon:icon
                                                                   iconH:iconH
                                                                selector:selector];
}

- (void)setRightBarItemWithTitle:(NSString *)title
                 backgroundImage:(UIImage *)image
                backgroundImageH:(UIImage *)imageH
                            icon:(UIImage *)icon
                           iconH:(UIImage *)iconH
                        selector:(SEL)selector {
    self.navigationItem.rightBarButtonItem = [self barButtonItemWithTitle:title
                                                          backgroundImage:image
                                                         backgroundImageH:imageH
                                                                     icon:icon
                                                                    iconH:iconH
                                                                 selector:selector];
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                            backgroundImage:(UIImage *)image
                           backgroundImageH:(UIImage *)imageH
                                       icon:(UIImage *)icon
                                      iconH:(UIImage *)iconH
                                   selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    if (imageH != nil) {
        [button setBackgroundImage:imageH forState:UIControlStateHighlighted];
    }
    
    if (icon != nil) {
        [button setImage:icon forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    }
    
    if (iconH != nil) {
        [button setImage:iconH forState:UIControlStateHighlighted];
    }
    
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    [button.titleLabel setFont:font];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [button.titleLabel setShadowColor:[UIColor darkGrayColor]
                              opacity:1.0f
                               offset:CGSizeMake(0.0f, 1.0f)
                           blurRadius:0.0f];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return MenuSifu_AUTORELEASE(barItem);
}

- (void)setLeftBarItemWithTitle:(NSString *)title
                backgroundImage:(UIImage *)image
               backgroundImageH:(UIImage *)imageH
                          width:(CGFloat)width
                         height:(CGFloat)height
                       fontSize:(CGFloat)size
                       selector:(SEL)selector {
    self.navigationItem.leftBarButtonItem = [self barButtonItemWithTitle:title
                                                         backgroundImage:image
                                                        backgroundImageH:imageH
                                                                   width:width
                                                                  height:height
                                                                fontSize:size
                                                                selector:selector];
}

- (void)setRightBarItemWithTitle:(NSString *)title
                 backgroundImage:(UIImage *)image
                backgroundImageH:(UIImage *)imageH
                           width:(CGFloat)width
                          height:(CGFloat)height
                        fontSize:(CGFloat)size
                        selector:(SEL)selector {
    self.navigationItem.rightBarButtonItem = [self barButtonItemWithTitle:title
                                                          backgroundImage:image
                                                         backgroundImageH:imageH
                                                                    width:width
                                                                   height:height
                                                                 fontSize:size
                                                                 selector:selector];
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                            backgroundImage:(UIImage *)image
                           backgroundImageH:(UIImage *)imageH
                                      width:(CGFloat)width
                                     height:(CGFloat)height
                                   fontSize:(CGFloat)size
                                   selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    if (imageH != nil) {
        [button setBackgroundImage:imageH forState:UIControlStateHighlighted];
    }
    
    UIFont *font = [UIFont boldSystemFontOfSize:size];
    [button.titleLabel setFont:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [button.titleLabel setShadowColor:[UIColor darkGrayColor]
                              opacity:1.0f
                               offset:CGSizeMake(0.0f, 1.0f)
                           blurRadius:0.0f];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setFrame:CGRectMake(0, 0, width, height)];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return MenuSifu_AUTORELEASE(barItem);
}

- (void)pushController:(UIViewController *)viewController {
    [self pushController:viewController withAnimated:YES];
}

- (void)pushController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self pushViewController:viewController animated:animated];
    } else if (self.navigationController != nil) {
        [self.navigationController pushViewController:viewController animated:animated];
    } else {
        if (viewController == self) {
            return ;
        }
#if !__has_feature(objc_arc)
        [viewController retain];
#endif
        [viewController viewWillAppear:YES];
        [self.view pushView:viewController.view completion:^(BOOL finished) {
            [viewController viewDidAppear:YES];
        }];
    }
}


- (void)popController {
    [self popControllerWithAnimated:YES];
}

- (void)popControllerWithAnimated:(BOOL)Animated{
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self popViewControllerAnimated:Animated];
    }
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:Animated];
    } else {
        [self viewWillDisappear:Animated];
        [self.view popCompletion:^(BOOL finished) {
            [self viewDidDisappear:Animated];
#if !__has_feature(objc_arc)
            [self release];
#endif
        }];
    }
}

- (void)presentController:(UIViewController *)viewController {
    [self presentController:viewController withAnimated:YES];
}

- (void)presentController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    [self presentViewController:viewController animated:animated completion:nil];
}

- (void)dismissModalController {
    if (self.navigationController != nil) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)presentWithNavigationController:(UIViewController *)viewController {
    [self presentWithNavigationController:viewController withAnimated:YES];
}

- (void)presentWithNavigationController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if (viewController != nil) {
        UINavigationController *navController = nil;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            navController = (UINavigationController *)viewController;
        } else {
            navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        [self presentViewController:navController animated:animated completion:nil];
#if !__has_feature(objc_arc)
        [navController release];
#endif
        navController = nil;
    }
}

- (void)close {
    [self dismissModalController];
    [self popController];
}

@end
