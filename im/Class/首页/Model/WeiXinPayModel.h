//
//  WeiXinPayModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/25.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface WeiXinPayModel : NSObject

@property (nonatomic, copy) NSString *prepayid;

@property (nonatomic, copy) NSString *partnerid;

@property (nonatomic, copy) NSString *package;

@property (nonatomic, copy) NSString *noncestr;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *appid;

@end


NS_ASSUME_NONNULL_END
