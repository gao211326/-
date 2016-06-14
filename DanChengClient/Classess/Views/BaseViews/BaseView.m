//
//  BaseView.m
//  MenuSifu
//
//  Created by 高磊 on 15/4/4.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)init
{
    self = [super init];
    if (self) {
        self.mainScrollView = [[UIScrollView alloc]init];
        
        self.mainScrollView.showsHorizontalScrollIndicator = self.mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.mainScrollView];
        [self.mainScrollView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.mainView = [[UIView alloc]init];
        [self.mainScrollView addSubview:self.mainView];
        [self.mainView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.mainScrollView);
            make.width.equalTo(self.mainScrollView);
        }];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
