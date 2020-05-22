//
//  GH_NavViewController.m
//  GH_CustomerNav
//
//  Created by ZhiYuan on 2019/6/1.
//  Copyright © 2019 ZhiYuan. All rights reserved.
//

#import "GH_NavViewController.h"

@interface GH_NavViewController ()<UIGestureRecognizerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)id dragDelegate;
@end

@implementation GH_NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.interactivePopGestureRecognizer.delegate = self;
}
//第三步：实现代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count  >0) {
        self.interactivePopGestureRecognizer.delegate = nil;
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }else{
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果pop完成的时候展示的是根控制器，那么就还原返回手势代理
    //这个方法中携带的viewController就是pop或者push完成后展示的那个控制器
    if (viewController == [self.viewControllers firstObject]) {
        self.interactivePopGestureRecognizer.delegate = self.dragDelegate;
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
