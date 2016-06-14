//
//  UIImage+Extension.h
//  Dingding
//
//  Created by 陈欢 on 14-3-3.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  创建圆形图
 *
 *  @param image 原图
 *  @param inset 缩进
 *
 *  @return 圆形图
 */
+ (UIImage*)circleImage:(UIImage*) image withParam:(CGFloat) inset;

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset withSize:(CGSize)imageSize;

+ (UIImage*)circleImageWithRadius:(CGFloat)radius Color:(UIColor *)color;

+ (UIImage*)cornerImage:(UIImage*)image withParam:(CGFloat)corner withSize:(CGSize)imageSize;

+ (UIImage*)verticalBarWithWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size;

+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size;

- (NSData *)compressedData:(CGFloat)compressionQuality;

- (CGFloat)compressionQuality;

- (NSData *)compressedData;
@end
