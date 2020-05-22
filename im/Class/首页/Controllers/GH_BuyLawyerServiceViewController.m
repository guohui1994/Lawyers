//
//  GH_BuyLawyerServiceViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_BuyLawyerServiceViewController.h"
#import "GH_BuyLawyerServiceTableViewCell.h"
#import "GH_BuyServiceVCFooterView.h"
#import "AppDelegate.h"
#import "WeiXinPayModel.h"
@interface GH_BuyLawyerServiceViewController ()<UITableViewDelegate, UITableViewDataSource, AppThirdCodeDelegate>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)WeiXinPayModel * models;
@end

@implementation GH_BuyLawyerServiceViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_BuyLawyerServiceTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        GH_BuyServiceVCFooterView * footerView = [[GH_BuyServiceVCFooterView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, ZY_HeightScale(391))];
//        footerView.orderAmount = self.model.orderAmount;
        if (self.type == 1) {
            footerView.recommendModel = self.recommendModel;
        }else if(self.type == 2){
            
        }else{
            footerView.model = self.model;
        }
        
        WeakSelf;
        footerView.block = ^(NSString * _Nonnull beiZhuMessage, NSInteger payWay) {
            NSLog(@"备注信息%@, 支付方式%ld", beiZhuMessage, payWay);
            //支付
            [weakSelf payWithMessage:beiZhuMessage payWay:payWay];
        };
        _table.tableFooterView = footerView;
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.titleText = self.recommendModel.name;
        
    }else if(self.type == 2){
        
    }else{
    self.titleText = self.model.name;
    }
    self.backText = @"";
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.returnCode = self;
    [self creatUI];
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

#pragma mark ----支付宝或者微信支付回调
//支付宝回调
- (void)returnWithAlipayWith:(NSInteger)code{
    switch (code) {
        case 9000:
            [self.navigationController popViewControllerAnimated:YES];
            [self customeNoticeHudWithTitle:@"支付成功" content:@"等待后台为您分配律师"];
            break;
        case 4000:
            [self AutomaticAndBlackHudRemoveHudWithText:@"订单支付失败"];
            break;
            
            case 6001:
            [self AutomaticAndBlackHudRemoveHudWithText:@"取消支付"];
            break;
        default:
            [self AutomaticAndBlackHudRemoveHudWithText:@"支付错误"];
            break;
    }
}
//微信支付回调
- (void)returnWithWXPayWith:(NSInteger)code{
    switch (code) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
             [self customeNoticeHudWithTitle:@"支付成功" content:@"等待后台为您分配律师"];
            break;
        case -2:
            [self AutomaticAndBlackHudRemoveHudWithText:@"取消支付"];
            break;
    default:
             [self AutomaticAndBlackHudRemoveHudWithText:@"支付失败"];
            break;
    }
}


#pragma mark ----支付宝支付或者微信支付
//支付
- (void)payWithMessage:(NSString *)message payWay:(NSInteger)payWay{
    WeakSelf;
    NSInteger seriviceID = 0;
    NSDictionary * dic = @{};
    if (self.type == 1) {
        seriviceID = weakSelf.recommendModel.serviceID;
        if (payWay == 0) {
            dic = @{@"remark":message, @"serviceId":@(seriviceID), @"payType":@(0), @"recommendId":@(self.laywersID)};
        }else{
            dic = @{@"remark":message, @"serviceId":@(seriviceID), @"payType":@(1), @"recommendId":@(self.laywersID)};
        }
        
    }else if (self.type == 2){
        
    }else{
        seriviceID = weakSelf.model.serviceID;
        if (payWay == 0) {
            dic = @{@"remark":message, @"serviceId":@(seriviceID), @"payType":@(0)};
        }else{
            dic = @{@"remark":message, @"serviceId":@(seriviceID), @"payType":@(1)};
        }
        
    }
    if (message.length == 0) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:@"请输入备注信息"];
    }else{
        if (payWay == 0) {//微信支付
            
           
            [GetManager httpManagerWithUrl:paymenOrder parameters:dic httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                NSLog(@"%@", data);
                WeiXinPayModel * model = [WeiXinPayModel mj_objectWithKeyValues:data];
                [weakSelf weiXinPayWithModel:model];
            } failture:^(NSString * _Nonnull Message) {
                [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }else{
            //支付宝支付
            [GetManager httpManagerWithUrl:paymenOrder parameters:dic httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                //服务器返回的s拼接字符串
                NSString *orderString = data[@"orderString"];
                //支付宝支付
                [weakSelf alipaWithOrderString:orderString];
            } failture:^(NSString * _Nonnull Message) {
                [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }
    }
}


//支付宝支付
- (void)alipaWithOrderString:(NSString *)orderString{
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"alipayLawer";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}

//微信支付
- (void)weiXinPayWithModel:(WeiXinPayModel *)model{
    // 调起微信支付
    PayReq *request = [[PayReq alloc] init];
    /** 微信分配的APPID */
    request.partnerId = model.partnerid;
    /** 预支付订单 从服务器获取 */
    request.prepayId = model.prepayid;
    /** 商家根据财付通文档填写的数据和签名 <暂填写固定值Sign=WXPay>*/
    request.package = @"Sign=WXPay";
    /** 随机串，防重发 */
    request.nonceStr= model.noncestr;
    /** 时间戳，防重发 */
    request.timeStamp= [model.timestamp intValue];
    /** 商家根据微信开放平台文档对数据做的签名, 可从服务器获取，也可本地生成*/
    request.sign= model.sign;
    /* 调起支付 */
    [WXApi sendReq:request];
}
     


#pragma mark ---table代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_BuyLawyerServiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.type == 1) {
        cell.recommendModel = self.recommendModel;
    }else if (self.type == 2){
        
    }else{
    cell.model = self.model;
    }
    return cell;
}





@end
