//
//  GHRecommendModelModel.h
//  im
//
//  Created by indulgeIn on 2020/04/22.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHRecommendListServicesModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger depositRequired;

@property (nonatomic, assign) NSInteger serviceID;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, assign) double totalAmount;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) double orderAmount;

@end


@interface GHRecommendListServicesOrderModel : NSObject

@property (nonatomic, assign)NSInteger orderId;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *serviceIntro;

@property (nonatomic, assign) NSInteger handleTime;

@property (nonatomic, copy) NSString *orderNum;

@property (nonatomic, copy) NSString *serviceName;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, copy) NSString *lawyerName;

@end


@interface GHRecommendListModel : NSObject

@property (nonatomic, assign) NSInteger isBuy;

@property (nonatomic, assign) NSInteger lawyersID;

@property (nonatomic, strong) GHRecommendListServicesModel *services;

@property (nonatomic, strong) GHRecommendListServicesOrderModel *servicesOrder;

@end


@interface GHRecommendModelModel : NSObject

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

@property (nonatomic, copy) NSArray<GHRecommendListModel *> *list;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, copy) NSArray *navigatepageNums;

@end


NS_ASSUME_NONNULL_END
