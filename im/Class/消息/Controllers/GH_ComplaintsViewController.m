//
//  GH_ComplaintsViewController.m
//  im
//
//  Created by ZhiYuan on 2020/4/10.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_ComplaintsViewController.h"
#import "GH_ComplaintsView_AddPhotoView.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
@interface GH_ComplaintsViewController ()<UITextViewDelegate>
{
 OSSClient * client;
}
@property (nonatomic, strong)UITextView * textView;
@property (nonatomic, strong)GH_ComplaintsView_AddPhotoView * photoView;
@property (nonatomic, strong)NSMutableArray * photoArray;
@property (nonatomic, copy)NSString * textString;
@property (nonatomic, strong)NSDictionary * OSSDic;
@property (nonatomic, strong)NSMutableArray * photoArrayUrl;//上传成功后的url数组
@end

@implementation GH_ComplaintsViewController
- (NSMutableArray *)photoArrayUrl{
    if (!_photoArrayUrl) {
        _photoArrayUrl = [NSMutableArray new];
    }
    return _photoArrayUrl;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationItem setTitle:@"用户投诉"];
    self.titleText = @"用户投诉";
    self.backText = @"";
    [self creatUI];
}


- (void)creatUI{
    UIView * topView = [UIView new];
    topView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(kNavBarHeight);
        make.height.equalTo(@(ZY_HeightScale(45)));
    }];
    UILabel * labl = [UILabel new];
    labl.text = @"投诉内容";
    labl.textColor = Colors(@"#444444");
    labl.font = [UIFont systemFontOfSize:ZY_WidthScale(15)];
    [topView addSubview:labl];
    [labl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).mas_offset(ZY_WidthScale(15));
    }];
    
    self.textView = [UITextView new];
    self.textView.text = @"可详细描述你想投诉内容";
    self.textView.textColor = Colors(@"#999999");
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:ZY_WidthScale(15)];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(ZY_WidthScale(15));
        make.right.equalTo(self.view).mas_offset(-ZY_WidthScale(15));
        make.top.equalTo(topView.mas_bottom).mas_offset(ZY_HeightScale(16));
        make.height.equalTo(@(ZY_HeightScale(210)));
    }];
    UIView * lineView = [UIView new];
    lineView.backgroundColor = Colors(@"#F4F5F7");
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
        make.top.equalTo(self.textView.mas_bottom);
    }];
    
    self.photoView = [GH_ComplaintsView_AddPhotoView new];
    WeakSelf;
    self.photoView.addPhotoBlock = ^(NSArray * _Nonnull photoArray) {
        [weakSelf.photoArray removeAllObjects];
        [photoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf.photoArray addObject:obj];
        }];
    };
    [self.view addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(@(ZY_HeightScale(140)));
    }];
    
    
    UIButton * submitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    //支付f按钮
    submitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *  gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#BC94FE"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#856EF9"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0,  ZY_WidthScale(299),  ZY_HeightScale(50));
    [submitBt.layer addSublayer:gradientLayer];
    submitBt.layer.cornerRadius = ZY_WidthScale(25);
    submitBt.clipsToBounds = YES;
    [submitBt setTitle:@"提交" forState:UIControlStateNormal];
    [submitBt setTitleColor:Colors(@"#FFFFFF") forState:UIControlStateNormal];
    submitBt.titleLabel.font = Fonts(17);
    [self.view addSubview:submitBt];
    [submitBt addTarget:self action:@selector(SureBtnClick) forControlEvents:UIControlEventTouchDown];
    [submitBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ZY_WidthScale(299)));
        make.height.equalTo(@(ZY_HeightScale(50)));
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-ZY_HeightScale(15));
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"可详细描述你想投诉内容"]) {
        textView.text = @"";
    }else{
        textView.text = self.textString;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"可详细描述你想投诉内容";
    }
    self.textString = textView.text;;
}


- (NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableArray new];
    }
    return _photoArray;
}

- (void)SureBtnClick {
    [self.textView resignFirstResponder ];
    if (self.photoArray.count ==  0) {
        [self updataImage];
    }else{
        if (self.textString.length == 0) {
            [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"请输入投诉内容"];
        }else{
        for (int i  = 0; i < self.photoArray.count; i++) {
            [self getAliOSS:self.photoArray[i] index:i];
        }
        }
    }
}


- (void)getAliOSS:(UIImage *)image index:(int)index{
    WeakSelf;
    [GetManager httpManagerWithUrl:getALiOSS parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        weakSelf.OSSDic = data;
        [weakSelf upLoadingMessager:image index:index];
    } failture:^(NSString * _Nonnull Message) {
        
    }];
    
}
/*上传信息给后台调用实名认证接口*/
- (void)upLoadingMessager:(UIImage *)image index:(int)index{
    NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc]initWithAccessKeyId:self.OSSDic[@"accessKeyId"] secretKeyId:self.OSSDic[@"accessKeySecret"] securityToken:self.OSSDic[@"securityToken"]];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"wanglvshi";
    put.objectKey = self.OSSDic[@"key"];
    //Uiimage转换为NSData
    NSData * forwardData = UIImageJPEGRepresentation(image, 1);
    //    NSData * backData = UIImageJPEGRepresentation(self.backImage, 1);
    put.uploadingData = forwardData;
    //    put.uploadingData = backData;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    __weak typeof(self)weakSelf = self;
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSString * url = [NSString stringWithFormat:@"%@/%@", @"http://wanglvshi.oss-cn-hangzhou.aliyuncs.com",weakSelf.OSSDic[@"key"]];
            [weakSelf.photoArrayUrl addObject:url];
            if (index ==weakSelf.photoArray.count - 1) {
                [weakSelf updataImage];
            }
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    
    [putTask waitUntilFinished];//这个时sdk给的用于多张图片上传时 加上它时只有第一个走了成功或者失败第二个才会走 。相当于等待串行。
}
- (void)updataImage{
    NSLog(@"54321");
//    NSLog(@"%@--%@", self.text, self.photoArrayUrl);
    WeakSelf;
    if (self.textString.length == 0) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"请输入投诉内容"];
    }else{
    [GetManager httpManagerWithUrl:complaints parameters:@{@"desc":self.textString, @"pics": [GH_ComplaintsViewController  arrayToJSONString:self.photoArrayUrl], @"accid": self.infoId} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"投诉成功"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failture:^(NSString * _Nonnull Message) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
    }
}

+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary

{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}


+ (NSString *)arrayToJSONString:(NSArray *)array

{
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return jsonString;
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
