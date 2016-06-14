//
//  PhotoImageView.m
//  MenuSifu
//
//  Created by 高磊 on 15/7/14.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "PhotoImageView.h"

@implementation PhotoImageView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectImageViewWithIndex:photoImageView:)])
    {
        [self.delegate selectImageViewWithIndex:self.index photoImageView:self];
    }
}

@end
