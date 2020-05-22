//
//  GH_RecommendedViewController.m
//  im
//
//  Created by ZhiYuan on 2020/4/22.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_RecommendedViewController.h"
#import "GH_RecommendedTableViewCell.h"
#import "GHRecommendModelModel.h"
#import "GH_AlredyBuyServiceDetaileViewController.h"
#import "GH_BuyLawyerServiceViewController.h"
@interface GH_RecommendedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSMutableArray * dataSourceArray;
@property (nonatomic, strong)GHRecommendModelModel * model;
@property (nonatomic, assign)NSInteger pageNum;
@end

@implementation GH_RecommendedViewController

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray new];
    }
    return _dataSourceArray;
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_RecommendedTableViewCell class] forCellReuseIdentifier:@"GH_RecommendedTableViewCell"];
        WeakSelf;
        _table.mj_header = [GH_MJHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        _table.mj_footer = [GH_MJFooter footerWithRefreshingBlock:^{
            [weakSelf getDataMore];
        }];
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationItem setTitle:@"已推荐列表"];
    self.titleText = @"已推荐列表";
    self.backText = @"";
    self.pageNum = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    [self getData];
}
- (void)getData{
    WeakSelf;
    [GetManager httpManagerWithUrl:selectLawyerReCommend parameters:@{@"accid":self.infoId} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        weakSelf.model = [GHRecommendModelModel mj_objectWithKeyValues:data];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        [weakSelf.dataSourceArray removeAllObjects];
        for (GHRecommendListModel * models in weakSelf.model.list) {
            [weakSelf.dataSourceArray addObject:models];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

- (void)getDataMore{
    WeakSelf;
    self.pageNum ++;
    [GetManager httpManagerWithUrl:selectLawyerReCommend parameters:@{@"accid":self.infoId, @"pageNum":@(self.pageNum)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        weakSelf.model = [GHRecommendModelModel mj_objectWithKeyValues:data];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        for (GHRecommendListModel * models in weakSelf.model.list) {
            [weakSelf.dataSourceArray addObject:models];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:Message];
        weakSelf.pageNum --;
    }];
}


- (void)creatUI{
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).mas_offset(UIEdgeInsetsMake(kNavBarHeight, 0, 0, 0 ));
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
//    return self.model.list.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZY_HeightScale(130);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_RecommendedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_RecommendedTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    GHRecommendListModel * model = self.dataSourceArray[indexPath.section];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GHRecommendListModel   * model = self.dataSourceArray[indexPath.section];
    if (model.isBuy == 0) {
        GH_BuyLawyerServiceViewController * buyVC = [GH_BuyLawyerServiceViewController new];
        buyVC.recommendModel = model.services;
        buyVC.laywersID = model.lawyersID;
        buyVC.type = 1;
        [self.navigationController pushViewController:buyVC animated:YES];
    }else{
        GH_AlredyBuyServiceDetaileViewController * vc = [GH_AlredyBuyServiceDetaileViewController new];
        vc.type = 2;
        vc.orderID = model.servicesOrder.orderId;
        [self.navigationController pushViewController:vc animated:YES];
    }
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

- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //在这里实现删除操作
    WeakSelf;
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"确认删除留言?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GHRecommendListModel * model = self.dataSourceArray[indexPath.section];
        [GetManager httpManagerNetWorkHudWithUrl:deleteReCommendNum parameters:@{@"id":@(model.lawyersID)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"删除成功"];
            [weakSelf.table.mj_header beginRefreshing];
        } failture:^(NSString * _Nonnull Message) {
            
        }];
    }];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:cancle];
    [alter addAction:sure];
    [self presentViewController:alter animated:YES completion:nil];
    
    
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
