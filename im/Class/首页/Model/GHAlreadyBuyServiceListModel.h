//
//  GHAlreadyBuyServiceListModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/25.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHAlreadyBuyServiceListListModel : NSObject

@property (nonatomic, assign) NSInteger alreadyBuyServiceID;//服务id

@property (nonatomic, copy) NSString *orderNum;//订单编号

@property (nonatomic, copy) NSString *intro;//简介

@property (nonatomic, assign) double totalAmount;//订单总金额

@property (nonatomic, assign) NSInteger state;//订单状态0定金已支付 1律师已分配 2尾款已支付 3订单已完成 4评价已完成

@property (nonatomic, assign) double orderAmount;//定金总额

@property (nonatomic, assign) NSInteger handleTime;//分配时间

@property (nonatomic, assign) NSInteger createTime;//购买时间

@property (nonatomic, copy) NSString *remark;//备注

@property (nonatomic, copy) NSString *lawyerName;//律师名称

@property (nonatomic, copy) NSString *account;//律师账户

@property (nonatomic, copy) NSString *serviceName;//服务名称

@end


@interface GHAlreadyBuyServiceListModel : NSObject

@property (nonatomic, assign) NSInteger startRow;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, assign) NSInteger navigateLastPage;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger navigateFirstPage;

@property (nonatomic, assign) NSInteger endRow;

@property (nonatomic, assign) BOOL hasPreviousPage;

@property (nonatomic, assign) NSInteger prePage;

@property (nonatomic, assign) NSInteger lastPage;

@property (nonatomic, assign) NSInteger firstPage;

@property (nonatomic, assign) BOOL isFirstPage;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger navigatePages;

@property (nonatomic, strong) NSArray<GHAlreadyBuyServiceListListModel *> *list;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, copy) NSArray *navigatepageNums;

@end


NS_ASSUME_NONNULL_END
