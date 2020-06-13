//
//  RJBillDetailModel.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJBillDetailModel.h"
#import "CKJLeftRightTopEqualCell.h"
#import "CKJLeftRightCenterEqualCell.h"

@implementation RJBillDetailModel



- (NSMutableArray <__kindof CKJCommonCellModel *>* _Nonnull)combineCellModelsToArray {
    NSMutableArray<__kindof CKJCommonCellModel *>*result = [NSMutableArray array];
    CGFloat emptyHeight = 5;
    
    CKJEmptyCellModel *headerEmpty = [CKJEmptyCellModel emptyCellModelWithHeight:emptyHeight showLine:NO];
    CKJEmptyCellModel *footerEmpty = [CKJEmptyCellModel emptyCellModelWithHeight:emptyHeight showLine:YES];
    
    UIColor *color333 = [UIColor kjwd_title];
    
    CGFloat margin = 20;
    CGFloat cellH = 0;
//    
//    CKJLeftRightTopEqualCellRowBlock block = ^(CKJLeftRightTopEqualCellModel *model) {
//        //         model.showLine = YES;
//        // model.rightLab_textAlignment = NSTextAlignmentRight;
//        model.leftLab_MarginTo_SuperViewLeft = margin;
//        model.rightLab_MarginTo_SuperViewRight = margin;
//        
//        // 如果你需要在点击这些Cell的时候得到Self的信息，可以把下面这行打开
//        model.extension_Obj1 = self;
//    };
//    
//    CKJLeftRightTopEqualCellModel *model1 = [CKJLeftRightTopEqualCellModel modelWithCellHeight:@(cellH) cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightTopEqualCellModel * _Nonnull m) {
//        m.leftAttStr = WDCKJAttributed2(@"类别名称：", color333, nil);
//        m.rightAttStr = WDCKJAttributed2(self.ProjectType, color333, nil);
//        block(m);
//    } didSelectRowBlock:nil];
//    
//    CKJLeftRightTopEqualCellModel *model2 = [CKJLeftRightTopEqualCellModel modelWithCellHeight:@(cellH) cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightTopEqualCellModel * _Nonnull m) {
//        m.leftAttStr = WDCKJAttributed2(@"药品名称：", color333, nil);
//        m.rightAttStr = WDCKJAttributed2(self.ProjectName, color333, nil);
//        block(m);
//    } didSelectRowBlock:nil];
//    
//    CKJLeftRightTopEqualCellModel *model3 = [CKJLeftRightTopEqualCellModel modelWithCellHeight:@(cellH) cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightTopEqualCellModel * _Nonnull m) {
//        m.leftAttStr = WDCKJAttributed2(@"药品规格：", color333, nil);
//        m.rightAttStr = WDCKJAttributed2(self.Spec, color333, nil);
//        block(m);
//    } didSelectRowBlock:nil];
//    
//    CKJLeftRightTopEqualCellModel *model4 = [CKJLeftRightTopEqualCellModel modelWithCellHeight:@(cellH) cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightTopEqualCellModel * _Nonnull m) {
//        m.leftAttStr = WDCKJAttributed2(@"药品数量：", color333, nil);
//        m.rightAttStr = WDCKJAttributed2(self.Unit, color333, nil);
//        block(m);
//    } didSelectRowBlock:nil];
//    
//    CKJLeftRightTopEqualCellModel *model5 = [CKJLeftRightTopEqualCellModel modelWithCellHeight:@(cellH) cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightTopEqualCellModel * _Nonnull m) {
//        m.leftAttStr = WDCKJAttributed2(@"药品单价：", color333, nil);
//        m.rightAttStr = WDCKJAttributed2([NSString stringWithFormat:@"%@元", self.Price], [UIColor redColor], nil);
//        block(m);
//    } didSelectRowBlock:nil];
//    
//    [result addObjectsFromArray:@[headerEmpty, model1, model2, model3, model4, model5, footerEmpty]];
    
    return result;
}


@end
