//
//  GH_OrderAppraiseViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderAppraiseViewController.h"
#import "GH_OrderAppraiseTableViewCell.h"
#import "YYStarView.h"
#import "GH_OrderSelectPhotoAndTextTableViewCell.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
@interface GH_OrderAppraiseViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    OSSClient * client;
}
@property (nonatomic, strong)UIImageView * BgImageView;
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)YYStarView * starView;//星星
@property (nonatomic, assign)int startCount;
@property (nonatomic, strong)NSMutableArray * photoArray;//图片数组
@property (nonatomic, strong)NSMutableArray * photoArrayUrl;//上传阿里云之后的数组
/*OSS凭证dic*/
@property (nonatomic, strong)NSDictionary * OSSDic;
@property (nonatomic, copy)NSString * s;
@end

@implementation GH_OrderAppraiseViewController
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_OrderAppraiseTableViewCell class] forCellReuseIdentifier:@"GH_OrderAppraiseTableViewCell"];
        [_table registerClass:[GH_OrderSelectPhotoAndTextTableViewCell class] forCellReuseIdentifier:@"GH_OrderSelectPhotoAndTextTableViewCell"];
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"评价订单";
    self.backText = @"";
    [self creatUI];
    
    self.startCount = 0;
    self.photoArray = [NSMutableArray new];
    self.photoArrayUrl = [NSMutableArray new];
}

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
    //table
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(grayView.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ZY_HeightScale(131);
    }else{
        return [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
    GH_OrderAppraiseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_OrderAppraiseTableViewCell"];
        cell.model = self.model;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }else{
        GH_OrderSelectPhotoAndTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_OrderSelectPhotoAndTextTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.placeHolder = @"您对收到的商品还满意吗?请输入您的评价内容.";
        WeakSelf;
        
        
        if (self.model.state == 4) {
            //已经评价过了
            cell.appriceString = self.model.evaluateText;
            //string转data
            NSData * jsonData = [self.model.evaluatePic dataUsingEncoding:NSUTF8StringEncoding];
            //json解析
            NSArray * obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            cell.photoArrayUrl = obj;
        }else{
            NSLog(@"-----++++%@", self.s);
            if (self.s.length == 0) {
                cell.placeHolder = @"您对收到的商品还满意吗?请输入您的评价内容.";
            }else{
                NSLog(@"123");
                cell.tex = self.s;
            }
            cell.textBlock = ^(NSString * _Nonnull text) {
                weakSelf.s = text;
            };
        //点击添加照片的回调
        cell.block = ^() {
            [weakSelf addPhoto];
        };
        //提交
        cell.submitAppriase = ^(NSString * _Nonnull text) {
            NSLog(@"%@", text);
//            [weakSelf AutomaticAndHudRemoveHudWithText:@"提交成功"];
        
            [weakSelf getAliOSSWithText:text];
            
            
        };
            
        //评价内容
        cell.photoArray = self.photoArray;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return ZY_HeightScale(15);
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return ZY_HeightScale(50);
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 0) {
    UILabel * lable = [UILabel new];
    lable.text = @"满意程度";
    lable.textColor = Colors(@"#4C4C4C");
    lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(15)];
    [view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).mas_offset(ZY_WidthScale(33));
    }];
    self.starView = [YYStarView new];
    //可以默认是几个星星
//    self.starView.starScore = 5;
        
        if (self.model.state == 4) {
            self.starView.type = 1;
            self.starView.starScore = self.model.evaluateStar;
        }else{
    //1是不可以选择2是可以选择
    self.starView.type = 2;
        }
    //每颗星的大小，如果不设置，则按照图片大小自适应
   self. starView.starSize = CGSizeMake(18, 18);
        WeakSelf;
    self.starView.starClick = ^(NSInteger count) {
        weakSelf.startCount = (int)count;
    };
    self.starView.starDarkImageName = @"Star_Gray";
    self.starView.starBrightImageName = @"Star_Light";
    self.starView.starSpacing = 8;
    [view addSubview:self.starView];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lable);
        make.left.equalTo(lable.mas_right).mas_offset(ZY_WidthScale(20));
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = Colors(@"#E5E5E5");
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(ZY_WidthScale(16));
        make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(16));
        make.top.equalTo(lable.mas_bottom).mas_offset(ZY_HeightScale(15));
        make.height.equalTo(@(ZY_HeightScale(0.5)));
    }];
    return view;
    }
    return nil;
}

- (void)addPhoto{
    WeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage * images in photos) {
            [weakSelf.photoArray addObject:images];
        }
        [weakSelf.table reloadData];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}

//获取OSS上传凭证
- (void)getAliOSSWithText:(NSString *)text{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:getALiOSS parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        weakSelf.OSSDic = data;
        [weakSelf upLoadingMessager:weakSelf.photoArray];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:weakSelf.photoArrayUrl options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [GetManager httpManagerNetWorkHudWithUrl:evaluateOrder parameters:@{@"orderId" : @(self.model.orderID), @"evaluateStar" : @(weakSelf.startCount), @"evaluateText": text, @"evaluatePic": jsonString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            [weakSelf AutomaticAndHudRemoveHudWithText:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } failture:^(NSString * _Nonnull Message) {
            [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
        }];
        
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

/*上传信息给后台调用实名认证接口*/
- (void)upLoadingMessager:(NSArray *)array{
    NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc]initWithAccessKeyId:self.OSSDic[@"accessKeyId"] secretKeyId:self.OSSDic[@"accessKeySecret"] securityToken:self.OSSDic[@"securityToken"]];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"wanglvshi";
    for (int i = 0; i < array.count; i++) {
        
        NSString * timen =[GH_Tools currentTimeStr];
        put.objectKey = timen;
        NSData * data = UIImageJPEGRepresentation(array[i], 1);
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
                NSString * url = [NSString stringWithFormat:@"%@/%@", @"http://wanglvshi.oss-cn-hangzhou.aliyuncs.com",timen];
                [weakSelf.photoArrayUrl addObject:url];
                NSLog(@"upload object success!");
            } else {
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        
        [putTask waitUntilFinished];//这个时sdk给的用于多张图片上传时 加上它时只有第一个走了成功或者失败第二个才会走 。相当于等待串行。
    }
    
    
}



@end
