//
//  GH_QuestionViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/20.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_QuestionViewController.h"
#import "GH_QuestionTableViewCell.h"
#import "GHQuestionListModelModel.h"
#import "GH_QuesetionDetailsViewController.h"
@interface GH_QuestionViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)GHQuestionListModelModel * model;
@property (nonatomic, strong)NSMutableArray * dataSourceArray;
@end

@implementation GH_QuestionViewController
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_QuestionTableViewCell class] forCellReuseIdentifier:@"GH_QuestionTableViewCell"];

       
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"常见问题";
    self.backText = @"";
    self.dataSourceArray = [NSMutableArray new];
    [self creatUI];
    [self getData];
}
//刷新
- (void)getData{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:questionList parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSArray * array = [GHQuestionListModelModel mj_objectArrayWithKeyValuesArray:data];
        for (GHQuestionListModelModel * model in array) {
            [self.dataSourceArray addObject:model];
        }
        NSLog(@"%@", self.dataSourceArray);
        [self.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_QuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_QuestionTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    GHQuestionListModelModel * model = self.dataSourceArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZY_HeightScale(45);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_QuesetionDetailsViewController * vc = [GH_QuesetionDetailsViewController new];
    GHQuestionListModelModel * model = self.dataSourceArray[indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
