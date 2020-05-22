//
//  GH_InvitationViewController.m
//  im
//
//  Created by ZhiYuan on 2020/5/19.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_InvitationViewController.h"
#import <CoreImage/CoreImage.h>
#import "GHInviteFirendModel.h"
#import "AppDelegate.h"
@interface GH_InvitationViewController ()<AppThirdCodeDelegate>{
    SendMessageToWXReq * req;
       WXMediaMessage * message;
       WXImageObject * imageObject;
}

@property (nonatomic, strong)UIImageView * bgImage;//背景图

@property (nonatomic, strong)UIImageView * shareImage;//分享的图片

@property (nonatomic, strong)UIImageView * headerImage;//头像

@property (nonatomic, strong)UILabel * nameLable;

@property (nonatomic, strong)UILabel * phoneLable;

@property (nonatomic, strong)UIImageView * erCodeImage;

@property (nonatomic, strong)GHInviteFirendModel * model;


@end

@implementation GH_InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"邀请好友";
    self.backText = @"";
//    [self creatUI];
    [self getData];
    req = [[SendMessageToWXReq alloc] init];
       message = [WXMediaMessage message];
    imageObject = [WXImageObject object];
    AppDelegate * appdelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
       appdelegate.returnCode = self;
}

- (void)backWeiXinCode:(NSString *)weiXinCode{
    if ([weiXinCode isEqualToString:@"0"]) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"分享成功"];
    }else{
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"分享失败"];
    }
}

- (void)getData{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:inviteFriends parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        weakSelf.model = [GHInviteFirendModel mj_objectWithKeyValues:data];
        [weakSelf creatUI];
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}


- (void)creatUI{
    UIView * linewView = [UIView new];
    linewView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:linewView];
    [linewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
        make.height.equalTo(@(10));
    }];
    
    [self.view addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(linewView.mas_bottom).mas_offset(ZY_HeightScale(15));
        make.width.equalTo(@(ZY_WidthScale(345)));
        make.height.equalTo(@(ZY_HeightScale(432)));
    }];
    
    [self.shareImage sd_setImageWithURL:[NSURL URLWithString:self.model.sharePic]];
    [self.bgImage addSubview:self.shareImage];
    [self.shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImage);
        make.top.equalTo(self.bgImage).mas_offset(ZY_HeightScale(15));
        make.width.equalTo(@(ZY_WidthScale(325)));
        make.height.equalTo(@(ZY_HeightScale(312)));
    }];
    
    if (self.model.userHead.length == 0) {
        self.headerImage.image = Images(@"AppIcon");
    }else{
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:self.model.userHead] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    }
    [self.bgImage addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImage).mas_offset(ZY_WidthScale(11));
        make.top.equalTo(self.shareImage.mas_bottom).mas_offset(ZY_HeightScale(30));
        make.width.height.equalTo(@(ZY_WidthScale(60)));
    }];
    self.nameLable.text = self.model.userName;
    [self.bgImage addSubview:self.nameLable];
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImage.mas_right).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self.headerImage.mas_top).mas_offset(ZY_WidthScale(12));
    }];
    self.phoneLable.text = self.model.userPhone;
    [self.bgImage addSubview:self.phoneLable];
    [self.phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLable);
        make.top.equalTo(self.nameLable.mas_bottom).mas_offset(ZY_WidthScale(9.5));
    }];
    
    [self.bgImage addSubview:self.erCodeImage];
    [self.erCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImage.mas_right).mas_offset(-ZY_WidthScale(10));
        make.top.equalTo(self.shareImage.mas_bottom).mas_offset(ZY_HeightScale(6.5));
        make.width.equalTo(@(ZY_HeightScale(83.5)));
    }];
    
    UIView * linew1 = [UIView new];
    linew1.backgroundColor = Colors(@"#DEDDDD");
    [self.view addSubview:linew1];
    [linew1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
        make.top.equalTo(self.bgImage.mas_bottom).mas_offset(ZY_HeightScale(10));
    }];
   
    UILabel * lable = [UILabel new];
    lable.text = @"1";
    lable.textColor = Colors(@"#333333");
    lable.font = Fonts(13);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = Colors(@"#F2F2F2");
    lable.layer.cornerRadius = ZY_WidthScale(8.25);
    lable.clipsToBounds = YES;
    [self.view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(linew1.mas_bottom).mas_offset(ZY_HeightScale(11));
        make.width.height.equalTo(@(ZY_WidthScale(16.5)));
    }];
    UILabel * lable1 = [UILabel new];
    lable1.text = @"发送邀请码给好友";
    lable1.textColor = Colors(@"#333333");
    lable1.font = Fonts(14);
    [self.view addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lable);
        make.left.equalTo(lable.mas_right).mas_offset(ZY_WidthScale(5.5));
    }];
    
    UILabel * lable2 = [UILabel new];
   lable2.text = @"2";
   lable2.textColor = Colors(@"#333333");
   lable2.font = Fonts(13);
   lable2.backgroundColor = Colors(@"#F2F2F2");
   lable2.layer.cornerRadius = ZY_WidthScale(8.25);
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.clipsToBounds = YES;
    [self.view addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(lable.mas_bottom).mas_offset(ZY_HeightScale(11));
        make.width.height.equalTo(@(ZY_WidthScale(16.5)));
    }];
    UILabel * lable3 = [UILabel new];
    lable3.text = @"好友微信长按识别/扫描二维码进行注册并下载APP";
    lable3.textColor = Colors(@"#333333");
    lable3.font = Fonts(14);
    [self.view addSubview:lable3];
    [lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lable2);
        make.left.equalTo(lable.mas_right).mas_offset(ZY_WidthScale(5.5));
    }];
    
    UIView * linew2 = [UIView new];
    linew2.backgroundColor = Colors(@"#DEDDDD");
    [self.view addSubview:linew2];
    [linew2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
        make.top.equalTo(lable2.mas_bottom).mas_offset(ZY_HeightScale(9));
    }];
    
    UIButton * weChat = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChat setTitle:@"立即邀请微信好友" forState:UIControlStateNormal];
    [weChat setTitleColor:Colors(@"#333333") forState:UIControlStateNormal];
    weChat.titleLabel.font = Fonts(15);
    [weChat setImage:Images(@"Share_WeChat") forState:UIControlStateNormal];
    weChat.backgroundColor = Colors(@"#F2F2F2");
    weChat.layer.cornerRadius = ZY_WidthScale(20);
    weChat.clipsToBounds = YES;
    [weChat addTarget:self action:@selector(weChat) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:weChat];
    [weChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(linew2.mas_bottom).mas_offset(ZY_HeightScale(15));
        make.width.equalTo(@(ZY_WidthScale(165)));
        make.height.equalTo(@(ZY_HeightScale(40)));
    }];
    
    UIButton * friendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendBt setTitle:@"分享到朋友圈" forState:UIControlStateNormal];
       [friendBt setTitleColor:Colors(@"#333333") forState:UIControlStateNormal];
       friendBt.titleLabel.font = Fonts(15);
       [friendBt setImage:Images(@"Share_Firend") forState:UIControlStateNormal];
       friendBt.backgroundColor = Colors(@"#F2F2F2");
       friendBt.layer.cornerRadius = ZY_WidthScale(20);
       friendBt.clipsToBounds = YES;
    [friendBt addTarget:self action:@selector(shareFriedAction) forControlEvents:UIControlEventTouchDown];
       [self.view addSubview:friendBt];
       [friendBt mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.view.mas_right).mas_offset(-ZY_WidthScale(15));
           make.top.equalTo(linew2.mas_bottom).mas_offset(ZY_HeightScale(15));
           make.width.equalTo(@(ZY_WidthScale(165)));
           make.height.equalTo(@(ZY_HeightScale(40)));
       }];
}

- (void)weChat{
    UIImage * image = [self syntheticWithImage];
        UIImageView * imageView = [UIImageView new];
   UIImage * cornadiusImage = [self imageWithCornerRadius:5 image:[self imageWithColor:[UIColor redColor] image:image]];
    UIImage * finallImage = [self syntheticFinallImage:cornadiusImage];
    imageView.image =[self imageWithName:self.model.userName phone:self.model.userPhone addToImage:finallImage];
    [self share:[self imageWithName:self.model.userName phone:self.model.userPhone addToImage:finallImage] type:0];
}
- (void)shareFriedAction{
    UIImage * image = [self syntheticWithImage];
         UIImageView * imageView = [UIImageView new];
    UIImage * cornadiusImage = [self imageWithCornerRadius:5 image:[self imageWithColor:[UIColor redColor] image:image]];
     UIImage * finallImage = [self syntheticFinallImage:cornadiusImage];
     imageView.image =[self imageWithName:self.model.userName phone:self.model.userPhone addToImage:finallImage];
     [self share:[self imageWithName:self.model.userName phone:self.model.userPhone addToImage:finallImage] type:1];
}

- (void)share:(UIImage *)image type:(NSInteger)type{//0是微信1是朋友圈
    NSData * imageDate = UIImageJPEGRepresentation(image, 1.0);
    UIImage * compressImage = [GH_InvitationViewController compressImage:image toByte:32765];
    imageObject.imageData = imageDate;
//    message.thumbData = UIImageJPEGRepresentation(compressImage, 1.0);
    message.mediaObject = imageObject;
    req.bText = NO;
    req.message = message;
    if (type == 0) {
        req.scene = WXSceneSession;
    }else{
        req.scene = WXSceneTimeline;
    }
    
    [WXApi sendReq:req];
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [UIImageView new];
        _bgImage.layer.cornerRadius = ZY_WidthScale(10);
        _bgImage.backgroundColor = Colors(@"#F2F2F2");
    }
    return _bgImage;
}

- (UIImageView *)shareImage{
    if (!_shareImage) {
        _shareImage = [UIImageView new];
//        _shareImage.backgroundColor = [UIColor redColor];
    }
    return _shareImage;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [UIImageView new];
//        _headerImage.backgroundColor = [UIColor redColor];
        _headerImage.layer.cornerRadius = ZY_WidthScale(30);
        _headerImage.clipsToBounds = YES;
    }
    return _headerImage;
}

-(UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [UILabel new];
        _nameLable.textColor = Colors(@"#333333");
        _nameLable.font = BoldFont(17);
        _nameLable.text = @"王律师";
    }
    return _nameLable;
}

- (UILabel *)phoneLable{
    if (!_phoneLable) {
        _phoneLable = [UILabel new];
        _phoneLable.text = @"16600002218";
        _phoneLable.textColor = Colors(@"#333333");
        _phoneLable.font = Fonts(14);
    }
    return _phoneLable;
}

- (UIImageView *)erCodeImage{
    if (!_erCodeImage) {
        _erCodeImage = [UIImageView new];
        [self generatingTwoDimensionalCode];
    }
    return _erCodeImage;
}

//生成二维码
-(void)generatingTwoDimensionalCode {
    // 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 过滤器恢复默认
    [filter setDefaults];
    // 给过滤器添加数据
    NSString *string = self.model.url; // 以百度为例
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];// 此时的 image 是模糊的
    
    // 高清处理：将获取到的二维码添加到 imageview
    self.erCodeImage.image =[self createNonInterpolatedUIImageFormCIImage:image withSize:ZY_HeightScale(83.5)];// withSize 大于等于视图显示的尺寸
}

//--生成高清二维码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建 bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存 bitmap 到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


//合成图片---先生成的背景图片
- (UIImage *)syntheticWithImage{
//    CGImageRef imageRef = self.shareImage.image.CGImage;
//    CGFloat w = CGImageGetWidth(imageRef);
//    CGFloat h = CGImageGetHeight(imageRef);
     UIGraphicsBeginImageContext(CGSizeMake(ZY_WidthScale(351), ZY_HeightScale(432)));
    [self.shareImage.image drawInRect:CGRectMake(ZY_WidthScale(0), ZY_HeightScale(0), ZY_WidthScale(351), ZY_HeightScale(432))];
//    [self.erCodeImage.image drawInRect:CGRectMake(ZY_WidthScale(225), ZY_HeightScale(333), ZY_HeightScale(83.5), ZY_HeightScale(83.5))];
//    [[self circleImageWithName:self.headerImage.image borderWidth:0 borderColor:[UIColor clearColor]] drawInRect:CGRectMake(ZY_WidthScale(11), ZY_HeightScale(357), ZY_WidthScale(60), ZY_WidthScale(60))];
    //生成图片
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    //释放上下文
    UIGraphicsEndImageContext();
    return resultingImage;
}
//把生成的图片进行圆角处理
- (UIImage*)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image{
   CGRect rect = (CGRect){0 ,0, image.size};
   // size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
   // opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
   // scale—–缩放因子
   UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
   // 根据矩形画带圆角的曲线
   [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10] addClip];
   [image drawInRect:rect];
   // 图片缩放，是非线程安全的
   UIImage * images = UIGraphicsGetImageFromCurrentImageContext();
   // 关闭上下文
   UIGraphicsEndImageContext();
   return images;
}

//图片处理成圆形
- (UIImage *)circleImageWithName:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage =image;
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 8.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color image:(UIImage *)image{
   UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
   CGContextRef context = UIGraphicsGetCurrentContext();
   CGContextTranslateCTM(context, 0, image.size.height);
   CGContextScaleCTM(context, 1.0, -1.0);
   CGContextSetBlendMode(context, kCGBlendModeNormal);
   CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
   CGContextClipToMask(context, rect, image.CGImage);
   [Colors(@"#F2F2F2") setFill];
   CGContextFillRect(context, rect);
   UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return newImage;
}
//生成最终图片
- (UIImage *)syntheticFinallImage:(UIImage *)image{
//    UIGraphicsBeginImageContext(image.size);
    // 得到图片绘制上下文，指定绘制区域
       UIGraphicsBeginImageContext(CGSizeMake(ZY_WidthScale(351), ZY_HeightScale(423)));
       
      
       
       // 从当前图片上下文中得到image
//       UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        // Draw image1
    [image drawInRect:CGRectMake(0, 0, ZY_WidthScale(351), ZY_HeightScale(423))];
       [self.shareImage.image drawInRect:CGRectMake(ZY_WidthScale(10), ZY_HeightScale(15), ZY_WidthScale(325), ZY_HeightScale(312))];
           [self.erCodeImage.image drawInRect:CGRectMake(ZY_WidthScale(225), ZY_HeightScale(333), ZY_HeightScale(83.5), ZY_HeightScale(83.5))];
           [[self circleImageWithName:self.headerImage.image borderWidth:0 borderColor:[UIColor clearColor]] drawInRect:CGRectMake(ZY_WidthScale(11), ZY_HeightScale(347), ZY_WidthScale(60), ZY_WidthScale(60))];
       UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
       
       UIGraphicsEndImageContext();
       
       return resultingImage;
}
- (UIImage*)imageWithName:(NSString*)name phone:(NSString *)phone addToImage:(UIImage*)image{
 
    //绘制图片上下文
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
 
    //字体绘制到图片的位置和字体属性
 NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
 attrs[NSFontAttributeName] = BoldFont(17);  // 设置文字大小
 attrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#333333"];
    [name drawInRect:CGRectMake(ZY_WidthScale(86),ZY_HeightScale(349),ZY_WidthScale(120),ZY_HeightScale(16))withAttributes:attrs];
 
    NSMutableDictionary * attrs1 = [NSMutableDictionary dictionary];
    attrs1[NSFontAttributeName] = Fonts(14);  // 设置文字大小
    attrs1[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#333333"];
       [phone drawInRect:CGRectMake(ZY_WidthScale(86),ZY_HeightScale(374),ZY_WidthScale(120),ZY_HeightScale(16))withAttributes:attrs1];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
 
    UIGraphicsEndImageContext();
 
    return newImage;
 
}
#pragma mark - 压缩图片---小于32KB
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
