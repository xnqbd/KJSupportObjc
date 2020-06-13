//
//  CKJCommonCellModel.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJSimpleBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

//- (instancetype)init {
//    if (self = [super init]) {
//        [self _showLine:NO];
//    }
//    return self;
//}

@interface CKJCommonCellBGImageViewConfig : CKJBaseModel

@property (strong, nonatomic, nullable) UIImage *image;
@property (strong, nonatomic) UIColor *bgColor;

@property (assign, nonatomic) UIViewContentMode contentMode;


@property (strong, nonatomic, nullable) NSValue *edge;

@property (assign, nonatomic) CGFloat radius;

@end







typedef void(^CKJBlockType1)(void);

@class CKJCommonTableViewCell, CKJCommonCellModel;


typedef void(^CKJCommonCellModelRowBlock)(__kindof CKJCommonCellModel *m);


//- (instancetype)init {
//    if (self = [super init]) {
//        self.displayInTableView = YES;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.showLine = YES;
//        self.cell_bgColor = [UIColor whiteColor];
//    }
//    return self;
//}



// sectionProperty_

@interface CKJCommonCellModel : CKJSimpleBaseModel

/**
 背景设置
 */
@property (strong, nonatomic) CKJCommonCellBGImageViewConfig *bgConfig;
- (void)updateBGConfig:(void(^_Nullable)(CKJCommonCellBGImageViewConfig *bg))BGConfig;

/**
 选中Cell的效果
 */
@property (assign, nonatomic) UITableViewCellSelectionStyle selectionStyle;


/// 分割线edge， 依次看cell.lineEdge，section.lineEdge，style.lineEdge(这个有默认值)的值
@property (strong, nonatomic, nullable) NSValue *lineEdge;

/// 设置分割线是否显示
- (void)_showLine:(BOOL)show;

/// 行高，依次看CKJCommonCellModel.cellHeight，CKJCommonSectionModel.rowHeight，CKJSimpleTableViewStyle.rowHeight的值，如果都为nil，最后自适应高度，也可以设置UITableViewAutomaticDimension
@property (copy, nonatomic, nullable) NSNumber *cellHeight;

/**
 是否选中
 注意：1.如果是用CKJCellModel.CKJBtn7Model，请使用CKJBtn7Model自身的selected
 2.如果是CKJFiveCell，请使用CKJFiveCellModel.chooseBtn_Selected
 */
@property (assign, nonatomic) BOOL selected;

/**
 这个只用在单选的时候
 */
@property (assign, nonatomic) BOOL radio_Selected;

/**
 是否在UITableView里面显示
 */
@property (assign, nonatomic) BOOL displayInTableView;

/**
 标记, 每一个CellModel的cellModel_id 一定不能相同
 */
@property (copy, nonatomic, nullable) NSString *cellModel_id;


/*
 点击某一行时候回调
 */
@property (copy, nonatomic, nullable) CKJCommonCellModelRowBlock didSelectRowBlock;


/**
 每行对应的网络数据，这个属性是id类型
 */
@property (strong, nonatomic, nullable) id networkData;



#pragma mark - Group相关
/**
 标记, 每一个CellModel可能是不同的分组，默认为nil，如果groupIds里的元素如果是空字符，不做标记
 */
@property (strong, nonatomic, nullable, readonly) NSArray <NSString *>*groupIds;
- (void)addGroupId:(NSString *)groupId;
- (void)removeGroupId:(NSString *)groupId;



#pragma mark - 其他

/**
 当前Cell
 */
- (__kindof CKJCommonTableViewCell *)cell;


/**
 带_private开头的是私有的方法，开发者不要私自调用使用
 */
- (void)_privateMethodWithCell:(CKJCommonTableViewCell *)cell;



/**
 创建该对象
 
 @param cellHeight 高度
 @param cellModel_id 这个模型的ID
 @param detailSettingBlock 详细设置回调
 @param didSelectRowBlock 点击了某一行回调
 @return 实例对象
 */
+ (instancetype)commonWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJCommonCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCommonCellModelRowBlock)didSelectRowBlock;


@end

NS_ASSUME_NONNULL_END
