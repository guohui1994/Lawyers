//
//  GH_ChatViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/10/8.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_ChatViewController.h"
#import "HZPhotoBrowser.h"
#import <AVKit/AVKit.h>
#import "NIMKitAudioCenter.h"
#import "GH_ComplaintsViewController.h"
#import "YBPopupMenu.h"
#import "GH_RecommendedViewController.h"
@interface GH_ChatViewController ()<YBPopupMenuDelegate>
//@property (nonatomic,weak)    id<NIMSessionInteractor> Interactor;
@property (nonatomic, strong)UIView * redView;
@end

@implementation GH_ChatViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}forState:UIControlStateNormal];
    [self getCount];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}forState:UIControlStateNormal];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)getCount{
    [GetManager httpManagerWithUrl:selectReCommendNum parameters:@{@"accid":self.infoId} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        if ([data integerValue] == 0) {
            self.redView.hidden = YES;
        }else{
            self.redView.hidden = NO;
        }
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt addTarget:self action:@selector(rightBarButtonItemClick:) forControlEvents:UIControlEventTouchDown];
    [bt setImage:Images(@"msg_nav_rightIcon") forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:bt];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.redView  = [UIView new];
    self.redView.backgroundColor = [UIColor redColor];
    self.redView.layer.cornerRadius = 2.5;
    self.redView.hidden = YES;
    [bt addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(bt);
        make.width.height.equalTo(@5);
    }];
}

- (void)complaintsAction{
    GH_ComplaintsViewController * vc = [GH_ComplaintsViewController new];
    vc.infoId = self.infoId;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)rightBarButtonItemClick:(UIButton *)btn {
    [YBPopupMenu showRelyOnView:btn titles:@[@"投诉",@"推荐服务"] icons:nil menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
        popupMenu.itemHeight = 50;
        popupMenu.isShowShadow = NO;
        popupMenu.delegate = self;
    }];
    
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    
    if (index == 0) {//投诉
        GH_ComplaintsViewController * vc = [GH_ComplaintsViewController new];
        vc.infoId = self.infoId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1) { //推荐服务
        GH_RecommendedViewController * recommendVC = [GH_RecommendedViewController new];
        recommendVC.infoId = self.infoId;
        [self.navigationController pushViewController:recommendVC animated:YES];
    }
}
/**
 点击cell的方法

 @param event 点击事件----判断消息类型来执行不同的操作
 @return ----
 */
- (BOOL)onTapCell:(NIMKitEvent *)event{
    NSDictionary * dic =  [(NSObject *)event.messageModel.message.messageObject mj_JSONObject];
    NSString * url = dic[@"url"];
    if (event.messageModel.message.messageType == 1) {
        NSMutableArray * array = [NSMutableArray new];
        [array addObject:url];
        HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
        browser.currentImageIndex = 0;
        browser.imageArray = array;
        [browser show];
    }else if (event.messageModel.message.messageType == 3){
        NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@", url]];
        AVPlayerViewController *ctrl = [[AVPlayerViewController alloc] init];
        ctrl.player= [[AVPlayer alloc]initWithURL:urls];
        [ctrl.player play];
        [self presentViewController:ctrl animated:YES completion:nil];
    }else if (event.messageModel.message.messageType == 2){
            [self mediaAudioPressed:event.messageModel];
    }
    

    return YES;
}

#pragma mark - NIMMeidaButton
- (void)mediaAudioPressed:(NIMMessageModel *)messageModel
{
    if (![[NIMSDK sharedSDK].mediaManager isPlaying]) {
        [[NIMSDK sharedSDK].mediaManager switchAudioOutputDevice:NIMAudioOutputDeviceSpeaker];
        [[NIMKitAudioCenter instance] play:messageModel.message];
        
    } else {
        [[NIMSDK sharedSDK].mediaManager stopPlay];
    }
}


/**
 录音时间判断

 @param filepath 录音保存地址
 @return 能否播放
 */
- (BOOL)recordFileCanBeSend:(NSString *)filepath
{
    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath: filepath] options:nil];
    CMTime audioDuration = audioAsset.duration;
    //音频时间
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);

    if (audioDurationSeconds < 1.0) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"录音时间太短"];
        return NO;
    }else{
        return YES;
    }
}



//- (NSArray *)defaultMediaItems{
//    return @[[NIMMediaItem item:@"onTapMediaItemPicture:"
//                    normalImage:[UIImage nim_imageInKit:@"bk_media_picture_normal"]
//                  selectedImage:[UIImage nim_imageInKit:@"bk_media_picture_nomal_pressed"]
//                          title:@"相册"],
//
//             [NIMMediaItem item:@"onTapMediaItemShoot:"
//                    normalImage:[UIImage nim_imageInKit:@"bk_media_shoot_normal"]
//                  selectedImage:[UIImage nim_imageInKit:@"bk_media_shoot_pressed"]
//                          title:@"拍摄"],
//             ];
//}


//- (NSArray *)menusItems:(NIMMessage *)message{
//    
//}

//- (void)
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
