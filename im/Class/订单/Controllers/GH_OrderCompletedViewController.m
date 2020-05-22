//
//  GH_OrderCompletedViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderCompletedViewController.h"
#import "GH_BuyLawyerServiceTableViewCell.h"
#import "GH_LeaveMessageResultTableViewCell.h"
#import "GH_OrderAppraiseViewController.h"
@interface GH_OrderCompletedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView * table;

@property (nonatomic,strong)UILabel * placeOrderLable;//下单时间
@property (nonatomic, strong)UILabel * completedLable;//完成时间;
@end

@implementation GH_OrderCompletedViewController
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_BuyLawyerServiceTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        [_table registerClass:[GH_LeaveMessageResultTableViewCell class] forCellReuseIdentifier:@"GH_LeaveMessageResultTableViewCell"];
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"订单详情";
    self.backText = @"";
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
        cell.isShowStateLable = YES;
        cell.orderModel = self.model;
        
        return cell;
    }else{
        GH_LeaveMessageResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_LeaveMessageResultTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderModel = self.model;
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
        return ZY_HeightScale(245);
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        UIView * grayView = [UIView new];
        grayView.backgroundColor = Colors(@"#F8F8F8");
        [view addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(@(10));
        }];
        
        UILabel * xiaDanlable = [UILabel new];
        xiaDanlable.text = @"下单时间:";
        xiaDanlable.font = Fonts(15);
        xiaDanlable.textColor = Colors(@"#666666");
        [view addSubview:xiaDanlable];
        [xiaDanlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(21));
            make.top.equalTo(grayView.mas_bottom).mas_offset(ZY_HeightScale(18));
        }];
        
        self.placeOrderLable = [UILabel new];
        self.placeOrderLable.text = [GH_Tools transToTimeStemp:self.model.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        self.placeOrderLable.textColor = Colors(@"#4C4C4C");
        self.placeOrderLable.font = Fonts(15);
        [view addSubview:self.placeOrderLable];
        [self.placeOrderLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(xiaDanlable);
            make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(15));
        }];
        
        UILabel * wanchenglable = [UILabel new];
        wanchenglable.text = @"完成时间:";
        wanchenglable.font = Fonts(15);
        wanchenglable.textColor = Colors(@"#666666");
        [view addSubview:wanchenglable];
        [wanchenglable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(21));
            make.top.equalTo(xiaDanlable.mas_bottom).mas_offset(ZY_HeightScale(13));
        }];
        
        self.completedLable = [UILabel new];
        self.completedLable.text = [GH_Tools transToTimeStemp:self.model.finishTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        self.completedLable.textColor = Colors(@"#4C4C4C");
        self.completedLable.font = Fonts(15);
        [view addSubview:self.completedLable];
        [self.completedLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wanchenglable);
            make.centerX.equalTo(self.placeOrderLable);
        }];
        
        UIView * lineVIew = [UIView new];
        //使用贝塞尔曲线画输入框的虚线
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake((screenWidth - ZY_WidthScale(32)), 0)];
         CAShapeLayer * layers = [CAShapeLayer layer];
        [layers setFillColor:[UIColor clearColor].CGColor];
        [layers setStrokeColor:Colors(@"#E5E5E5").CGColor];
        layers.path = path.CGPath;
        layers.lineWidth = 0.5;
        layers.lineDashPattern = @[@(3.0),@(3.0)];
        [lineVIew.layer addSublayer:layers];
        [view addSubview:lineVIew];
        [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(16));
            make.width.equalTo(@(screenWidth - ZY_WidthScale(32)));
            make.top.equalTo(self.completedLable.mas_bottom).mas_offset(ZY_HeightScale(20));
            make.height.equalTo(@(0.5));
        }];
        
        UIButton * appriseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [appriseButton.layer addSublayer:[self changColorWithWidth:ZY_WidthScale(299) height:ZY_HeightScale(50)]];
        [appriseButton setTitle:@"去评价" forState:UIControlStateNormal];
        [appriseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        appriseButton.titleLabel.font = Fonts(18);
        appriseButton.layer.cornerRadius = ZY_WidthScale(25);
        appriseButton.clipsToBounds = YES;
        [appriseButton addTarget:self action:@selector(appriseClick) forControlEvents:UIControlEventTouchDown];
        [view addSubview:appriseButton];
        [appriseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.top.equalTo(self.completedLable.mas_bottom).mas_offset(ZY_HeightScale(103));
            make.width.equalTo(@(ZY_WidthScale(299)));
            make.height.equalTo(@(ZY_HeightScale(50)));
        }];
        
        return view;
    }
    return nil;
}

- (void)appriseClick{
    GH_OrderAppraiseViewController * vc = [GH_OrderAppraiseViewController new];
    vc.model =self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
