//
//  GH_ComplaintsView_AddPhotoView.m
//  im
//
//  Created by ZhiYuan on 2020/4/10.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_ComplaintsView_AddPhotoView.h"
#import "WPhotoViewController.h"
@interface GH_ComplaintsView_AddPhotoView ()

@property(nonatomic, strong)UILabel * titleLables;

@property (nonatomic, strong)UILabel * countLable;

@property (nonatomic, strong)UIView * photoView;

@property (nonatomic, copy)NSMutableArray * photoArray;
@property (nonatomic, strong)NSMutableArray * temp;//视图数组
@end


@implementation GH_ComplaintsView_AddPhotoView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self addSubview:self.titleLables];
    [self addSubview:self.countLable];
    [self addSubview:self.photoView];
    self.titleLables.sd_layout
    .leftSpaceToView(self, ZY_WidthScale(15))
    .topSpaceToView(self, ZY_HeightScale(15))
    .widthIs(100)
    .heightIs(ZY_HeightScale(15));
    
    self.countLable.sd_layout
    .rightSpaceToView(self, ZY_WidthScale(15))
    .centerYEqualToView(self.titleLables)
    .widthIs(100)
    .heightIs(15);
    
    self.photoView.sd_layout
    .leftSpaceToView(self, ZY_WidthScale(5))
    .topSpaceToView(self.titleLables, ZY_HeightScale(25))
    .rightSpaceToView(self, ZY_WidthScale(5))
    .autoHeightRatio(0);
    [self layoutViews];
}
- (void)layoutViews{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.temp removeAllObjects];
    for (int i = 0; i < self.photoArray.count; i++) {
        UIImageView * img = [UIImageView new];
        img.sd_cornerRadius = @(ZY_WidthScale(6));
        img.clipsToBounds = YES;
        img.image = self.photoArray[i];
        img.userInteractionEnabled = YES;
        img.layer.cornerRadius = ZY_WidthScale(6);
        [self.photoView addSubview:img];
        img.sd_layout
        .autoHeightRatio(1);
        [self.temp addObject:img];
        
        UIButton * deleteBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBt setImage:Images(@"deletePhoto") forState:UIControlStateNormal];
        deleteBt.tag = 908790900980 + i;
        [deleteBt addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchDown];
        deleteBt.layer.cornerRadius = 10;
        [img addSubview:deleteBt];
        deleteBt.sd_layout.topSpaceToView(img, 3)
        .rightSpaceToView(img, 3)
        .widthIs(20)
        .heightIs(20);
        
    }
    if (self.photoArray.count < 3) {
        UIButton * selectPhotoBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectPhotoBt setImage:Images(@"My_Add1") forState:UIControlStateNormal];;
//        selectPhotoBt.sd_cornerRadius = @(ZY_WidthScale(6));
//        selectPhotoBt.layer.borderColor = Colors(@"#E5E5E5").CGColor;
//        selectPhotoBt.layer.borderWidth = 1;
        selectPhotoBt.clipsToBounds = YES;
        [selectPhotoBt addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchDown];
        [self.photoView addSubview:selectPhotoBt];
        selectPhotoBt.sd_layout
        .autoHeightRatio(1);
        [self.temp addObject:selectPhotoBt];
    }else{
    }
//    [self.photoView setupAutoWidthFlowItems:self.temp withPerRowItemsCount:3 verticalMargin:10 horizontalMargin:10 verticalEdgeInset:0 horizontalEdgeInset:10];
    [self.photoView setupAutoMarginFlowItems:self.temp withPerRowItemsCount:3 itemWidth:ZY_WidthScale(68.5) verticalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    [self setupAutoHeightWithBottomView:self.photoView bottomMargin:10];
    [self.photoView updateLayout];
    [self updateLayout];
    NSLog(@"photoView---%.f", self.photoView.frame.size.height);
    if (self.addPhotoBlock) {
        self.addPhotoBlock(self.photoArray);
    }
}
/**
 添加图片
 */
- (void)addPhoto{
    WeakSelf;
    WPhotoViewController * photoVC = [WPhotoViewController new];
    photoVC.selectPhotoOfMax = 3 - self.photoArray.count;
    photoVC.selectPhotosBack = ^(NSMutableArray *photosArr) {
        for (NSDictionary * photoDic in photosArr) {
            UIImage * photoImage = photoDic[@"image"];
            [self.photoArray addObject:photoImage];
        }
        [weakSelf layoutViews];
        weakSelf.countLable.text = [NSString stringWithFormat:@"(%ld/3)", self.photoArray.count];
    };
    UIViewController * v = [GH_Tools findVisibleViewController];
    [v presentViewController:photoVC animated:YES completion:nil];
}

- (void)deleteAction:(UIButton *)sender{
    [self.photoArray removeObjectAtIndex:sender.tag -908790900980];
    [self layoutViews];
}

- (UILabel *)titleLables{
    if (!_titleLables) {
        _titleLables = [UILabel new];
        _titleLables.text = @"图片（选填）";
        _titleLables.textColor = Colors(@"#333333");
        _titleLables.font = [UIFont systemFontOfSize:ZY_WidthScale(15)];
    }
    return _titleLables;
}
- (UILabel *)countLable{
    if (!_countLable) {
        _countLable = [UILabel new];
        _countLable.text = @"0/3";
        _countLable.textColor = Colors(@"#333333");
        _countLable.font = [UIFont systemFontOfSize:ZY_WidthScale(15)];
        _countLable.textAlignment = NSTextAlignmentRight;
    }
    return _countLable;
}

- (UIView *)photoView{
    if (!_photoView) {
        _photoView = [UIView new];
    }
    return _photoView;
}

- (NSMutableArray *)temp{
    if (!_temp) {
        _temp = [NSMutableArray new];
    }
    return _temp;
}

- (NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableArray new];
    }
    return _photoArray;
}

@end
