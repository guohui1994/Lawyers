//
//  ZYMessageController.m
//  Lawyers_Use
//
//  Created by 郭军 on 2019/9/11.
//  Copyright © 2019 JG. All rights reserved.
//

#import "ZYMessageController.h"
//#import "ZYSystemMessageController.h"
//#import "ZYNIMSessionViewController.h" //聊天
#import "NIMKitInfoFetchOption.h"
#import "ZYMessageTopView.h"
#import "ZYMessageTCell.h"
#import "GHLastMessageModel.h"
#import "GH_SystemMessageViewController.h"
#import "GH_ChatViewController.h"
@interface ZYMessageController ()

@property (nonatomic, strong) ZYMessageTopView *TopView;



@end

@implementation ZYMessageController

- (ZYMessageTopView *)TopView {
    if (!_TopView) {
        _TopView = [[ZYMessageTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 92.f)];
        WeakSelf;
        _TopView.backInfo = ^{
            [weakSelf SystemMsg];
        };
    }
    return _TopView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:Fonts(18), NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [self.navigationController.navigationBar navBarToBeSystem];
//    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
//    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor whiteColor] image:nil isOpaque:NO];//颜色
    [self GetLastMessage];
    GH_TabBarViewController * tab = (GH_TabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    NSLog(@"1----%ld", count);
    if (count == 0) {
        tab.tabBar.items[1].badgeValue = nil ;
        
    }else{
        [tab.tabBar.items[1] setBadgeValue:[NSString stringWithFormat:@"%ld", count]];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    self.autoRemoveRemoteSession = YES;
    
    [self configUI];

}

- (void)GetLastMessage {

    WeakSelf;
    [GetManager httpManagerWithUrl:lastMessage parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        GHLastMessageModel * model = [GHLastMessageModel mj_objectWithKeyValues:data];
        weakSelf.TopView.SysMsgModel = model;
    } failture:^(NSString * _Nonnull Message) {
//        [weakSelf aut]
    }];
    
}




//配置UI
- (void)configUI {

    self.tableView.tableHeaderView = self.TopView;
//    [self.tableView jg_registerCell:@"ZYMessageTCell"];
    [self.tableView registerClass:[ZYMessageTCell class] forCellReuseIdentifier:@"ZYMessageTCell"];
    self.tableView.frame = CGRectMake(0, Height_NavBar, screenWidth, screenHeight );
}

- (void)refresh{
    [self.tableView reloadData];
}


- (void)SystemMsg {
    
    GH_SystemMessageViewController *VC = [GH_SystemMessageViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYMessageTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZYMessageTCell"];
    NIMRecentSession *recent = self.recentSessions[indexPath.row];
    cell.Sesson = recent;
    cell.NameLbl.text = [self nameForRecentSession:recent];
    cell.DetailLbl.attributedText  = [self contentForRecentSession:recent];
    cell.TimeLbl.text = [self timestampDescriptionForRecentSession:recent];
    
    return cell;
}


//侧滑允许编辑cell
- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

//执行删除操作
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
   
    NIMRecentSession *recentSession = self.recentSessions[indexPath.row];

    //清理本地数据
    [self.recentSessions removeObjectAtIndex:indexPath.row];
    
    NIMDeleteMessagesOption *option = [NIMDeleteMessagesOption new];
    option.removeSession = YES;
    option.removeTable = YES;

    [[NIMSDK sharedSDK].conversationManager deleteAllmessagesInSession:recentSession.session option:option];
    [self refresh];
}

//侧滑出现的文字
- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath {
    return @"删除";
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 77.0f;
}

/**
 *  选中某一条最近会话时触发的事件回调
 *
 *  @param recent    最近会话
 *  @param indexPath 最近会话cell所在的位置
 *  @discussion      默认将进入会话界面
 */
- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath {

//    NIMRecentSession *recentSession = self.recentSessions[indexPath.row];
    //自定义聊天页面, 继承第三方
    GH_ChatViewController *vc = [[GH_ChatViewController alloc] initWithSession:recent.session];
   
    NIMKitInfo * info = [self GetInfoBySession:recent.session];
    vc.infoId = info.infoId;
    [self.navigationController pushViewController:vc animated:YES];
}
//通过会话对象获取信息
- (NIMKitInfo *)GetInfoBySession:(NIMSession *)session {
    
    NIMKitInfo *info = nil;
    if (session.sessionType == NIMSessionTypeTeam)
    {
        info = [[NIMKit sharedKit] infoByTeam:session.sessionId option:nil];
    }
    else
    {
        NIMKitInfoFetchOption *option = [[NIMKitInfoFetchOption alloc] init];
        option.session = session;
        info = [[NIMKit sharedKit] infoByUser:session.sessionId option:option];
    }
    
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:info.infoId];
    
    
    return info;
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
