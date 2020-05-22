//
//  GH_QuesetionDetailsViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/21.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_QuesetionDetailsViewController.h"
#import "GH_QuestionDetailTableViewCell.h"
@interface GH_QuesetionDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@end

@implementation GH_QuesetionDetailsViewController
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_QuestionDetailTableViewCell class] forCellReuseIdentifier:@"GH_QuestionDetailTableViewCell"];
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"问题详情";
    self.backText = @"";
    [self getData];
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


- (void)getData{
    //这个接口是常见问题次数统计
    [GetManager httpManagerWithUrl:commonQuestionCount parameters:@{@"id": @(self.model.questionID)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}

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
    GH_QuestionDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_QuestionDetailTableViewCell"];
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

@end
