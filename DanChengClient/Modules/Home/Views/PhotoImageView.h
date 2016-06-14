//
//  PhotoImageView.h
//  MenuSifu
//
//  Created by 高磊 on 15/7/14.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoImageView;

@protocol PhotoImageViewDelegate <NSObject>

- (void)selectImageViewWithIndex:(NSInteger)index photoImageView:(PhotoImageView *)imageView;

@end

@interface PhotoImageView : UIImageView

@property (nonatomic,assign)NSInteger index;

@property (nonatomic,weak) id <PhotoImageViewDelegate>delegate;

@end
