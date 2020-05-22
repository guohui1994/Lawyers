//
//  GH_AlreadyBuyServiceListViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_AlreadyBuyServiceListViewController.h"
#import "GH_LawyerServiceListTableViewCell.h"
#import "GH_AlredyBuyServiceDetaileViewController.h"
#import "GHAlreadyBuyServiceListModel.h"
@interface GH_AlreadyBuyServiceListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)GHAlreadyBuyServiceListModel * model;
@property (nonatomic, strong)NSMutableArray * dataSourceArray;//数据源
@property (nonatomic, assign)int page;//加载页数
@end

@implementation GH_AlreadyBuyServiceListViewController
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_LawyerServiceListTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        _table.showsVerticalScrollIndicator = NO;
        WeakSelf;
        //下拉刷新
        _table.mj_header = [GH_MJHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        //上拉加载
        _table.mj_footer = [GH_MJFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"已购买服务列表";
    self.backText = @"";
    self.dataSourceArray = [NSMutableArray new];
    self.page = 1;
    [self creatUI];
    [self.table.mj_header beginRefreshing];
}
//刷新
- (void)getData{
    WeakSelf;
    [GetManager httpManagerWithUrl:alreadyBuyService parameters:@{@"pageNum" : @(1)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        weakSelf.model = [GHAlreadyBuyServiceListModel mj_objectWithKeyValues:data];
        for (GHAlreadyBuyServiceListListModel * model1 in self.model.list) {
            [weakSelf.dataSourceArray addObject:model1];
        }
        if (weakSelf.model.pages == 1) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}
//加载更多
- (void)loadMoreData{
    self.page ++;
    WeakSelf
    [GetManager httpManagerWithUrl:alreadyBuyService parameters:@{@"pageNum" : @(self.page)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        weakSelf.model = [GHAlreadyBuyServiceListModel mj_objectWithKeyValues:data];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        for (GHAlreadyBuyServiceListListModel * model1 in self.model.list) {
            [weakSelf.dataSourceArray addObject:model1];
        }
        if (weakSelf.model.pages == weakSelf.page) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
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
    return self.dataSourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZY_HeightScale(110);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_LawyerServiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.isHiddenServiceNumber = NO;
    cell.alreadyBuyServiceModel = self.dataSourceArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_AlredyBuyServiceDetaileViewController * vc = [GH_AlredyBuyServiceDetaileViewController new];
    GHAlreadyBuyServiceListListModel *model = self.dataSourceArray[indexPath.section];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }else{
        return 0.1;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}



@end
