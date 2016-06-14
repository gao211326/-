//
//  UIImage+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-3-3.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "UIImage+Extension.h"

#define kCompresseionDataLength (500000.0f) //最大压缩大小(50k)

@implementation UIImage (Extension)

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, inset);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:.6].CGColor);
	CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
	CGContextAddEllipseInRect(context, rect);
	CGContextClip(context);
	
	[image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
	CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset withSize:(CGSize)imageSize
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:.6].CGColor);
	CGRect rect = CGRectMake(inset, inset, imageSize.width - inset * 2.0f, imageSize.height - inset * 2.0f);
	CGContextAddEllipseInRect(context, rect);
	CGContextClip(context);
	
	[image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
	CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)cornerImage:(UIImage*)image withParam:(CGFloat)corner withSize:(CGSize)imageSize
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect rect = CGRectMake(0,
                             0,
                             imageSize.width,
                             imageSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(corner,
                                                                            corner)];
	CGContextAddPath(context, [path CGPath]);
	CGContextClip(context);
	
	[image drawInRect:rect];

    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)circleImageWithRadius:(CGFloat)radius Color:(UIColor *)color
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    CGSize imageSize = CGSizeMake(radius, radius);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
	CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextAddEllipseInRect(context, rect);
	CGContextFillPath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImage*)verticalBarWithWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    CGSize imageSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
	CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextAddRect(context, rect);
	CGContextFillPath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
+ (UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize originSize = CGSizeMake(image.size.width, image.size.height);
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    if(originSize.width < imageSize.width)
    {
        originSize.height *= imageSize.width/originSize.width;
        originSize.width = imageSize.width;
    }
    if(originSize.height < imageSize.height){
        originSize.width *= imageSize.height/originSize.height;
        originSize.height = imageSize.height;
    }
    
    CGRect frame;
    frame.origin.x = (originSize.width - imageSize.width)/2;
    frame.origin.y = (originSize.height - imageSize.height)/2;
    frame.size = imageSize;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize originSize = CGSizeMake(image.size.width, image.size.height);
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    if(originSize.width < imageSize.width)
    {
        originSize.height *= imageSize.width/originSize.width;
        originSize.width = imageSize.width;
    }
    if(originSize.height < imageSize.height){
        originSize.width *= imageSize.height/originSize.height;
        originSize.height = imageSize.height;
    }
    
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size = imageSize;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

- (NSData *)compressedData:(CGFloat)compressionQuality
{
    if (compressionQuality<=1.0 && compressionQuality >=0)
    {
        return UIImageJPEGRepresentation(self, compressionQuality);
    }
    else
    {
        return UIImageJPEGRepresentation(self, 1.f);
    }
}

- (CGFloat)compressionQuality
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger dataLength = [data length];
    if(dataLength>kCompresseionDataLength)
    {
        return 1.0-kCompresseionDataLength/dataLength;
    }
    else
    {
        return 1.0;
    }
}

- (NSData *)compressedData {
    CGFloat quality = [self compressionQuality];
    return [self compressedData:quality];
}

@end
