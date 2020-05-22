//
//  GH_QuestionFeedBackViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/23.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_QuestionFeedBackViewController.h"
#import "GH_OrderSelectPhotoAndTextTableViewCell.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
@interface GH_QuestionFeedBackViewController ()<UITableViewDelegate, UITableViewDataSource>{
  OSSClient * client;
}
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSMutableArray * photoArray;//图片数组
@property (nonatomic, strong)NSMutableArray * photoArrayUrl;//上传阿里云之后的数组
/*OSS凭证dic*/
@property (nonatomic, strong)NSDictionary * OSSDic;
@property (nonatomic, copy)NSString * s;
@end

@implementation GH_QuestionFeedBackViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_OrderSelectPhotoAndTextTableViewCell class] forCellReuseIdentifier:@"GH_OrderSelectPhotoAndTextTableViewCell"];
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"问题反馈";
    self.backText = @"";
    self.photoArray = [NSMutableArray new];
    self.photoArrayUrl = [NSMutableArray new];
    [self creatUI];
}

- (void)creatUI{
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
    }];
}

-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_OrderSelectPhotoAndTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_OrderSelectPhotoAndTextTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.photoArray = self.photoArray;
    if (self.s.length == 0) {
        cell.placeHolder = @"请详细描述这个问题，最好能够上传页面截图便于我们更好的服务!";
    }else{
        cell.placeHolder = self.s;
    }
    
    WeakSelf;
    cell.block = ^{
        [weakSelf addPhoto];
    };
    cell.submitAppriase = ^(NSString * _Nonnull text) {
        [weakSelf getAliOSSWithText:text];
        
    };
    cell.textBlock = ^(NSString * _Nonnull text) {
        weakSelf.s = text;
    };
    cell.addPicString = @"My_Add1";
    cell.submitText = @"提交";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = Colors(@"#F2F2F2");
    UILabel * lable = [UILabel new];
    lable.text = @"请详细描述这个问题";
    lable.font = Fonts(15);
    lable.textColor = Colors(@"#444444");
    [view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
        make.centerY.equalTo(view);
    }];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ZY_HeightScale(45);
}

//添加照片
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
        [GetManager httpManagerNetWorkHudWithUrl:questionFeedBack parameters:@{@"id":@([[Singleton defaultSingleton].userID integerValue]),@"content":text, @"pic":jsonString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            [weakSelf AutomaticAndBlackHudRemoveHudWithText:@"提交成功"];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
