//
//  CKJBaseCustomViewCell.h
//  DYCity
//
//  Created by admin2 on 2020/10/23.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface CKJBaseStaticCellConfig : CKJCommonCellConfig


@property (assign, nonatomic) UIEdgeInsets edge;

@property (strong, nonatomic) UIView *staticView;


+ (instancetype)staticCellConfigWithEdge:(UIEdgeInsets)edge createStaticView:(UIView *(^)(void))createStaticView;


@end


@interface CKJBaseStaticCellModel : CKJCommonCellModel



@end


/// 这个类的 所有 子类  在 cellForRow 的 时候都不会 重新刷新，要保证 一个 CKJSimpleTableView 里面 只有 CKJBaseStaticCell 子类不能重复， 也就是说，一个 CKJSimpleTableView 里有 CKJStaticCell1的时候，如果还想在使用，那只能使用 CKJStaticCell2了，所以系统暂时子类化了 两个子类 CKJStaticCell1 和 CKJStaticCell2，
@interface CKJBaseStaticCell : CKJCommonTableViewCell

@end



@interface CKJStaticCell1Model : CKJBaseStaticCellModel

@end


@interface CKJStaticCell1 : CKJBaseStaticCell

@end



@interface CKJStaticCell2Model : CKJBaseStaticCellModel

@end


@interface CKJStaticCell2 : CKJBaseStaticCell

@end



NS_ASSUME_NONNULL_END
