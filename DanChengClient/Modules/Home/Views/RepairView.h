//
//  RepairView.h
//  DanChengClient
//
//  Created by 高磊 on 15/8/24.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "BaseView.h"

@class RepairManBaseClass;

@interface RepairView : BaseView

@property (nonatomic,strong)NSString *startTimeString;

@property (nonatomic,strong)NSString *endTimeString;

@property (nonatomic)BOOL selected;

@property (nonatomic,strong) NSString *repairId;

- (void)reloadRepaorData:(NSArray *)data;

- (NSString *)getContentText;

- (NSMutableArray *)getImageArray;

@end
