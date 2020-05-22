//
//  GH_ShareManager.h
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/4.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger){
    ShareWithThird = 0,//只是单纯的分享到QQ, 微信
    ShareWithThirdWithSaveDefault = 1,//添加保存本地, 二维码功能
}Type;

typedef void(^selectIndex)(NSInteger index);

@interface GH_ShareManager : NSObject
+ (GH_ShareManager *)shareSingleton;



@property(nonatomic, strong)selectIndex block;
- (void)creatShrarView:(Type) type;

@end

NS_ASSUME_NONNULL_END
