//
//  GH_OrderDetailFooterView.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^payMessage)(NSString * weiKuanString, NSInteger payWay);
@interface GH_OrderDetailFooterView : UIView
@property (nonatomic, strong)payMessage block;
@end

NS_ASSUME_NONNULL_END
