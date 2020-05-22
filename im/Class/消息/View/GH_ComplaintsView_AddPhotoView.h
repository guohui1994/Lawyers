//
//  GH_ComplaintsView_AddPhotoView.h
//  im
//
//  Created by ZhiYuan on 2020/4/10.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^addPhoto)(NSArray * photoArray);
@interface GH_ComplaintsView_AddPhotoView : UIView
@property (nonatomic, copy)addPhoto addPhotoBlock;
@end

NS_ASSUME_NONNULL_END
