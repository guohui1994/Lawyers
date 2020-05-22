//
//  AppDelegate.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "AppDelegate.h"
#import "GH_CountAndPasswordLoginViewController.h"
#import "ZYMessageController.h"
#import "GH_GuideViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "GH_SystemMessageViewController.h"
#import "GH_LeaveMessageViewController.h"
#import "GH_LeaveMessageResultViewController.h"
#import "GH_AlredyBuyServiceDetaileViewController.h"
#import "GH_RecommendedViewController.h"
@interface AppDelegate ()<WXApiDelegate,TencentSessionDelegate,QQApiInterfaceDelegate, UNUserNotificationCenterDelegate, JPUSHRegisterDelegate>
@property (nonatomic, strong) Reachability *hostReach;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    /*判断是否第一次启动*/
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           
        });
        
         [self getGuid];
        //第一次启动
        GH_GuideViewController * guidVC = [[GH_GuideViewController alloc]init];
        self.window.rootViewController = guidVC;
    }else{
        //不是第一次启动了
        //        [self setRootViewController];
//        [self launchImage];
        GH_CountAndPasswordLoginViewController * loginVC = [GH_CountAndPasswordLoginViewController new];
        self.window.rootViewController = [Singleton defaultSingleton].isLogin == YES ? [GH_TabBarViewController new] : [[GH_NavViewController alloc]initWithRootViewController:loginVC];
    }
    
  
 
           [self ThirdSet];
    [self registerJPush:launchOptions];
    NSInteger count =  [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    NSLog(@"-----------%ld", count);
    
    
    for (int i = 0; i < 3; i++) {
        NSLog(@"%d", i);
    }
    
    //首先需要设置代理UNUserNotificationCenterDelegate
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            [center removeAllPendingNotificationRequests];
        } else {
            // Fallback on earlier versions
        }
       
    }
    //    [self judgeNetWorkState];
    return YES;
}

- (void)ThirdSet{
//    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [[UINavigationBar appearance] setBackIndicatorImage:backButtonImage];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backButtonImage];
    /**
     控制键盘
     */
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        //控制整个功能是否启用。
        manager.enable = YES;
        //控制点击背景是否收起键盘
        manager.shouldResignOnTouchOutside = YES;
        /**
     网易云信
     推荐在程序启动的时候初始化 NIMSDK
     */
    NSString *appKey        = @"563bc82dc8d88b2e13f2ccb4cea636d0";
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    [[NIMSDK sharedSDK] registerWithOption:option];
   [[NIMSDK sharedSDK] registerWithAppID:@"563bc82dc8d88b2e13f2ccb4cea636d0" cerName:@"test2"];
    [self NIMLogin];
     [self registerPushService];
    /*微信注册*/
//    /*注册微信*/wxdb11265ac6b10f86
    [WXApi registerApp:@"wxa6b1698355be9ea3" enableMTA:YES];
}


-(void)registerJPush:(NSDictionary *) launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString * appKey  = @"64d2126c659c1dd6559228a6";
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:@"Apple"
                 apsForProduction:1
            advertisingIdentifier:nil];
}

- (void)registerPushService
{
    if (@available(iOS 11.0, *))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!granted)
            {
                [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"请开启推送功能否则无法收到推送通知"];

            }
        }];
    }
    else
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    //pushkit
    //    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    //    pushRegistry.delegate = self;
    //    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    
    
    // 注册push权限，用于显示本地推送
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
}
//- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSDictionary * userInfo = [notification userInfo];
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
//    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的 Extras 附加字段，key 是自己定义的
//    UIAlertController * alter = [UIAlertController alertControllerWithTitle:content message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alter addAction:cancle];
//    UIViewController * v = [GH_Tools findVisibleViewController];
//    [v presentViewController:alter animated:YES completion:nil];
//}
- (void)NIMLogin{
    NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
    loginData.account = [Singleton defaultSingleton].ccid;
    loginData.token = [Singleton defaultSingleton].wyToken;
    loginData.forcedMode = YES;
    [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];
}
//获取启动页
- (void)getGuid{
    [GetManager httpManagerWithUrl:systemSet parameters:@{@"parameterName": @"guide_figure"} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSString * jsonString = data[@"value"];
        NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *error = nil;
        NSArray * jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
        [self.returnCode returnGuideArray:jsonObject];
       
    } failture:^(NSString * _Nonnull Message) {
        NSArray * array = @[];
        [self.returnCode returnGuideArray:array];
    }];
    
    
}



- (void)setRootViewController{
    GH_CountAndPasswordLoginViewController * loginVC = [GH_CountAndPasswordLoginViewController new];
    self.window.rootViewController = [Singleton defaultSingleton].isLogin == YES ? [GH_TabBarViewController new] : [[GH_NavViewController alloc]initWithRootViewController:loginVC];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.scheme isEqualToString:@"tencent101832402"]) {
        return  [TencentOAuth HandleOpenURL:url] || [QQApiInterface handleOpenURL:url delegate:self];
        
    }
    else if([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self.returnCode returnWithAlipayWith:[resultDic[@"resultStatus"] integerValue]];
        }];
        return YES;
        
    }else{
        return  [WXApi handleOpenURL:url delegate:self];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme isEqualToString:@"tencent101832402"]) {
        return  [TencentOAuth HandleOpenURL:url]|| [QQApiInterface handleOpenURL:url delegate:self];
    }
    else if([url.host isEqualToString:@"safepay"]){
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self.returnCode returnWithAlipayWith:[resultDic[@"resultStatus"] integerValue]];
        }];
        return YES;
    }else{
        return  [WXApi handleOpenURL:url delegate:self] ;
    }
    
}
// NOTE: 9.0以后使用新API接口1
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.scheme isEqualToString:@"tencent101832402"]) {
        
        return  [TencentOAuth HandleOpenURL:url]|| [QQApiInterface handleOpenURL:url delegate:self];
    }
    else if([url.host isEqualToString:@"safepay"]){
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self.returnCode returnWithAlipayWith:[resultDic[@"resultStatus"] integerValue]];
        }];
        return YES;
    }else{
        return  [WXApi handleOpenURL:url delegate:self] ;
    }
    
}
//微信回调代理
- (void)onResp:(BaseResp *)resp{
    
    // =============== 获得的微信登录授权回调 ============
    if ([resp isMemberOfClass:[SendAuthResp class]])  {
        NSLog(@"******************获得的微信登录授权******************");
        
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode != 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [self showError:@"微信授权失败"];
            });
            return;
        }
        //授权成功获取 OpenId
        NSString *code = aresp.code;
        [self.returnCode returnWithCode:code];
        //        [self getWeiXinOpenId:code];
    }
    // =============== 获得的微信支付回调 ============
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        PayResp * reap = (PayResp *)resp;
        [self.returnCode returnWithWXPayWith:reap.errCode];
    }
    
     /*f微信分享的授权类*/
        if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
            SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
            NSString * string = [NSString stringWithFormat:@"%d", sendResp.errCode];
            [self.returnCode backWeiXinCode:string];
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"shareResult" object:string];
        }
    
}

//#pragma mark - 网络监测 -
//- (void)judgeNetWorkState {
//
//    //先设置网络监测状态为YES
//    self.isReachable = YES;
//
//    //开启网络状况的监听
//    [JGNotification addObserver:self
//                       selector:@selector(reachabilityChanged:)
//                           name:kReachabilityChangedNotification
//                         object:nil];
//    self.hostReach = [Reachability reachabilityWithHostname:@"v2.api.dev.fudiandmore.ie"] ;
//    [self.hostReach startNotifier];  //开始监听，会启动一个run loop
//}
//
////网络链接改变时会调用的方法
//- (void)reachabilityChanged:(NSNotification *)note {
//    Reachability *currReach = [note object];
//    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
//
//    //对连接改变做出响应处理动作
//    NetworkStatus status = [currReach currentReachabilityStatus];
//    //如果没有连接到网络就弹出提醒实况
//    if(status == NotReachable)  {
//
//        self.isReachable = NO;
//        [JGToast showWithText:@"网络连接错误，稍后重试"];
//    }  else {
//
//        self.isReachable = YES;
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
//    NSInteger currentNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
//    if (currentNumber > 0) {
//        currentNumber--;
//    }
//    [UIApplication sharedApplication].applicationIconBadgeNumber = currentNumber  ;
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
 
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    NSInteger type =  [userInfo[@"type"] integerValue];
//    NSInteger currentNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
//    if (currentNumber > 0) {
//        currentNumber--;
//    }
//    [UIApplication sharedApplication].applicationIconBadgeNumber = currentNumber  ;
    if (type == 0) {
        [self checkSystemMessage:userInfo];
    }else if (type == 1){
        [self leaveMessageResult:userInfo];
    }else if (type == 2){
        [self consultinglawayers:userInfo];
    }else if (type == 3){
        [self recommend:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)recommend:(NSDictionary *)userInfo{
    UIViewController * v = [GH_Tools findVisibleViewController];
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@", userInfo[@"title"]] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GH_RecommendedViewController *VC = [GH_RecommendedViewController new];
        VC.infoId = [NSString stringWithFormat:@"%@", userInfo[@"id"]];
        [v.navigationController pushViewController:VC animated:YES];
    }];
    [alter addAction:cancle];
    [alter addAction:sure];
    
    [v presentViewController:alter animated:YES completion:nil];
}

/**
 查看系统消息

 @param userInfo 通知参数
 */
- (void)checkSystemMessage:(NSDictionary *)userInfo{
    UIViewController * v = [GH_Tools findVisibleViewController];
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@", userInfo[@"title"]] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GH_SystemMessageViewController *VC = [GH_SystemMessageViewController new];
        
        [v.navigationController pushViewController:VC animated:YES];
    }];
    [alter addAction:cancle];
    [alter addAction:sure];
    
    [v presentViewController:alter animated:YES completion:nil];
}

/**
 咨询或者分配律师
 */
- (void)consultinglawayers:(NSDictionary *)userInfo{
    UIViewController * v = [GH_Tools findVisibleViewController];
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@", userInfo[@"title"]] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GH_AlredyBuyServiceDetaileViewController *VC = [GH_AlredyBuyServiceDetaileViewController new];
        VC.type = 2;
        VC.orderID = [userInfo[@"id"] integerValue];
        [v.navigationController pushViewController:VC animated:YES];
    }];
    [alter addAction:cancle];
    [alter addAction:sure];
    
    [v presentViewController:alter animated:YES completion:nil];
}

- (void)leaveMessageResult:(NSDictionary *)userInfo{
    UIViewController * v = [GH_Tools findVisibleViewController];
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@", userInfo[@"title"]] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GH_LeaveMessageResultViewController *VC = [GH_LeaveMessageResultViewController new];
        VC.type = 1;
        VC.leaveMessageID = [userInfo[@"id"] integerValue];
        [v.navigationController pushViewController:VC animated:YES];
    }];
    [alter addAction:cancle];
    [alter addAction:sure];
    
    [v presentViewController:alter animated:YES completion:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"活跃");
    if ([Singleton defaultSingleton].isLogin) {
        GH_TabBarViewController * tab = (GH_TabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
        if (count == 0) {
            tab.tabBar.items[1].badgeValue = nil ;
        }else{
            [tab.tabBar.items[1] setBadgeValue:[NSString stringWithFormat:@"%ld", (long)count]];
        }
    }
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
