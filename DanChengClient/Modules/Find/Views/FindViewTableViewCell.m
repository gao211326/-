//
//  FindViewTableViewCell.m
//  DanChengClient
//
//  Created by 高磊 on 15/5/14.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "FindViewTableViewCell.h"

@interface FindViewTableViewCell ()
{
    UIImageView *               _headImageView;
    UILabel *                   _headTitleLable;
//    UIImageView *               _rightIconImageView;
    UIView *                    _line;
}
@end


@implementation FindViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageView = [[UIImageView alloc]init];
        [self addSubview:_headImageView];
        
        _headTitleLable = [[UILabel alloc]init];
        [self addSubview:_headTitleLable];
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = UICOLOR_FROM_RGB(209, 209, 209);
        [self addSubview:_line];
    }
    return self;
}


+(CGFloat)findViewCellHeight
{
    return 52;
}

- (void)reloadFindCellData:(NSDictionary *)data
{
    [_headImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(GTReViewXFloat(6.5));
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(25, 25));
    }];
    
    [_headTitleLable remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.right).offset(10);
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.right).offset(30);
    }];
    
    [_line remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.bottom);
    }];
    
    [_headImageView setImage:[UIImage imageNamed:[data objectForKey:@"icon"]]];
    [_headTitleLable setText:[data objectForKey:@"title"]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
