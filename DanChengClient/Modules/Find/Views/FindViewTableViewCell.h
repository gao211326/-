//
//  FindViewTableViewCell.h
//  DanChengClient
//
//  Created by 高磊 on 15/5/14.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindViewTableViewCell : UITableViewCell


+ (CGFloat)findViewCellHeight;

- (void)reloadFindCellData:(NSDictionary *)data;


@end
