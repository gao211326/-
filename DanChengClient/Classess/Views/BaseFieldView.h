//
//  BaseFieldView.h
//  DanChengClient
//
//  Created by 高磊 on 15/5/16.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFieldView : UIView

- (id)initWithHeadImage:(NSString *)headImage
               headName:(NSString *)headname
              fieldText:(NSString *)fieldtext;

- (void)reloadInputText:(NSString *)inputText;

- (NSString *)getInputText;

- (void)secureTextEntry:(BOOL)secure;

@end
