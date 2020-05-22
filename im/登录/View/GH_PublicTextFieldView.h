//
//  GH_PublicTextFieldView.h
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/6.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnTextField)(UITextField * textField);

@interface GH_PublicTextFieldView : UIView

@property (nonatomic, assign)BOOL registerFirstRespoder;

@property (nonatomic, copy)returnTextField block;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, copy)NSString * text;

@property (nonatomic, assign)BOOL isScreat;//是否密文输入

- (instancetype)initWithFrame:(CGRect)frame headerImage:(NSString *)headerImage placeholder:(NSString *)placeholder;



@end

NS_ASSUME_NONNULL_END
