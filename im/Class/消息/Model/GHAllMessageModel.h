//
//  GHAllMessageModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/10/08.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHAllMessageListModel : NSObject

@property (nonatomic, assign) NSInteger messageID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger createTime;

@end


@interface GHAllMessageModel : NSObject

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

@property (nonatomic, copy) NSArray<GHAllMessageListModel *> *list;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, copy) NSArray *navigatepageNums;

@end


NS_ASSUME_NONNULL_END
