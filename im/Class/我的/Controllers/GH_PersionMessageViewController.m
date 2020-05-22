//
//  GH_PersionMessageViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_PersionMessageViewController.h"
#import "GH_PersionMessageTableViewCell.h"
#import "GH_SetSexViewController.h"
#import "GH_SetPhoneViewController.h"
#import "GH_UserNameViewController.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
@interface GH_PersionMessageViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    OSSClient * client;
}
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSArray * titleArray;//标题的数组
@property (nonatomic, strong)NSArray * contentsArray;//内容数组
/*OSS凭证dic*/
@property (nonatomic, strong)NSDictionary * OSSDic;
@property (nonatomic, strong)UIImage * headerImage;//选择的照片
@property (nonatomic, copy)NSString * headerImageUrl;//上传阿里云之后的地址
@end

@implementation GH_PersionMessageViewController


- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = Colors(@"#F8F8F8");
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_PersionMessageTableViewCell class] forCellReuseIdentifier:@"GH_PersionMessageTableViewCell"];
    }
    return _table;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.contentsArray = @[[Singleton defaultSingleton].UserHeaderImage, [Singleton defaultSingleton].UserName, [Singleton defaultSingleton].UserSex, [Singleton defaultSingleton].userID, [Singleton defaultSingleton].UserPhone];
    [self.table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"个人信息";
    self.backText = @"";
    self.view.backgroundColor = Colors(@"#F8F8F8");
    self.titleArray = @[@"更换头像", @"用户名", @"性别", @"ID", @"手机号"];
    
    
    [self creatUI];
}
- (void)creatUI{
    
    UIView * grayView = [UIView new];
    grayView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
        make.height.equalTo(@(10));
    }];
    
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(grayView.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_PersionMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_PersionMessageTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        cell.titleString = self.titleArray[indexPath.row];
        if(indexPath.row == 0){
            cell.isShowHearder = YES;
        }else if (indexPath.row == 2){
            cell.isShowLineView = YES;
        }
        cell.contentString = self.contentsArray[indexPath.row];
    }else{
        cell.titleString = self.titleArray[indexPath.row + 3];
        if (indexPath.row == 1) {
            cell.isShowLineView = YES;
        }else{
            cell.isHidenRightBackImage = YES;
        }
        cell.contentString = self.contentsArray[indexPath.row + 3];
    }
    return cell;
}


-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self chooseUserIcon];
        }else if(indexPath.row == 1){
            GH_UserNameViewController * vc = [GH_UserNameViewController new];
            vc.userName = [Singleton defaultSingleton].UserName;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            GH_SetSexViewController * vc = [GH_SetSexViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            
        }else{
            GH_SetPhoneViewController * vc = [GH_SetPhoneViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return ZY_HeightScale(105);
        }else{
            return ZY_HeightScale(60);
        }
    }else{
        return ZY_HeightScale(60);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)chooseUserIcon{
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
    self.headerImage = newphoto;
    [self getAliOSS];
    [self reloadInputViews];
    //    self.chooseImage = newphoto;
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.table reloadData];
}

- (void)getAliOSS{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:getALiOSS parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        weakSelf.OSSDic = data;
        [weakSelf upLoadingMessager];
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}
/*上传信息给后台调用实名认证接口*/
- (void)upLoadingMessager{
    NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc]initWithAccessKeyId:self.OSSDic[@"accessKeyId"] secretKeyId:self.OSSDic[@"accessKeySecret"] securityToken:self.OSSDic[@"securityToken"]];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"wanglvshi";
    put.objectKey = self.OSSDic[@"key"];
    //Uiimage转换为NSData
    NSData * forwardData = UIImageJPEGRepresentation(self.headerImage, 1);
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
            weakSelf.headerImageUrl = [NSString stringWithFormat:@"%@/%@", @"http://wanglvshi.oss-cn-hangzhou.aliyuncs.com",weakSelf.OSSDic[@"key"]];
            [weakSelf changUserHeader];
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
}

- (void)changUserHeader{
    WeakSelf;
//    [GetManager httpManagerNetWorkHudWithUrl:changeUserMessage parameters:@{@"head":self.headerImageUrl} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
////        [[Singleton defaultSingleton]setUserHeaderImage:weakSelf.headerImageUrl];
////         weakSelf.contentsArray = @[[Singleton defaultSingleton].UserHeaderImage, [Singleton defaultSingleton].UserName, [Singleton defaultSingleton].UserSex, [Singleton defaultSingleton].userID, [Singleton defaultSingleton].UserPhone];
////        [weakSelf.table reloadData];
//    } failture:^(NSString * _Nonnull Message) {
//
//    }];
    
    [GetManager httpManagerWithUrl:changeUserMessage parameters:@{@"head":self.headerImageUrl} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [[Singleton defaultSingleton]setUserHeaderImage:weakSelf.headerImageUrl];
       weakSelf.contentsArray = @[[Singleton defaultSingleton].UserHeaderImage, [Singleton defaultSingleton].UserName, [Singleton defaultSingleton].UserSex, [Singleton defaultSingleton].userID, [Singleton defaultSingleton].UserPhone];
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
    
}



@end
