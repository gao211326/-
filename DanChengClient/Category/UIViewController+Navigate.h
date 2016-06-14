//
//  UIViewController+Navigate.h
//  socialDemo
//
//  Created by 陈欢 on 14-1-2.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigate)
- (void)setTitleText:(UIFont*)font Color:(UIColor*)color;
- (void)setTitleTextView:(NSString *)title;
- (void)setTitleTextView:(NSString *)title selector:(SEL)selector;
- (void)setNavigateBarBackImage:(UIImage *)image;
- (void)setLeftBarItemWithTitle:(NSString *)title selector:(SEL)selector;
- (void)setRightBarItemWithTitle:(NSString *)title selector:(SEL)selector;

- (void)setLeftBarItemWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector;
//有返回文字和图片
- (void)setLeftBarItemTitleWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector;

- (void)setRightBarItemWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector;
- (void)setRightBarItemWithImage:(NSString *)leftImage :(NSString *)rightImage
                  HighlightImage:(NSString*)leftHighImage :(NSString *)rightHighImage
                        selector:(SEL)leftSelector :(SEL)rightSelector;

- (void)pushController:(UIViewController *)viewController;
- (void)pushController:(UIViewController *)viewController withAnimated:(BOOL)animated;
- (void)popController;
- (void)popControllerWithAnimated:(BOOL)Animated;
- (void)presentController:(UIViewController *)viewController;
- (void)dismissModalController;
@end
