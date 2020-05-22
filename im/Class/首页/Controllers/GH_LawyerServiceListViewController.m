//
//  GH_BuyLawyerServiceViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_LawyerServiceListViewController.h"
#import "GH_LawyerServiceListTableViewCell.h"
#import "GH_BuyLawyerServiceViewController.h"
#import "GH_AlreadyBuyServiceListViewController.h"
#import "GHBuyServiceLisetModelModel.h"
@interface GH_LawyerServiceListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSMutableArray * dataSourceArray;//数据数组
@property (nonatomic, assign)int page;
@property (nonatomic, strong)GHBuyServiceLisetModelModel * model;
@end

@implementation GH_LawyerServiceListViewController


- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_LawyerServiceListTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        _table.showsVerticalScrollIndicator = NO;
        WeakSelf;
        _table.mj_header = [GH_MJHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        _table.mj_footer = [GH_MJFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"购买法律服务";
    self.backText = @"";
    self.page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSourceArray = [NSMutableArray new];
    [self creatUI];
    [self.table.mj_header beginRefreshing];
}
- (void)creatUI{
        //已购买过的服务按钮
        UIButton * buySeiviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buySeiviceButton setTitle:@"已购买服务" forState:UIControlStateNormal];
        [buySeiviceButton addTarget:self action:@selector(buyServiceButtonClick) forControlEvents:UIControlEventTouchDown];
        [buySeiviceButton setTitleColor:Colors(@"#333333") forState:UIControlStateNormal];
        buySeiviceButton.titleLabel.font = Fonts(15);
        [self.customNavBar addSubview:buySeiviceButton];
        [buySeiviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.customNavBar.mas_right).mas_offset(-ZY_WidthScale(15));
            make.bottom.equalTo(self.customNavBar.mas_bottom);
            make.height.equalTo(@(44));
        }];
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
    [GetManager httpManagerWithUrl:buyServiceList parameters:@{@"pageNum":@(1)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        weakSelf.model = [GHBuyServiceLisetModelModel mj_objectWithKeyValues:data];
        
        for (GHBuyServiceLisetListModel * model1 in weakSelf.model.list) {
            [weakSelf.dataSourceArray addObject:model1];
        }
        if (weakSelf.model.pageNum == 1) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

//加载更多
- (void)loadMoreData{
    self.page ++;
    WeakSelf;
    [GetManager httpManagerWithUrl:buyServiceList parameters:@{@"pageNum":@(self.page)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        weakSelf.model = [GHBuyServiceLisetModelModel mj_objectWithKeyValues:data];
        if (weakSelf.page == weakSelf.model.pageNum) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        for (GHBuyServiceLisetListModel * model1 in weakSelf.model.list) {
            [weakSelf.dataSourceArray addObject:model1];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
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
    cell.isHiddenServiceNumber = YES;
    GHBuyServiceLisetListModel * model = self.dataSourceArray[indexPath.section];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_BuyLawyerServiceViewController * vc = [GH_BuyLawyerServiceViewController new];
    GHBuyServiceLisetListModel * model = self.dataSourceArray[indexPath.section];
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


#pragma mark ---已购买过的服务
- (void)buyServiceButtonClick{
    GH_AlreadyBuyServiceListViewController * vc = [GH_AlreadyBuyServiceListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
