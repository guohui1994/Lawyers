//
//  GH_OrderSelectPhotoAndTextTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderSelectPhotoAndTextTableViewCell.h"

@interface GH_OrderSelectPhotoAndTextTableViewCell ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView * textView;//输入框
@property (nonatomic, strong)UIView * whiteView;//图片view
@property (nonatomic, copy)NSString * text;
@property (nonatomic, strong)UIButton * selectPhoto;//选择图片按钮
@property (nonatomic, strong)UIView * grayView;//灰色线条
@property (nonatomic, strong)UIButton * submitAppriaseButton;//提交评价
@property (nonatomic, strong)UILabel * appriaseLable;//评价内容
@end

@implementation GH_OrderSelectPhotoAndTextTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.whiteView];
//    [self.whiteView addSubview:self.selectPhoto];
    [self.contentView addSubview:self.grayView];
    [self.contentView addSubview:self.submitAppriaseButton];
    [self.contentView addSubview:self.appriaseLable];
    [self layout];
}

-(void)layout{

    
    self.textView.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(28))
    .rightSpaceToView(self.contentView, ZY_WidthScale(14))
    .topSpaceToView(self.contentView, ZY_HeightScale(11))
    .heightIs(ZY_HeightScale(50));
    
    self.appriaseLable.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(28))
    .rightSpaceToView(self.contentView, ZY_WidthScale(14))
    .topSpaceToView(self.contentView, ZY_HeightScale(11))
    .autoHeightRatio(0);
    
    self.whiteView.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(29))
    .topSpaceToView(self.textView, ZY_HeightScale(11))
    .rightSpaceToView(self.contentView, ZY_HeightScale(29))
    .heightIs(50);
    
    self.grayView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.whiteView, ZY_HeightScale(5))
    .heightIs(10);
    
    self.submitAppriaseButton.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.grayView, ZY_HeightScale(141))
    .widthIs(ZY_WidthScale(299))
    .heightIs(ZY_HeightScale(50));
    
    [self setupAutoHeightWithBottomView:self.submitAppriaseButton bottomMargin:25];
}

- (void)setAppriceString:(NSString *)appriceString{
    _appriceString = appriceString;
    _appriaseLable.text = appriceString;
    _textView.hidden = YES;
    _grayView.hidden = YES;
    _submitAppriaseButton.hidden = YES;
    _appriaseLable.hidden = NO;
    [self setupAutoHeightWithBottomView:self.whiteView bottomMargin:ZY_HeightScale(25)];
    [self updateLayout];
}


- (void)setPhotoArray:(NSArray *)photoArray{
    
    _photoArray = photoArray;
    NSMutableArray * temp = [NSMutableArray new];
    for (int i = 0; i< photoArray.count; i++) {
        UIImageView * images = [UIImageView new];
        images.image = photoArray[i];
        [self.whiteView addSubview:images];
        [temp addObject:images];
        images.sd_layout
        .autoHeightRatio(1);
    }
    if (photoArray.count >= 3 ) {
        self.selectPhoto.hidden = YES;
    }else{
        [self.whiteView addSubview:self.selectPhoto];
        self.selectPhoto.sd_layout
        .autoHeightRatio(1);
        if (self.appriceString.length != 0) {
            
        }else{
        [temp addObject:self.selectPhoto];
        }
    }
    
   
    [self.whiteView setupAutoMarginFlowItems:temp withPerRowItemsCount:3 itemWidth:ZY_WidthScale(76) verticalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    
    [self.whiteView updateLayout];
}

- (void)setPhotoArrayUrl:(NSArray *)photoArrayUrl{
    _photoArrayUrl = photoArrayUrl;
    NSMutableArray * temp = [NSMutableArray new];
    for (int i = 0; i< photoArrayUrl.count; i++) {
        UIImageView * images = [UIImageView new];
//        [images setImageWithURL:[NSURL URLWithString:photoArrayUrl[i]] options:nil];
        [images sd_setImageWithURL:[NSURL URLWithString:photoArrayUrl[i]]];
        [self.whiteView addSubview:images];
        [temp addObject:images];
        images.sd_layout
        .autoHeightRatio(1);
    }
     self.whiteView.sd_layout.topSpaceToView(self.appriaseLable, ZY_HeightScale(11));
    [self.whiteView setupAutoMarginFlowItems:temp withPerRowItemsCount:3 itemWidth:ZY_WidthScale(76) verticalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    [self.whiteView updateLayout];
}


- (void)setAddPicString:(NSString *)addPicString{
    _addPicString = addPicString;
    [self.selectPhoto setImage:Images(addPicString) forState:UIControlStateNormal];
}

-(void)setSubmitText:(NSString *)submitText{
    _submitText = submitText;
    [_submitAppriaseButton setTitle:submitText forState:UIControlStateNormal];
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    _textView.text = placeHolder;
}

- (void)setTex:(NSString *)tex{
    _tex = tex;
    _textView.text = tex;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.text = @"";
        _textView.font = Fonts(15);
        _textView.delegate = self;
        _textView.textColor = Colors(@"#999999");
    }
    return _textView;
}

- (UILabel *)appriaseLable{
    if (!_appriaseLable) {
        _appriaseLable = [UILabel new];
        _appriaseLable.textColor = Colors(@"#333333");
        _appriaseLable.font = Fonts(16);
        _appriaseLable.text = @"评价内容";
        _appriaseLable.hidden = YES;
        _appriaseLable.numberOfLines = 0;
    }
    return _appriaseLable;
}


- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [UIView new];
        
    }
    return _whiteView;
}

- (UIButton *)selectPhoto{
    if (!_selectPhoto) {
        _selectPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectPhoto setImage:Images(@"Order_AddPic") forState:UIControlStateNormal];
        [_selectPhoto addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchDown];
    }
    return _selectPhoto;
}


- (UIView *)grayView{
    if (!_grayView) {
        _grayView = [UIView new];
        _grayView.backgroundColor = Colors(@"#F8F8F8");
    }
    return _grayView;
}

- (UIButton *)submitAppriaseButton{
    if (!_submitAppriaseButton) {
        _submitAppriaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CAGradientLayer *  gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#BC94FE"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#856EF9"].CGColor];
        gradientLayer.locations = @[@0.0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0,  ZY_WidthScale(299),  ZY_HeightScale(50));
        [_submitAppriaseButton.layer addSublayer:gradientLayer];
        _submitAppriaseButton.sd_cornerRadius = @(ZY_WidthScale(25));
        _submitAppriaseButton.clipsToBounds = YES;
        [_submitAppriaseButton setTitle:@"提交评价" forState:UIControlStateNormal];
        [_submitAppriaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitAppriaseButton.titleLabel.font = Fonts(18);
        [_submitAppriaseButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];
    }
    return _submitAppriaseButton;
}

- (void)addPhoto{
    if (self.block) {
        self.block();
    }
}
- (void)submit{
    _submitAppriase(self.text);
}
#pragma mark ---UITextView代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:self.placeHolder]) {
        textView.text = @"";
    }else{
        textView.text = self.text;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.text = textView.text;
    _textBlock(textView.text);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
