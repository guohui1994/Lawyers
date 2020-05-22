//
//  GH_FinancingViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_FinancingViewController.h"
#import "GH_FinancingTextFieldView.h"
#import "GH_FinancingCardView.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
@interface GH_FinancingViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
        OSSClient * client;
}
/*
@property (nonatomic, strong)GH_FinancingTextFieldView * nameTextField;//名字输入框
@property (nonatomic, strong)GH_FinancingTextFieldView * phoneTextField;//手机号
@property (nonatomic, strong)GH_FinancingTextFieldView * cardTextField;//身份证
@property (nonatomic, strong)GH_FinancingTextFieldView * commercialTextField;//商户号
@property (nonatomic, strong)GH_FinancingTextFieldView * addresTextField;//详细地址

//身份证view
@property (nonatomic, strong)GH_FinancingCardView * cardView;
@property (nonatomic, copy)NSString * nameString;//名字
@property (nonatomic, copy)NSString * phoneString;//电话
@property (nonatomic, copy)NSString * cardString;//身份证
@property (nonatomic, copy)NSString * commericaString;//商户号
@property (nonatomic, copy)NSString * addressString;//地址
//标价是身份证正面照还是反面照0是正面照1是反面照
@property (nonatomic, assign)int tag;
//正面身份证图片
@property (nonatomic, strong)UIImage * forwardImage;
//正面身份证上传阿里云之后的地址
@property (nonatomic, copy)NSString * forwardUrl;
//反面身份证图片
@property (nonatomic, strong)UIImage * backImage;
//反面身份证上传阿里云之后的地址
@property (nonatomic, copy)NSString * BackUrl;


OSS凭证dic
@property (nonatomic, strong)NSDictionary * OSSDic;

@property (nonatomic, strong)NSMutableArray * cardArray;//存放身份证照片数组
@property (nonatomic, strong)NSMutableArray * cardUrlArray;//保存上传阿里云之后的地址数组
@property (nonatomic, strong)WKUserContentController* wKUserContentControllers;


*/

@property (nonatomic, strong)WKWebView * web;
@property (nonatomic, strong)WKWebViewConfiguration * configs ;
@property (nonatomic, strong)WKUserContentController* wKUserContentControllers;
@end

@implementation GH_FinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"我要融资";
    self.backText = @"";
    self.customNavBar.hidden = YES;
    self.view.backgroundColor = Colors(@"#F8F8F8");
//    self.cardArray = [NSMutableArray new];
//    self.cardUrlArray = [NSMutableArray new];
//    [self creatUI];
    [self creatWKWebView];
}

#pragma mark --- 创建WKWebview
- (void )creatWKWebView{
    NSString * urlString = [NSString stringWithFormat:@"%@/html/financing.html?token=%@", BaseUrl,[Singleton defaultSingleton].token];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    self.configs = [[WKWebViewConfiguration alloc]init];
    self.configs.preferences = [WKPreferences new];
    self.configs.preferences.javaScriptEnabled = YES;
    self.configs.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    self.configs.userContentController = [[WKUserContentController alloc]init];
   
        self. web = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight  ) configuration:self.configs];
    
    self. wKUserContentControllers = self.web.configuration.userContentController;
    self.configs.userContentController = self.wKUserContentControllers;
    self.web.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self. web.UIDelegate = self;
    [self.web.scrollView setShowsVerticalScrollIndicator:NO];
    [self.web.scrollView setShowsHorizontalScrollIndicator:NO];
    [_web setAllowsBackForwardNavigationGestures:YES];
    self. web.navigationDelegate = self;
    [_web.scrollView setAlwaysBounceVertical:YES];
    [self.wKUserContentControllers addScriptMessageHandler:self  name:@"goBack"];
    
    [self. web loadRequest:request];
    [self.view addSubview:self.web];
    
    
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
    //允许webView的点击时数据的获取
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    //    NSDictionary *dic = [NSDictionary parseJSONStringToNSDictionary:message];
    completionHandler();
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"goBack"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)dealloc{
    [[self.web configuration].userContentController removeScriptMessageHandlerForName:@"goBack"];
   
}
/*
- (void)creatUI{
    //灰色线条
    UIView * grayView = [UIView new];
    grayView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
        make.height.equalTo(@(10));
    }];
    
    UIScrollView * scrollerView = [UIScrollView new];
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.contentSize = CGSizeMake(screenWidth, ZY_HeightScale(869));
    [self.view addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(grayView.mas_bottom);
    }];
    //姓名
    self.nameTextField = [GH_FinancingTextFieldView new];
    self.nameTextField.titleString = @"姓名";
    self.nameTextField.placeholder = @"请输入您的真实姓名";
    self.nameTextField.textField.delegate = self;
    [scrollerView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollerView);
        make.width.equalTo(@(screenWidth));
        make.height.equalTo(@(ZY_HeightScale(60)));
    }];
    //手机号
    self.phoneTextField = [GH_FinancingTextFieldView new];
    self.phoneTextField.titleString = @"手机号";
    self.phoneTextField.placeholder = @"请输入您的手机号";
    self.phoneTextField.textField.delegate = self;
    [scrollerView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.nameTextField);
         make.width.equalTo(@(screenWidth));
        make.top.equalTo(self.nameTextField.mas_bottom);
    }];
    //身份证
    self.cardTextField = [GH_FinancingTextFieldView new];
    self.cardTextField.titleString = @"身份证号";
    self.cardTextField.placeholder = @"请输入您的身份证号";
    self.cardTextField.textField.delegate = self;
    self.cardTextField.lineView.hidden = YES;
    [scrollerView addSubview:self.cardTextField];
    [self.cardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.nameTextField);
         make.width.equalTo(@(screenWidth));
        make.top.equalTo(self.phoneTextField.mas_bottom);
    }];
    
    
    self.cardView = [GH_FinancingCardView new];
    [scrollerView addSubview:self.cardView];
    [self.cardView.forwardButton addTarget:self action:@selector(fowardButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.cardView.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardTextField.mas_bottom).mas_offset(15);
        make.left.equalTo(self.view);
        make.width.equalTo(@(screenWidth));
        make.height.equalTo(@(ZY_HeightScale(410)));
    }];
    
    //商户号
    self.commercialTextField = [GH_FinancingTextFieldView new];
    self.commercialTextField.titleString = @"商户号";
    self.commercialTextField.placeholder = @"请输入您的商户号";
    self.commercialTextField.textField.delegate = self;
    [scrollerView addSubview:self.commercialTextField];
    [self.commercialTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.nameTextField);
        make.width.equalTo(@(screenWidth));
        make.top.equalTo(self.cardView.mas_bottom).mas_offset(15);
    }];
    //详细地址
    self.addresTextField = [GH_FinancingTextFieldView new];
    self.addresTextField.titleString = @"详细地址";
    self.addresTextField.placeholder = @"请输入您的详细地址";
    self.addresTextField.textField.delegate = self;
    self.addresTextField.lineView.hidden = YES;
    [scrollerView addSubview:self.addresTextField];
    [self.addresTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.nameTextField);
        make.width.equalTo(@(screenWidth));
        make.top.equalTo(self.commercialTextField.mas_bottom);
    }];
    
    //提交
    UIView * whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    [scrollerView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollerView);
        make.top.equalTo(self.addresTextField.mas_bottom).mas_offset(15);
        make.width.equalTo(@(screenWidth));
        make.height.equalTo(@(ZY_HeightScale(113)));
    }];
    
    UIButton * submit = [UIButton buttonWithType:UIButtonTypeCustom];
    [submit.layer addSublayer:[self changColorWithWidth:ZY_WidthScale(299) height:ZY_HeightScale(50)]];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submit.layer.cornerRadius = ZY_WidthScale(25);
    submit.clipsToBounds = YES;
    submit.titleLabel.font = Fonts(18);
    [submit addTarget:self action:@selector(submitMessage) forControlEvents:UIControlEventTouchDown];
    [whiteView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.centerY.equalTo(whiteView);
        make.width.equalTo(@(ZY_WidthScale(299)));
        make.height.equalTo(@(ZY_HeightScale(50)));
    }];
    
    
}

- (void)submitMessage{
    [self.nameTextField.textField resignFirstResponder];
    [self.phoneTextField.textField resignFirstResponder];
    [self.cardTextField.textField resignFirstResponder];
    [self.commercialTextField.textField resignFirstResponder];
    [self.addresTextField.textField resignFirstResponder];
    
    if (self.nameString.length == 0) {
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入姓名"];
    }else if (self.phoneString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入电话号码"];
    }else if (self.cardString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入身份证号"];
    }else if (self.commericaString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入商家号"];
    }else if(self.addressString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入详细地址"];
    }else {
        
        NSLog(@"名字%@, 手机号%@, 身份证号%@, 商户号%@, 详细地址%@", self.nameString, self.phoneString, self.cardString, self.commericaString, self.addressString);
        [self getAliOSS];
       
        
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.nameTextField.textField) {
        self.nameString = textField.text;
    }else if (textField == self.phoneTextField.textField){
        self.phoneString = textField.text;
    }else if (textField == self.cardTextField.textField){
        self.cardString = textField.text;
    }else if (textField == self.commercialTextField.textField){
        self.commericaString = textField.text;
    }else{
        self.addressString = textField.text;
    }
}


//正面照button点击方法
- (void)fowardButtonClick{
    //正面照
    self.tag = 0;
    [self chooseCard];
}
//反面照button点击方法
- (void)backButtonClick{
    //反面照
    self.tag = 1;
    [self chooseCard];
}

//选择身份证
- (void)chooseCard{
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController * pickImage = [[UIImagePickerController alloc]init];
    pickImage.allowsEditing = YES;
    pickImage.delegate = self;
    __weak typeof(self)weakSelf = self;
    UIAlertAction * actionXiangCe = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pickImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakSelf presentViewController:pickImage animated:YES completion:nil];
    }];
    
    UIAlertAction * actionXiangJi = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            [weakSelf presentViewController:pickImage animated:YES completion:nil];
        }else{
            
        }
    }];
    UIAlertAction * actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [alter addAction:actionXiangJi];
    [alter addAction:actionXiangCe];
    [alter addAction:actionCancle];
    [self presentViewController:alter animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage * newphoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSDictionary * dic = @{};
    if (self.tag == 0) {
        [self.cardView.forwardButton setImage:newphoto forState:UIControlStateNormal];
        self.forwardImage = newphoto;
        dic = @{@"0": newphoto};
    }else{
        [self.cardView.backButton setImage:newphoto forState:UIControlStateNormal];
        self.backImage = newphoto;
        dic = @{@"1" : newphoto};
    }
    [self.cardArray addObject:dic];
    [self reloadInputViews];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取OSS上传凭证
- (void)getAliOSS{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:getALiOSS parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        weakSelf.OSSDic = data;
        [weakSelf upLoadingMessager:weakSelf.cardArray];        
        NSString * forwardUrl = @"";
        NSString * backUrl = @"";
        for (NSDictionary * dic in self.cardUrlArray) {
            NSString * key = dic.allKeys[0];
            if ([key intValue] == 0) {
                forwardUrl = dic[key];
            }else{
                backUrl = dic[key];
            }
        }
        [GetManager httpManagerNetWorkHudWithUrl:Merchant parameters:@{@"userName":self.nameString, @"phone":self.phoneString, @"cardId":self.cardString,@"cardFront":forwardUrl,@"cardBack":backUrl,@"merchant":self.commericaString, @"address":self.addressString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            NSLog(@"%@", data);
            [weakSelf AutomaticRemoveHudWithText:@"已提交"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } failture:^(NSString * _Nonnull Message) {
            [self AutomaticAndBlackHudRemoveHudWithText:Message];
        }];
        
        
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
    
    
    
}
 */

/**
上传信息给后台调用实名认证接口
- (void)upLoadingMessager:(NSArray *)array{
    NSString *endpoint = @"http://oss-cn-shanghai.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc]initWithAccessKeyId:self.OSSDic[@"accessKeyId"] secretKeyId:self.OSSDic[@"accessKeySecret"] securityToken:self.OSSDic[@"securityToken"]];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"hutong-test2";
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dic = array[i];
        NSString * string = dic.allKeys[0];
        NSString * timen =[GH_Tools currentTimeStr];
        put.objectKey = timen;
        NSData * data = UIImageJPEGRepresentation(dic[string], 1);
        put.uploadingData = data;
        //    put.uploadingData = backData;
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        };
        __weak typeof(self)weakSelf = self;
        OSSTask * putTask = [client putObject:put];
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
//                if (weakSelf.tag == 0) {
//
//                    weakSelf.forwardUrl = [NSString stringWithFormat:@"%@/%@", @"http://hutong-test2.oss-cn-shanghai.aliyuncs.com",weakSelf.OSSDic[@"key"]];
//                    NSLog(@"正面照上传成功");
//                }else{
//                    weakSelf.BackUrl = [NSString stringWithFormat:@"%@/%@", @"http://hutong-test2.oss-cn-shanghai.aliyuncs.com",weakSelf.OSSDic[@"key"]];
//                    NSLog(@"反面照上传成功");
//                }
                NSString * url = [NSString stringWithFormat:@"%@/%@", @"http://hutong-test2.oss-cn-shanghai.aliyuncs.com",timen];
                NSDictionary * urlDic = @{};
                if ([string intValue] == 0) {
                    urlDic = @{@"0":url};
                }else{
                    urlDic = @{@"1" : url};
                }
                [weakSelf.cardUrlArray addObject:urlDic];
                
                NSLog(@"upload object success!");
            } else {
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        
        [putTask waitUntilFinished];//这个时sdk给的用于多张图片上传时 加上它时只有第一个走了成功或者失败第二个才会走 。相当于等待串行。
    }
    
   
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
