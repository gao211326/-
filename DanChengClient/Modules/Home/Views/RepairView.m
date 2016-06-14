//
//  RepairView.m
//  DanChengClient
//
//  Created by 高磊 on 15/8/24.
//  Copyright (c) 2015年 高磊. All rights reserved.
//

#import "RepairView.h"
#import "SDPhotoBrowser.h"
#import "PhotoImageView.h"
#import "ZHPickView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "RepairButton.h"

#import "RepairManDataModels.h"

#import "VPImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define ADD_ORIGINAL_MAX_WIDTH 640.0f


@interface RepairView ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate,SDPhotoBrowserDelegate,PhotoImageViewDelegate>
{
    UITextView*             _reviewTextView;
    UILabel *               _placeholderLable;
    
    UILabel *               _startTimeLable;
    UILabel *               _endTimeLable;
    
    UIButton *              _startButton;
    UIButton *              _endButton;
    
//    UILabel *               _houseLable;
//    UILabel *               _addImageLable;
    
    
    RepairButton *          _lastRepairButton;
    
    RepairButton *          _selectedButton;
//    UILabel *               _repairLable;
    
    UIView *                _addImageViewBackView;
    
//    UIButton *              _addHouseButton;
    UIButton *              _addImageButton;
//    UIButton *              _besureButton;
    NSMutableArray *        _addImageArray;
    
    
    ZHPickView *            _pickView;
    ZHPickView *            _endPickView;
    PhotoImageView *        _lastGoodImageView;
}
@end

@implementation RepairView

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xeeeeee);
        
        self.selected = NO;
        
        _addImageArray = [[NSMutableArray alloc] init];
        
        _reviewTextView = [[UITextView alloc]init];
        _reviewTextView.delegate = (id)self;
        _reviewTextView.font = [UIFont systemFontOfSize:14];
        [self.mainView addSubview:_reviewTextView];
        
        _placeholderLable = [[UILabel alloc]init];
        _placeholderLable.enabled = NO;
        _placeholderLable.text = @"请输入报修内容";
        _placeholderLable.textColor = UICOLOR_FROM_RGB_OxFF(0xd8d8d8);
        _placeholderLable.font = [UIFont systemFontOfSize:14];
        [_reviewTextView addSubview:_placeholderLable];
        
        
        _startTimeLable = [[UILabel alloc]init];
        _startTimeLable.textColor = UICOLOR_FROM_RGB_OxFF(0x3b3b3b);
        _startTimeLable.font = [UIFont systemFontOfSize:14];
        _startTimeLable.text = @"预约维修时间:";
        [self.mainView addSubview:_startTimeLable];
        
        _endTimeLable = [[UILabel alloc]init];
        _endTimeLable.textColor = UICOLOR_FROM_RGB_OxFF(0x3b3b3b);
        _endTimeLable.font = [UIFont systemFontOfSize:14];
        _endTimeLable.text = @"维修完成时间:";
        [self.mainView addSubview:_endTimeLable];
        
        
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.backgroundColor = [UIColor whiteColor];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_startButton setTitleColor:UICOLOR_FROM_RGB_OxFF(0x3b3b3b) forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_startButton setTitle:@"点击选择" forState:UIControlStateNormal];
        [self.mainView addSubview:_startButton];
        
        
        _endButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _endButton.backgroundColor = [UIColor whiteColor];
        _endButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_endButton setTitleColor:UICOLOR_FROM_RGB_OxFF(0x3b3b3b) forState:UIControlStateNormal];
        [_endButton addTarget:self action:@selector(endButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_endButton setTitle:@"点击选择" forState:UIControlStateNormal];
        [self.mainView addSubview:_endButton];

        
        
//        
//        _repairButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_repairButton addTarget:self action:@selector(repairButtonClick:) forControlEvents:UIControlEventTouchUpInside];
////        [_repairButton setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
//        [_repairButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
//        [_repairButton setImage:nil forState:UIControlStateNormal];
//        [self addSubview:_repairButton];
//
//        
//        _repairLable = [[UILabel alloc]init];
//        _repairLable.font = [UIFont systemFontOfSize:13];
//        _repairLable.textColor = UICOLOR_FROM_RGB_OxFF(0xff4940);
//        _repairLable.textAlignment = NSTextAlignmentCenter;
//        [_repairButton addSubview:_repairLable];
        
        
        _addImageViewBackView = [[UIView alloc]init];
        _addImageViewBackView.backgroundColor = [UIColor clearColor];
        [self.mainView addSubview:_addImageViewBackView];
        
        
        
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton addTarget:self action:@selector(addImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_addImageButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        [_addImageViewBackView addSubview:_addImageButton];
        

        [self makeViewConstraint];
    }
    return self;
}

- (void)makeViewConstraint
{
    [_reviewTextView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView.left).offset(GTReViewXFloat(7));
        make.right.equalTo(self.mainView.right).offset(-GTReViewXFloat(7));
        make.top.equalTo(self.mainView.top).offset(8);
        make.height.equalTo(@182);
    }];
    
    
    [_placeholderLable remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_reviewTextView.left);
        make.top.equalTo(_reviewTextView.top).offset(7);
        make.height.equalTo(@15);
        make.right.equalTo(_reviewTextView.right);
    }];
    
    
    
    [_startTimeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_reviewTextView.left);
        make.centerY.equalTo(_startButton.centerY);
        make.height.equalTo(_startButton.height);
        make.width.equalTo(@90);
    }];
    
    
    [_endTimeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_reviewTextView.left);
        make.centerY.equalTo(_endButton.centerY);
        make.height.equalTo(_startButton.height);
        make.width.equalTo(@90);
    }];
    
    
    
    

    
    [_startButton makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.left.equalTo(_startTimeLable.right);
        make.top.equalTo(_reviewTextView.bottom).offset(10);
        make.right.equalTo(_reviewTextView.right);
    }];
    
    
    [_endButton makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.left.equalTo(_startTimeLable.right);
        make.top.equalTo(_startButton.bottom).offset(10);
        make.right.equalTo(_reviewTextView.right);
    }];
    
//    
//    [_repairButton makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(70, 70));
//        make.top.equalTo(_endButton.bottom).offset(20);
//        make.left.equalTo(_endTimeLable.left);
//    }];
//    
//    
//    
//    [_repairLable makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(_repairButton.centerX);
//        make.bottom.equalTo(_repairButton.bottom);
//        make.height.equalTo(@18);
//        make.width.equalTo(_repairButton.width);
//    }];
//    
    
    [_addImageButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addImageViewBackView.left).offset(7);
        make.top.equalTo(_addImageViewBackView.top).offset(3);
        make.size.equalTo(CGSizeMake(49, 49));
    }];
    
    
    [_addImageViewBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endButton.bottom).offset(20);
        make.left.equalTo(self.mainView.left);
        make.right.equalTo(self.mainView.right);
        make.height.equalTo(@(49 + 3 +3));
    }];
    

    [self.mainView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
        make.bottom.equalTo(_addImageViewBackView.bottom).offset(40);
    }];
}

#pragma mark == private method
- (void)addGoodsImageView
{
    for (UIView *view in _addImageViewBackView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    _lastGoodImageView = nil;
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CGFloat kpadding = 0.0;
    
    if (size.width > 320)
    {
        kpadding = (size.width - 14 - 6 * 49 ) / 5;
    }
    else
    {
        kpadding = (size.width - 14 - 5 * 49 ) / 4;
    }
    
    
    
    for (int i = 0; i < _addImageArray.count; i ++)
    {
        PhotoImageView *imageButton = [[PhotoImageView alloc]init];
        imageButton.index = i;
        imageButton.delegate = (id)self;
        imageButton.userInteractionEnabled = YES;
        [_addImageViewBackView addSubview:imageButton];
        
        
        id imageData = [_addImageArray objectAtIndex:i];
        
        if ([imageData isKindOfClass:[UIImage class]])
        {
            UIImage *image = [_addImageArray objectAtIndex:i];
            [imageButton setImage:image];
        }
        
        
        if (i == 0)
        {
            [imageButton makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_addImageViewBackView.left).offset(7);
                make.top.equalTo(_addImageViewBackView.top).offset(3);
                make.size.equalTo(CGSizeMake(49, 49));
            }];
        }
        else
        {
            int m = 0;
            if ([UIScreen mainScreen].bounds.size.width > 320)
            {
                m = i % 6;
            }
            else
            {
                m = i % 5;
            }
            
            
            if (m != 0)
            {
                [imageButton makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_lastGoodImageView.right).offset(kpadding);
                    make.top.equalTo(_lastGoodImageView.top);
                    make.size.equalTo(CGSizeMake(49, 49));
                }];
            }
            else
            {
                [imageButton makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_addImageViewBackView.left).offset(7);
                    make.top.equalTo(_lastGoodImageView.bottom).offset(4);
                    make.size.equalTo(CGSizeMake(49, 49));
                }];
            }
        }
        
        _lastGoodImageView = imageButton;
        
    }
    
    
    
    _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addImageButton addTarget:self action:@selector(addImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addImageButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    [_addImageViewBackView addSubview:_addImageButton];
    
    
    if (_lastGoodImageView && _addImageArray.count == 3)
    {
        [_addImageViewBackView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mainView.left);
            make.right.equalTo(self.mainView.right);
            
            if (_lastRepairButton)
            {
                make.top.equalTo(_lastRepairButton.bottom).offset(10);
            }
            else
            {
                make.top.equalTo(_endButton.bottom).offset(20);
            }

            make.bottom.equalTo(_lastGoodImageView.bottom).offset(7);
        }];
    }
    else
    {
        [_addImageViewBackView remakeConstraints:^(MASConstraintMaker *make) {
            if (_lastRepairButton)
            {
                make.top.equalTo(_lastRepairButton.bottom).offset(10);
            }
            else
            {
                make.top.equalTo(_endButton.bottom).offset(20);
            }
            make.left.equalTo(self.mainView.left);
            make.right.equalTo(self.mainView.right);
            make.bottom.equalTo(_addImageButton.bottom).offset(3);
        }];
    }
    
    
    if (_lastGoodImageView)
    {
        if (_addImageArray.count < 3)
        {
            int m = 0;
            if ([UIScreen mainScreen].bounds.size.width > 320)
            {
                m = _addImageArray.count % 6;
            }
            else
            {
                m = _addImageArray.count % 5;
            }
            
            
            if (m != 0)
            {
                [_addImageButton makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_lastGoodImageView.right).offset(kpadding);
                    make.top.equalTo(_lastGoodImageView.top);
                    make.size.equalTo(CGSizeMake(49, 49));
                }];
            }
            else
            {
                [_addImageButton makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_addImageViewBackView.left).offset(7);
                    make.top.equalTo(_lastGoodImageView.bottom).offset(4);
                    make.size.equalTo(CGSizeMake(49, 49));
                }];
            }
        }
    }
    else
    {
        [_addImageButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_addImageViewBackView.left).offset(7);
            make.size.equalTo(CGSizeMake(49, 49));
            make.top.equalTo(_addImageViewBackView.top).equalTo(3);
        }];
    }
}


#pragma mark == public method
- (NSString *)getContentText
{
    return _reviewTextView.text;
}

- (NSMutableArray *)getImageArray
{
    NSMutableArray *imageArray = [NSMutableArray arrayWithArray:_addImageArray];
    
    return imageArray;
}

- (void)reloadRepaorData:(NSArray *)data
{
    for (int i =0;i < data.count;i++)
    {
        NSDictionary *dic = [data objectAtIndex:i];
        
        
        RepairManBaseClass *repairBaseClass = [RepairManBaseClass modelObjectWithDictionary:dic];
        
        RepairButton *_repairButton = [RepairButton buttonWithType:UIButtonTypeCustom];
        [_repairButton addTarget:self action:@selector(repairButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [_repairButton setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        [_repairButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [_repairButton setImage:nil forState:UIControlStateNormal];
        [self.mainView addSubview:_repairButton];
        
        
        UILabel *_repairLable = [[UILabel alloc]init];
        _repairLable.font = [UIFont systemFontOfSize:13];
        _repairLable.textColor = [UIColor blackColor];
        _repairLable.textAlignment = NSTextAlignmentCenter;
        [_repairButton addSubview:_repairLable];

        [_repairLable setText:repairBaseClass.userName];
        [_repairButton sd_setBackgroundImageWithURL:[NSURL URLWithString:repairBaseClass.userPicture]
                                           forState:UIControlStateNormal
                                   placeholderImage:[UIImage imageNamed:@"userDefult"]];
        _repairButton.repairId = [NSString stringWithFormat:@"%.0f",repairBaseClass.userId];
        
        if (i == 0)
        {
            [_repairButton makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(70, 70));
                make.top.equalTo(_endButton.bottom).offset(20);
                make.left.equalTo(_endTimeLable.left);
            }];
            
            
            
            [_repairLable makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_repairButton.centerX);
                make.bottom.equalTo(_repairButton.bottom);
                make.height.equalTo(@18);
                make.width.equalTo(_repairButton.width);
            }];
            
            _lastRepairButton = _repairButton;
        }
        else
        {
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat padding = (width - GTReViewXFloat(14) - 210) / 2;
            
            int yushu = i % 3;
            
            if (yushu == 0)
            {
                [_repairButton makeConstraints:^(MASConstraintMaker *make) {
                    make.size.equalTo(CGSizeMake(70, 70));
                    make.top.equalTo(_lastRepairButton.bottom).offset(10);
                    make.left.equalTo(_endTimeLable.left);
                }];
                
                [_repairLable makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(_repairButton.centerX);
                    make.bottom.equalTo(_repairButton.bottom);
                    make.height.equalTo(@18);
                    make.width.equalTo(_repairButton.width);
                }];
                
                _lastRepairButton = _repairButton;
            }
            else
            {
                [_repairButton makeConstraints:^(MASConstraintMaker *make) {
                    make.size.equalTo(CGSizeMake(70, 70));
                    make.top.equalTo(_lastRepairButton.top);
                    make.left.equalTo(_lastRepairButton.right).offset(padding);
                }];
                
                
                [_repairLable makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(_repairButton.centerX);
                    make.bottom.equalTo(_repairButton.bottom);
                    make.height.equalTo(@18);
                    make.width.equalTo(_repairButton.width);
                }];
                
                _lastRepairButton = _repairButton;
            }
        }
    }
    
    if (_lastRepairButton)
    {
        [_addImageViewBackView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lastRepairButton.bottom).offset(20);
            make.left.equalTo(self.mainView.left);
            make.right.equalTo(self.mainView.right);
            make.height.equalTo(@(49 + 3 +3));
        }];
    }
}

#pragma mark == event response

- (void)startButtonClick:(UIButton *)sender
{
    [self endEditing:YES];
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
    _pickView = [[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _pickView.delegate = (id)self;
    [_pickView show];
}

- (void)endButtonClick:(UIButton *)sender
{
    [self endEditing:YES];
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
    _endPickView = [[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _endPickView.delegate = (id)self;
    [_endPickView show];
}

- (void)repairButtonClick:(RepairButton *)sender
{
    [self endEditing:YES];
    
    if (sender.selected)
    {
        return;
    }
    
    sender.selected = YES;
    
    if (_selectedButton)
    {
        _selectedButton.selected = NO;
    }
    
    _selectedButton = sender;
    
    
    self.selected = sender.selected;
    self.repairId = sender.repairId;
}

- (void)addImageButtonClick:(UIButton *)sender
{
    [self endEditing:YES];
    
    [self processUserHeadButton];
}

#pragma mark == ZHPickViewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if (_pickView == pickView)
    {
        self.startTimeString = resultString;
        
        [_startButton setTitle:resultString forState:UIControlStateNormal];
    }
    else if (_endPickView == pickView)
    {
        self.endTimeString = resultString;
        
        [_endButton setTitle:resultString forState:UIControlStateNormal];
    }
}


#pragma mark == textView delegate

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        _placeholderLable.text = @"请输入报修内容";
    }
    else
    {
        _placeholderLable.text = @"";
    }
}

#pragma mark == PhotoImageView delegate

- (void)selectImageViewWithIndex:(NSInteger)index photoImageView:(PhotoImageView *)imageView
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = imageView.superview;// 原图的父控件
    browser.imageCount = _addImageArray.count; // 图片总数
    browser.currentImageIndex = (int)index;
    browser.delegate = (id)self;
    [browser show];
}

#pragma mark - photobrowser代理方法

- (void)photoBrowserDelete:(SDPhotoBrowser *)browser imageForIndex:(NSInteger)index
{
//    [browser]
    [_addImageArray removeObjectAtIndex:index];
    
    [self addGoodsImageView];
}

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    //[UIImage imageNamed:@"iconNomal"];
    UIImage *image = [_addImageArray objectAtIndex:index];
    
    return image;
}



//// 返回高质量图片的url
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *urlStr = [_addImageArray objectAtIndex:index];
//    return [NSURL URLWithString:urlStr];
//}



#pragma mark - processUserHeadButton
- (void)processUserHeadButton
{
    //取消头像修改功能
    UIActionSheet *actionSheet = [UIActionSheet new];
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"拍照", nil)];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"选择本地照片", nil)];
    
    [actionSheet setCancelButtonIndex:[actionSheet addButtonWithTitle:NSLocalizedString(@"取消", nil)]];
    
    for (UIView *view in actionSheet.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    [actionSheet setDelegate:self];
    
    [actionSheet showInView:self];
}

#pragma mark ==========================================
#pragma mark ==ActionSheetDelegate
#pragma mark ==========================================
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:NSLocalizedString(@"拍照", nil)])
    {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = (id)self;
            [self.viewController presentViewController:controller
                                              animated:YES
                                            completion:^(void){
                                                NSLog(@"Picker View Controller is presented");
                                            }];
        }
    }
    else if ([buttonTitle isEqualToString:NSLocalizedString(@"选择本地照片", nil)])
    {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self.viewController presentViewController:controller
                                              animated:YES
                                            completion:^(void){
                                                NSLog(@"Picker View Controller is presented");
                                            }];
        }
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // present the cropper view controller
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self.viewController presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage
                          sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie
            sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage
            sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType
                  sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ADD_ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ADD_ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ADD_ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ADD_ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ADD_ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    [_addImageArray addObject:editedImage];
    [self addGoodsImageView];
    
    //    NSData *imageData = nil;
    //    if (UIImagePNGRepresentation(editedImage) == nil) {
    //        imageData = UIImageJPEGRepresentation(editedImage, 1);
    //    } else {
    //        imageData = UIImagePNGRepresentation(editedImage);
    //    }
    
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
