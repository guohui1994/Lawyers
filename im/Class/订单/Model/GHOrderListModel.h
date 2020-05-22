//
//  GHOrderListModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/25.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHOrderListListModel : NSObject

@property (nonatomic, copy) NSString *remark;//备注

@property (nonatomic, assign) NSInteger createTime;//定金支付时间

@property (nonatomic, assign) double orderAmount;//定金总额

@property (nonatomic, assign) NSInteger orderID;//订单ID

@property (nonatomic, assign) double totalAmount;//服务价格总额

@property (nonatomic, copy) NSString *orderNum;//订单编号

@property (nonatomic, copy) NSString *intro;//备注

@property (nonatomic, copy) NSString *serviceName;//服务名称

@property (nonatomic, assign) NSInteger evaluateStar;//评论星数

@property (nonatomic, copy)NSString * evaluateText;//评论内容

@property (nonatomic, assign) NSInteger state;//订单状态0定金已支付 1律师已分配 2尾款已支付 3订单已完成 4评价已完成

@property (nonatomic, assign)double totalMoney;//支付总额

@property (nonatomic, assign)double finishTime;//完成时间

@property (nonatomic, copy)NSString * evaluatePic;//图片字符串

@property (nonatomic, assign)NSInteger evaluateTime;//评价时间

@property (nonatomic, assign)double tailMoney;//尾款
@end


@interface GHOrderListModel : NSObject

@property (nonatomic, assign) NSInteger startRow;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger pages;//总页数

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

@property (nonatomic, strong) NSArray<GHOrderListListModel *> *list;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, copy) NSArray *navigatepageNums;

@end


NS_ASSUME_NONNULL_END
