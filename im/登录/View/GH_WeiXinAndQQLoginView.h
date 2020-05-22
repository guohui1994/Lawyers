//
//  GH_WeiXinAndQQLoginView.h
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/6.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^weiXinOrQQLogin)(NSInteger index);
@interface GH_WeiXinAndQQLoginView : UIView
@property (nonatomic, strong)weiXinOrQQLogin block;
@end

NS_ASSUME_NONNULL_END
