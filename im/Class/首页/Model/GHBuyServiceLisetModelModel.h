//
//  GHBuyServiceLisetModelModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/24.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHBuyServiceLisetListModel : NSObject

@property (nonatomic, assign) double orderAmount;//定金价格

@property (nonatomic, assign) NSInteger serviceID;//服务id

@property (nonatomic, assign) double totalAmount;//总价格

@property (nonatomic, copy) NSString *name;//服务名称

@property (nonatomic, copy) NSString *intro;//定金价格

@property(nonatomic, assign)int depositRequired;//0是不需要定金1是需要定金
@end


@interface GHBuyServiceLisetModelModel : NSObject

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

@property (nonatomic, strong) NSArray<GHBuyServiceLisetListModel *> *list;

@property (nonatomic, assign) NSInteger pageNum;//总页数

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, copy) NSArray *navigatepageNums;

@end


NS_ASSUME_NONNULL_END
