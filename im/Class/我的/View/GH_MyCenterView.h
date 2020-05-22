//
//  GH_MyCenterView.h
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/3.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^itemClick)(NSInteger index);

@interface GH_MyCenterView : UIView
@property (nonatomic, strong)itemClick block;

@property (nonatomic, copy)NSString * titleString;

@end

NS_ASSUME_NONNULL_END
