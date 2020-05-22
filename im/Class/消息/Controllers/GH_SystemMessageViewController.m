//
//  GH_SystemMessageViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_SystemMessageViewController.h"
#import "GH_SystemMessageTableViewCell.h"
#import "GHAllMessageModel.h"
@interface GH_SystemMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSMutableArray * datasourceArray;
@property (nonatomic, assign)int page;
@end

@implementation GH_SystemMessageViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_SystemMessageTableViewCell class] forCellReuseIdentifier:@"GH_SystemMessageTableViewCell"];
        WeakSelf;
        _table.mj_header = [GH_MJHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        _table.mj_footer = [GH_MJFooter footerWithRefreshingBlock:^{
            [weakSelf getMoreData];
        }];
    }
    return _table;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasourceArray = [NSMutableArray new];
    self.titleText = @"系统消息";
    self.backText = @"";
    self.page = 1;
    [self creatUI];
    [self.table.mj_header beginRefreshing];
}

//刷新
- (void)getData{
    WeakSelf;
    [GetManager httpManagerWithUrl:allMessage parameters:@{@"pageNum" : @(1)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.datasourceArray removeAllObjects];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        GHAllMessageModel * models = [GHAllMessageModel mj_objectWithKeyValues:data];
        if (models.pages == 1) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        for (GHAllMessageListModel * model in models.list) {
            [weakSelf.datasourceArray addObject:model];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
    }];
}

//加载更多
- (void)getMoreData{
    self.page ++;
    WeakSelf;
    [GetManager httpManagerWithUrl:allMessage parameters:@{@"pageNum" : @(self.page)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        GHAllMessageModel * models = [GHAllMessageModel mj_objectWithKeyValues:data];
        if (models.pages == 1) {
            [weakSelf.table.mj_footer setHidden:YES];
        }
        for (GHAllMessageListModel * model in models.list) {
            [weakSelf.datasourceArray addObject:model];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_SystemMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_SystemMessageTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = (GHAllMessageListModel *)self.datasourceArray[indexPath.row];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

@end
