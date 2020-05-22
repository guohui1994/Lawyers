//
//  GH_OrderSelectPhotoAndTextTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^selectPhoto)(void);
@interface GH_OrderSelectPhotoAndTextTableViewCell : UITableViewCell
@property (nonatomic, strong)selectPhoto block;

@property (nonatomic, strong)NSArray * photoArray;

@property (nonatomic, strong)NSArray * photoArrayUrl;//评价图片数组的url
@property (nonatomic, copy)void(^submitAppriase) (NSString * text);
@property (nonatomic, copy)void(^textBlock)(NSString * text);
@property (nonatomic, copy)NSString * appriceString;

@property (nonatomic, copy)NSString * addPicString;//图片
@property (nonatomic, copy)NSString * submitText;//提交按钮的文字

@property (nonatomic, copy)NSString * placeHolder;
@property (nonatomic, copy)NSString * tex;
@property (nonatomic, strong)GHOrderListListModel * model;


@end

NS_ASSUME_NONNULL_END
