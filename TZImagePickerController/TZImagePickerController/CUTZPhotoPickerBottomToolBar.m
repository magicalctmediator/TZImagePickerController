//
//  CUTZPhotoPickerBottomToolBar.m
//  TZImagePickerController
//
//  Created by mengxiang on 2020/11/15.
//  Copyright © 2020 谭真. All rights reserved.
//

#import "CUTZPhotoPickerBottomToolBar.h"
#define kMain_Screen_Width [UIScreen mainScreen].bounds.size.width
#define kMain_Screen_Height [UIScreen mainScreen].bounds.size.height

@interface CUTZPhotoPickerBottomToolBar()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CUTZPhotoPickerBottomToolBar

- (UITableView *)showImgTableView{
    if (!_showImgTableView) {
        _showImgTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _showImgTableView.transform=CGAffineTransformMakeRotation(-M_PI / 2);
        _showImgTableView.showsVerticalScrollIndicator=NO;
        _showImgTableView.delegate = self;
        _showImgTableView.dataSource = self;
        _showImgTableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
        _showImgTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _showImgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_showImgTableView registerClass:[CUShowTableViewCell class] forCellReuseIdentifier:@"CUShowTableViewCell"];
    }
    return _showImgTableView;
}
- (UIButton *)doneButton{
    if(!_doneButton){
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.backgroundColor = UIColor.whiteColor;
        _doneButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _doneButton.layer.cornerRadius = 17.5f;
        [_doneButton setTitleColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    return _doneButton;
}

 - (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        [self addSubview:self.showImgTableView];
        [self addSubview:self.doneButton];
        [self.doneButton sizeToFit];
        self.doneButton.frame = CGRectMake(kMain_Screen_Width - 74 - 15, 22.5, 74, 35);
        self.showImgTableView.frame = CGRectMake(0, 0, kMain_Screen_Width - 105, 68);
    }
    return self;
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tzImagePickerController.selectedModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *selectedModels = [NSArray arrayWithArray:self.tzImagePickerController.selectedModels];
    CUShowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CUShowTableViewCell"];
    cell.contentView.backgroundColor = self.tzImagePickerController.cu_BottomBarColor?self.tzImagePickerController.cu_BottomBarColor:UIColor.blackColor;
    TZAssetModel * model = selectedModels[indexPath.row];
    [[TZImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        cell.imgView.image = photo;
        cell.deleteBtn.tag = indexPath.row;
    }];
    [cell.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
#pragma mark - Action
/** 完成*/
- (void)doneButtonClick{
    TZImagePickerController *tzImagePickerVc = self.tzImagePickerController;
    if (tzImagePickerVc.selectedModels.count > 0 ) {
        if(self.cuTZPhotoPickerToolBarImgDoneAction){
            self.cuTZPhotoPickerToolBarImgDoneAction();
        }
    }
}
/** 删除*/
-(void)deleteAction:(UIButton *)sender {
    NSArray *selectedModels = [NSArray arrayWithArray:self.tzImagePickerController.selectedModels];
    TZAssetModel *model = selectedModels[sender.tag];
    model.isSelected = NO;
    [self.tzImagePickerController removeSelectedModel:model];
    [self.showImgTableView reloadData];
    if(self.cuTZPhotoPickerToolBarImgDeleteAction){
        self.cuTZPhotoPickerToolBarImgDeleteAction();
    }
}
/** 选中预览*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.cuTZPhotoPickerToolBarImgDidSelectAction){
        self.cuTZPhotoPickerToolBarImgDidSelectAction(indexPath);
    }
}

@end









@implementation CUShowTableViewCell

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.frame = CGRectMake(0, 12, 56, 56);
        _imgView.transform=CGAffineTransformMakeRotation(M_PI / 2);
        _imgView.contentMode = UIViewContentModeScaleToFill;
        _imgView.clipsToBounds = YES;
        _imgView.layer.cornerRadius = 3;
    }
    return _imgView;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        _deleteBtn.frame = CGRectMake(46, 0, 20, 20);
        [_deleteBtn setImage:[UIImage tz_imageNamedFromMyBundle:@"cu_del_green"] forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage tz_imageNamedFromMyBundle:@"cu_del_green"] forState:UIControlStateHighlighted];
    }
    return _deleteBtn;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.deleteBtn];
    }
    return self;
}

@end
