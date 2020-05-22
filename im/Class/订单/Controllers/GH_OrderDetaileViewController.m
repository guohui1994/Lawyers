//
//  GH_OrderDetaileViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderDetaileViewController.h"
#import "GH_BuyLawyerServiceTableViewCell.h"
#import "GH_LeaveMessageResultTableViewCell.h"
#import "GH_OrderDetailFooterView.h"
#import "WeiXinPayModel.h"
#import "AppDelegate.h"
@interface GH_OrderDetaileViewController ()<UITableViewDelegate, UITableViewDataSource, AppThirdCodeDelegate>
@property(nonatomic, strong)UITableView * table;

@property (nonatomic, strong)UILabel * timeLabel;//下单时间
@end

@implementation GH_OrderDetaileViewController
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[GH_BuyLawyerServiceTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        [_table registerClass:[GH_LeaveMessageResultTableViewCell class] forCellReuseIdentifier:@"GH_LeaveMessageResultTableViewCell"];
        GH_OrderDetailFooterView * footerView = [[GH_OrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, ZY_HeightScale(365))];
        footerView.backgroundColor = [UIColor whiteColor];
        WeakSelf;
        footerView.block = ^(NSString * _Nonnull weiKuanString, NSInteger payWay) {
            NSLog(@"尾款%@支付方式%ld", weiKuanString, payWay);
            //支付
            [weakSelf payWithMessage:weiKuanString payWay:payWay];
            
        };
        _table.tableFooterView = footerView;
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"订单详情";
    self.backText = @"";
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.returnCode = self;
    [self creatUI];
}
//创建UI
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
            [self customeNoticeHudWithTitle:@"支付成功" content:@"请确认完成订单"];
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
            [self customeNoticeHudWithTitle:@"支付成功" content:@"请确认完成订单"];
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
    if (message.length == 0) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:@"请输入尾款金额"];
    }else{
        if (payWay == 0) {//微信支付
            [GetManager httpManagerWithUrl:lastPaymentOrder parameters:@{@"money":message, @"orderId":@(weakSelf.model.orderID), @"payType":@(0)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                NSLog(@"%@", data);
                WeiXinPayModel * model = [WeiXinPayModel mj_objectWithKeyValues:data];
                [weakSelf weiXinPayWithModel:model];
            } failture:^(NSString * _Nonnull Message) {
                [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        
            
            
        }else{
            [GetManager httpManagerNetWorkHudWithUrl:lastPaymentOrder parameters:@{@"money" :message, @"orderId": @(self.model.orderID), @"payType" : @(1)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
    GH_BuyLawyerServiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderModel = self.model;
    cell.isShowStateLable = YES;
    return cell;
    }else{
        GH_LeaveMessageResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_LeaveMessageResultTableViewCell"];
        cell.orderModel = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return ZY_HeightScale(30);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        UIView * orangeView = [UIView new];
        orangeView.backgroundColor = Colors(@"#FFA425");
        [view addSubview:orangeView];
        [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
            make.top.equalTo(view.mas_top).mas_offset(ZY_HeightScale(16));
            make.width.equalTo(@(ZY_WidthScale(8)));
            make.height.equalTo(@(ZY_HeightScale(9)));
        }];
        UILabel * servericeLabel = [UILabel new];
        servericeLabel.text = @"备注";
        servericeLabel.font = Fonts(15);
        servericeLabel.textColor = Colors(@"#666666");
        [view addSubview:servericeLabel];
        [servericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
            make.top.equalTo(view.mas_top).mas_offset(ZY_HeightScale(13));
        }];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return ZY_HeightScale(47);
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        
        UILabel * label = [UILabel new];
        label.text = @"下单时间";
        label.textColor = Colors(@"#666666");
        label.font = Fonts(16);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).mas_offset(ZY_HeightScale(8));
            make.left.equalTo(view).mas_offset(ZY_WidthScale(30));
        }];
        
        self.timeLabel = [UILabel new];
        self.timeLabel.text = [GH_Tools transToTimeStemp:self.model.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        self.timeLabel.textColor = Colors(@"#4C4C4C");
        self.timeLabel.font = Fonts(16);
        [view addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label);
            make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(15));
        }];
        
        UIView * grayView = [UIView new];
        grayView.backgroundColor = Colors(@"#F8F8F8");
        [view addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(label.mas_bottom).mas_offset(ZY_HeightScale(14));
            make.height.equalTo(@(10));
        }];
        return view;
    }
    return nil;
}


@end
