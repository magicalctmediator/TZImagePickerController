//
//  CUTZPhotoPickerBottomToolBar.h
//  TZImagePickerController
//
//  Created by mengxiang on 2020/11/15.
//  Copyright © 2020 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZImagePickerController.h"
#import "TZImageManager.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^CUTZPhotoPickerToolBarImgDeleteAction)(void);
typedef void (^CUTZPhotoPickerToolBarImgDidSelectAction)(NSIndexPath * indexPath);
typedef void (^CUTZPhotoPickerToolBarImgDoneAction)(void);

@interface CUTZPhotoPickerBottomToolBar : UIView
/** 选中图片展示表*/
@property (nonatomic, strong) UITableView * showImgTableView;
/** 完成按钮*/
@property (nonatomic, strong) UIButton * doneButton;
/** TZImagePickerController*/
@property (nonatomic, strong) TZImagePickerController * tzImagePickerController;
/** 删除 */
@property (nonatomic, copy)CUTZPhotoPickerToolBarImgDeleteAction cuTZPhotoPickerToolBarImgDeleteAction;
/** 选中*/
@property (nonatomic, copy)CUTZPhotoPickerToolBarImgDidSelectAction cuTZPhotoPickerToolBarImgDidSelectAction;
/** 完成*/
@property (nonatomic, copy)CUTZPhotoPickerToolBarImgDoneAction cuTZPhotoPickerToolBarImgDoneAction;

@end

NS_ASSUME_NONNULL_END





NS_ASSUME_NONNULL_BEGIN

@interface CUShowTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) UIButton * deleteBtn;

@end

NS_ASSUME_NONNULL_END
