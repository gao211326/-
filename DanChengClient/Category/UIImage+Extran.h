//
//  UIImage+Extran.h
//  YingPiao2.1
//
//  Created by 高 on 14-6-4.
//  Copyright (c) 2014年 高. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extran)

/**
 *  创建圆形图
 *
 *  @param image 原图
 *  @param inset 缩进
 *
 *  @return 圆形图
 */
+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

- (NSData *)compressedData:(CGFloat)compressionQuality;

- (CGFloat)compressionQuality;
//压缩图片
- (NSData *)compressedData;
//将图片切成指定大小
+ (UIImage*)image:(UIImage*)image imageByScalingAndCroppingForSize:(CGSize)targetSize;


/**
 *  图片的毛玻璃效果
 */
- (UIImage *)applyLightEffect;

- (UIImage *)applyExtraLightEffect;

- (UIImage *)applyDarkEffect;

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


/**
 *  毛玻璃
 */

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
