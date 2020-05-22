//
//  GH_OrderViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderViewController.h"
#import "GH_OrderTableViewCell.h"
#import "GH_OrderDetaileViewController.h"
#import "GH_OrderCompletedViewController.h"
#import "GH_AppraiceCompletedViewController.h"
#import "GHOrderListModel.h"
#import "GH_OrderAppraiseViewController.h"
@interface GH_OrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSMutableArray * dataSourceArray;//数据源数组
@property (nonatomic, strong)GHOrderListModel * model;
@property (nonatomic, assign)int page;
@end

@implementation GH_OrderViewController
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_OrderTableViewCell class] forCellReuseIdentifier:@"GH_OrderTableViewCell"];
        WeakSelf
        self.table.mj_header = [GH_MJHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        self.table.mj_footer = [GH_MJFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }
    return _table;
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.table.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"订单";
    self.dataSourceArray = [NSMutableArray new];
    [self creatUI];
    self.page = 1;
   
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

//刷新
- (void)getData{
    WeakSelf;
    [GetManager httpManagerWithUrl:orderList parameters:@{@"pageNum": @(1)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        weakSelf.model = [GHOrderListModel mj_objectWithKeyValues:data];
        for (GHOrderListListModel * models in weakSelf.model.list) {
            [self.dataSourceArray addObject:models];
        }
        if (weakSelf.model.pages == 1 || weakSelf.dataSourceArray.count == 0) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}


- (void)loadMoreData{
    self.page ++;
    WeakSelf;
    [GetManager httpManagerWithUrl:orderList parameters:@{@"pageNum": @(self.page)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        weakSelf.model = [GHOrderListModel mj_objectWithKeyValues:data];
        for (GHOrderListListModel * models in weakSelf.model.list) {
            [self.dataSourceArray addObject:models];
        }
        if (weakSelf.model.pages == weakSelf.page) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_OrderTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    GHOrderListListModel * model = self.dataSourceArray[indexPath.row];
    
    if (model.state == 1) {
        cell.type = 0;
    }else if (model.state == 2){
        cell.type = 0;
    }else if (model.state == 3){
        cell.type = 1;
    }else if (model.state == 4){
        cell.type = 2;
    }
    cell.model = model;
    [cell.clickButton addTarget:self action:@selector(clickButtons:) forControlEvents:UIControlEventTouchDown];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZY_HeightScale(133);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GHOrderListListModel * model = self.dataSourceArray[indexPath.row];
    if (model.state == 1 || model.state == 2) {
        GH_OrderDetaileViewController * vc = [GH_OrderDetaileViewController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (model.state == 3){
        GH_OrderCompletedViewController * vc = [GH_OrderCompletedViewController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        GH_AppraiceCompletedViewController * vc = [GH_AppraiceCompletedViewController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)clickButtons:(UIButton *)sender{
    GH_OrderTableViewCell * cell = (GH_OrderTableViewCell *)[[[sender superview] superview] superview];
    NSIndexPath * index = [self.table indexPathForCell:cell];
    GHOrderListListModel * model = self.dataSourceArray[index.row];
    if (model.state == 0 || model.state == 1) {
        //进行中---未付尾款
        GH_OrderDetaileViewController * vc = [GH_OrderDetaileViewController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (model.state == 2){
        //尾款已支付---未点击确认
        WeakSelf;
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"确定订单已完成了吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //请求完成接口
            
            [GetManager httpManagerNetWorkHudWithUrl:sureCompletement parameters:@{@"orderId": @(model.orderID)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                [weakSelf.table.mj_header beginRefreshing];
            } failture:^(NSString * _Nonnull Message) {
                [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }];
        UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alter addAction:cancle];
        [alter addAction:sure];
        [self presentViewController:alter animated:YES completion:nil];
    }else if (model.state == 3){
     //未评价---已完成
        GH_OrderAppraiseViewController * vc = [GH_OrderAppraiseViewController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
     //已评价---已完成
        GH_OrderAppraiseViewController * vc = [GH_OrderAppraiseViewController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
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
