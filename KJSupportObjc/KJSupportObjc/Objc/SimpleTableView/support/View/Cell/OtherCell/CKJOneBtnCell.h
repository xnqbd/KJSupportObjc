//
//  CKJOneBtnCell.h
//  MobileHospital_Renji
//
//  Created by admin2 on 2020/1/14.
//  Copyright © 2020 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJOneBtnCellModel;

typedef void(^CKJOneBtnCellClickBtn)(__kindof CKJOneBtnCellModel *cm, UIButton *btn);

typedef void(^CKJOneBtnCellRowBlock)(__kindof CKJOneBtnCellModel *_Nonnull m);

/*
 
 let model1 =  CKJOneBtnCellModel.oneBtnFillStyle(withCellHeight: NSNumber(value: 90), title: "立即办理", radius: NSNumber(value: 6), bgColor: UIColor.kjwd_blueBtn(), detail: { (m) in
    }, clickBtn: { (m, btn) in
        print("点击立即办理")
    }) { (make, superView) in
        make.edges.equalTo()(superView)?.with()?.insets()(UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20))
    }
 
 
 

    // 如果想要上面的cell 分割线
    idCardNumber.lineEdge = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];

 
     CKJOneBtnCellModel *commit = [CKJOneBtnCellModel oneBtnWithCellHeight:@(UITableViewAutomaticDimension) title:@"提交" detail:^(__kindof CKJOneBtnCellModel * _Nonnull m) {
     [m updateBGConfig:^(CKJCommonCellBGImageViewConfig * _Nonnull bg) {
         bg.bgColor = self.simpleTableView.backgroundColor;
     }];
     [m updateBtnData:^(CKJBtnItemData * _Nonnull btnData) {
         btnData.cornerRadius = 6;
         btnData.normalBgImage = [UIImage kjwd_imageWithColor:[UIColor kjwd_blueBtnColor] size:CGSizeMake(300, 40)];
     }];
 } clickBtn:^(__kindof CKJOneBtnCellModel * _Nonnull cm, UIButton * _Nonnull btn) {
     NSLog(@"%@   ", @"点击提交");
 } updateConstraint:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
     make.height.equalTo(@50);
     make.edges.equalTo(superview).insets(UIEdgeInsetsMake(20, 30, 20, 30));
 }];
 
 */
@interface CKJOneBtnCellModel : CKJCommonCellModel

@property (copy, nonatomic) void(^updateConstraint)(MASConstraintMaker *make, UIView *superview);


@property (strong, nonatomic) CKJBtnItemData *btnData;

@property (copy, nonatomic) CKJOneBtnCellClickBtn clickBtn;

- (void)updateBtnData:(void(^)(CKJBtnItemData *btnData))block;

/// 在detailSettingBlock详细设置
+ (instancetype)oneBtnWithCellHeight:(nullable NSNumber *)cellHeight detail:(nullable CKJOneBtnCellRowBlock)detail clickBtn:(CKJOneBtnCellClickBtn)clickBtn updateConstraint:(void(^)(MASConstraintMaker *make, UIView *superview))updateConstraint;
/// 标题(默认白色，16)
+ (instancetype)oneBtnWithCellHeight:(nullable NSNumber *)cellHeight title:(id)title detail:(nullable CKJOneBtnCellRowBlock)detail clickBtn:(CKJOneBtnCellClickBtn)clickBtn updateConstraint:(void(^)(MASConstraintMaker *make, UIView *superview))updateConstraint;

/// 实心
+ (instancetype)oneBtnFillStyleWithCellHeight:(nullable NSNumber *)cellHeight title:(id)title radius:(nullable NSNumber *)radius bgColor:(UIColor *)bgColor detail:(nullable CKJOneBtnCellRowBlock)detail clickBtn:(CKJOneBtnCellClickBtn)clickBtn updateConstraint:(void(^)(MASConstraintMaker *make, UIView *superview))updateConstraint;

/// 空心
+ (instancetype)oneBtnEmptyStyleWithCellHeight:(nullable NSNumber *)cellHeight title:(NSString *)title radius:(nullable NSNumber *)radius bgColor:(nullable UIColor *)bgColor text_Border_Color:(UIColor *)text_Border_Color detail:(nullable CKJOneBtnCellRowBlock)detail clickBtn:(CKJOneBtnCellClickBtn)clickBtn updateConstraint:(void(^)(MASConstraintMaker *make, UIView *superview))updateConstraint;




@end

@interface CKJOneBtnCell : CKJCommonTableViewCell //<CKJOneBtnCellModel *>

@end

NS_ASSUME_NONNULL_END
