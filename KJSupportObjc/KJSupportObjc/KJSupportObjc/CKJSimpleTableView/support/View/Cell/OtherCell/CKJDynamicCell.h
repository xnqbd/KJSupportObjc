//
//  CKJRePaintCell.h
//  DYCity
//
//  Created by admin2 on 2020/10/25.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJDynamicCellModel;

typedef void(^CKJDynamicCellBlock)(__weak CKJDynamicCellModel *m);

typedef void(^CKJDynamicCellRefreshUI)(UIView *wrapperView, CKJDynamicCellModel *reM);

@interface CKJDynamicCellModel : CKJCommonCellModel

@property (assign, nonatomic) UIEdgeInsets edge;

@property (copy, nonatomic) CKJDynamicCellRefreshUI refreshUI;


+ (instancetype)dynamicCellModelWithEdge:(nullable NSValue *)edge refreshUI:(CKJDynamicCellRefreshUI)refreshUI detail:(nullable CKJDynamicCellBlock)detail;

@end

@interface CKJDynamicCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
