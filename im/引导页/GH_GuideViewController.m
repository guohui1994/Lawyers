//
//  GH_GuideViewController.m
//  im
//
//  Created by ZhiYuan on 2019/10/9.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_GuideViewController.h"
#import "AppDelegate.h"
@interface GH_GuideViewController ()<AppThirdCodeDelegate, UIScrollViewDelegate>
{
    UIScrollView * scrollView;
    UIPageControl * pageControll;
}
//立即开启
@property (nonatomic, strong)UIButton * startButton;
@end

@implementation GH_GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"";
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.returnCode = self;
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

- (void)returnGuideArray:(NSArray *)array{
    if (array.count == 0) {
        NSArray * imageArray = @[@"Launch_1",@"Launch_2", @"Launch_3" ];
        scrollView.contentSize = CGSizeMake(screenWidth * imageArray.count, screenHeight);
        scrollView.pagingEnabled = YES;
       
        for (int i = 0; i < imageArray.count; i++) {
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth * i, 0, screenWidth, screenHeight)];
            image.userInteractionEnabled = YES;
            image.image = Images(imageArray[i]);
            [scrollView addSubview:image];
            
            UIButton * skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
            skipButton.backgroundColor = Colors(@"#8269F5");
            [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [image addSubview:skipButton];
            skipButton.layer.cornerRadius = 14.5;
            [skipButton addTarget:self action:@selector(startButtonAction) forControlEvents:UIControlEventTouchDown];
            [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(image.mas_right).mas_offset(-20);
                make.top.equalTo(image).mas_offset(Height_StatusBar + 10.5);
                make.width.equalTo(@80);
                make.height.equalTo(@29);
            }];
            
            if (i == imageArray.count -1) {
                skipButton.hidden = YES;
                self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.startButton.frame = CGRectMake((screenWidth - ZY_WidthScale(160))/2, screenHeight - ZY_HeightScale(131.5), ZY_WidthScale(160), ZY_HeightScale(34));
                [self.startButton setTitle:@"立即开启" forState:UIControlStateNormal];
                //                [self.startButton setBackgroundImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
                //                self.startButton setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
//                [self.startButton setTitleColor:Colors(@"f82f59") forState:UIControlStateNormal];
                self.startButton.backgroundColor = Colors(@"#8269F5");
                [self.startButton setTitleColor:Colors(@"#FFFFFF") forState:UIControlStateNormal];
                self.startButton.layer.cornerRadius = ZY_WidthScale(14);
//                self.startButton.layer.borderWidth = 1;
//                self.startButton.layer.borderColor = Colors(@"f82f59").CGColor;
                self.startButton.titleLabel.font = [UIFont systemFontOfSize:ZY_WidthScale(15)];
                [self.startButton addTarget:self action:@selector(startButtonAction) forControlEvents:UIControlEventTouchDown];
                [image addSubview:self.startButton];
            }
            
            pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake(0, screenHeight - 78, screenWidth, 40)];
            pageControll.numberOfPages = imageArray.count;
            pageControll.currentPage = 0;
            pageControll.currentPageIndicatorTintColor = Colors(@"#8269F5");
            pageControll.pageIndicatorTintColor = [UIColor grayColor];
            [self.view addSubview:pageControll];
        }
    }else{
     scrollView.contentSize = CGSizeMake(screenWidth * array.count, screenHeight);
    scrollView.pagingEnabled = YES;
    for (int i = 0; i < array.count; i++) {
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth * i, 0, screenWidth, screenHeight)];
    image.userInteractionEnabled = YES;
    [image sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@""] options:nil];
    [scrollView addSubview:image];
        UIButton * skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        skipButton.backgroundColor = Colors(@"#8269F5");
        [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [image addSubview:skipButton];
        skipButton.layer.cornerRadius = 14.5;
        [skipButton addTarget:self action:@selector(startButtonAction) forControlEvents:UIControlEventTouchDown];
        [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(image.mas_right).mas_offset(-20);
            make.top.equalTo(image).mas_offset(10.5 + Height_StatusBar);
            make.width.equalTo(@80);
            make.height.equalTo(@29);
        }];
        if (i == array.count -1) {
            skipButton.hidden = YES;
            self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.startButton.frame = CGRectMake((screenWidth - ZY_WidthScale(160))/2, screenHeight - ZY_HeightScale(131.5), ZY_WidthScale(160), ZY_HeightScale(30));
            [self.startButton setTitle:@"立即开启" forState:UIControlStateNormal];
            //                [self.startButton setBackgroundImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
            //                self.startButton setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
            self.startButton.backgroundColor = Colors(@"#8269F5");
            [self.startButton setTitleColor:Colors(@"#FFFFFF") forState:UIControlStateNormal];
            self.startButton.layer.cornerRadius = ZY_WidthScale(15);
//            self.startButton.layer.borderWidth = 1;
//            self.startButton.layer.borderColor = Colors(@"f82f59").CGColor;
            self.startButton.titleLabel.font = [UIFont systemFontOfSize:ZY_WidthScale(15)];
            [self.startButton addTarget:self action:@selector(startButtonAction) forControlEvents:UIControlEventTouchDown];
            [image addSubview:self.startButton];
        }
        
        pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake(0, screenHeight - 78, screenWidth, 40)];
        pageControll.numberOfPages = array.count;
        pageControll.currentPage = 0;
        pageControll.currentPageIndicatorTintColor = Colors(@"#8269F5");
        pageControll.pageIndicatorTintColor = [UIColor grayColor];
        [self.view addSubview:pageControll];
    }
    }
}

- (void)startButtonAction{
    AppDelegate * delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate setRootViewController];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        pageControll.currentPage = 0;
    }else if (scrollView.contentOffset.x == screenWidth){
        pageControll.currentPage = 1;
    }else if(scrollView.contentOffset.x == screenWidth * 2){
        pageControll.currentPage = 2;
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
