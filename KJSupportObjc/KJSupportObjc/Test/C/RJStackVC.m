//
//  RJSquareVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/28.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJStackVC.h"
#import "CKJStackCell.h"
#import "CKJSquareCell1.h"
#import "CKJSquareCell2.h"
#import "CKJTableViewCell2.h"


#define kBuleBtnColor [UIColor kjwd_r:25 g:130 b:197 alpha:1]


@interface RJStackVC ()

@end

@implementation RJStackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJStackCell示例";
    [self initSimpleTableViewData];
}

- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
    
    CKJSquareCell1Config *config1 = [CKJSquareCell1Config configWithDetailSettingBlock:^(CKJSquareCell1Config * _Nonnull m) {
        m.edge = UIEdgeInsetsMake(0, 20, 0, 20);
        m.delegate = [m squareWithNumberOfItemsInSingleLine:3];
    }];
    
    CKJSquareCell2Config *config2 = [CKJSquareCell2Config configWithDetailSettingBlock:^(CKJSquareCell2Config * _Nonnull m) {
        m.h_itemSpacing = 20;
        m.edge = UIEdgeInsetsMake(0, 20, 0, 20);
        m.delegate = [m squareWithNumberOfItemsInSingleLine:3];
    }];
    return @{
             NSStringFromClass([CKJSquareCell1Model class]) : @{cellKEY : NSStringFromClass([CKJSquareCell1 class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config1},
             NSStringFromClass([CKJSquareCell2Model class]) : @{cellKEY : NSStringFromClass([CKJSquareCell2 class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config2}
             };
}

- (void)initSimpleTableViewData {
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    
    KJ_typeweakself
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:120 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.bgVColor = kBuleBtnColor;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:nil left:15];
            
            m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"预交金余额(元)", [UIColor whiteColor], @15) bottomAttributedText:WDCKJAttributed5(@"2000.00", [UIColor whiteColor], @42) topEdge:UIEdgeInsetsMake(15, 0, 0, 0) bottomEdge:UIEdgeInsetsMake(0, 0, 25, 0)];
            
            m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(60, 30) normalImage:nil rightMargin:20 detailSettingBlock:^(CKJBtn8Model * _Nonnull sender) {
                sender.normalAttributedTitle = WDCKJAttributed2(@"充值", [UIColor whiteColor], @15);
                sender.cornerRadius = 15;
                sender.borderColor = [UIColor kjwd_r:169 g:218 b:255 alpha:1];
                sender.borderWidth = 2;
            } didClickBtn8Handle:^(CKJCell * _Nonnull cell, CKJBtn8Model * _Nonnull btn8Model) {
                NSLog(@"点击充值");
            }];
        } didSelectRowBlock:nil];
        section.modelArray = @[model1];
        [sections addObject:section];
    }
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 15;
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"预交金明细", [UIColor kjwd_titleColor333333], nil) left:15];
            
            m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(60, 30) normalImage:nil rightMargin:12 detailSettingBlock:^(CKJBtn8Model * _Nonnull sender) {
                sender.normalAttributedTitle = WDCKJAttributed2(@"筛选", kBuleBtnColor, nil);
            } didClickBtn8Handle:^(CKJCell * _Nonnull cell, CKJBtn8Model * _Nonnull btn8Model) {
                NSLog(@"点击筛选");
                if (cell.currentSectionAllCellModelArray.count > 1) return;
                [cell.simpleTableView appendCellModelArray:[weakSelf extensionCellModels] atLastRow_InAllCellModelArrayOfSection:cell.section withRowAnimation:UITableViewRowAnimationTop animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                    animationBlock();
                }];
            }];
        } didSelectRowBlock:nil];
        section.modelArray = @[model1];
        [sections addObject:section];
    }
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 15;
        UIImage *(^imageBlcok)(NSString *title) = ^UIImage *(NSString *title){
            UIImage *image = [UIImage imageNamed:title];
            image = [image kjwd_scaleToSize:CGSizeMake(36, 36)];
            return image;
        };
        CKJSquare1FuncModel *(^block)(NSString *title, NSString *image, void(^tap)(void)) = ^CKJSquare1FuncModel *(NSString *title, NSString *image, void(^tap)(void)){
            CKJSquare1FuncModel *temp = [CKJSquare1FuncModel modelWithTitle:WDCKJAttributed2(title, [UIColor kjwd_titleColor333333], @15) image:imageBlcok(image) func:tap];
            return temp;
        };
        
        CKJSquareCell1Model *model1 = [CKJSquareCell1Model modelWithCellHeight:80 cellModel_id:nil detailSettingBlock:^(__kindof CKJStackCellModel * _Nonnull m) {
            m.showLine = NO;
            m.data = @[
                       block(@"营养点餐", @"预约检查", ^{
                       }),
                       block(@"预约出院", @"预约出院", ^{
                       }),
                       block(@"日间手术", @"日间手术", ^{
                       }),
                       ];
        } didSelectRowBlock:nil];
        
        
        CKJSquareCell1Model *_newCellModel = [CKJSquareCell1Model modelWithCellHeight:80 cellModel_id:nil detailSettingBlock:^(__kindof CKJStackCellModel * _Nonnull m) {
            m.showLine = NO;
            m.data = @[
                       block(@"院内平面图", @"院内平面图", ^{
                       })
                       ];
        } didSelectRowBlock:nil];
     
        CKJSquareCell1Model *model2 = [CKJSquareCell1Model modelWithCellHeight:80 cellModel_id:nil detailSettingBlock:^(__kindof CKJStackCellModel * _Nonnull m) {
            m.showLine = NO;
            m.data = @[
                       block(@"营养点餐", @"预约检查", ^{
                       }),
                       block(@"预约出院", @"预约出院", ^{
                       }),
                       [CKJSquare1FuncModel modelWithStyle:^(CKJSquare1StyleModel * _Nonnull __weak style1, CKJSquare1StyleModel * _Nonnull __weak style2) {
                           style1.title = WDCKJAttributed2(@"更多", [UIColor kjwd_titleColor333333], nil);
                           style1.image = imageBlcok(@"touxiang.jpg");
                           style1.func = ^{
                               style1.styleEnable = NO;
                               style2.styleEnable = YES;
                               [weakSelf.simpleTableView appendCellModelArray:@[_newCellModel] atLastRow_InAllCellModelArrayOfSection:2 withRowAnimation:UITableViewRowAnimationAutomatic animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                                   animationBlock();
                               }];
                           };
                           style2.title = WDCKJAttributed2(@"营养点餐", [UIColor kjwd_titleColor333333], nil);
                           style2.image = imageBlcok(@"zhuyuan预交金充值");
                           style2.func = ^{
                               NSLog(@"%@ ", @"点击了营养点餐");
                           };
                       }]
                       ];
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model1, model2];
        [sections addObject:section];
    }
    
    
    for (int i = 0; i < 20; i++) {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        
        CKJBtn8Model *btn8 = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(23, 23) normalImage:[UIImage imageNamed:@"钱icon"] rightMargin:20 detailSettingBlock:nil didClickBtn8Handle:nil];
        
        //3.初始化NSTextAttachment对象
        NSTextAttachment *attchment = [[NSTextAttachment alloc]init];
        attchment.bounds = CGRectMake(0, -1.5, 3, 14);//设置frame
        attchment.image = [UIImage kjwd_imageNamed:@"Rectangle icon"];//设置图片
        
        NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
        NSMutableAttributedString *header = [[NSMutableAttributedString alloc] initWithAttributedString:imageAtt];
        [header appendAttributedString:WDCKJAttributed2(@" 2019年5月", kBuleBtnColor, @15)];
        
        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:header type:CKJCommonHeaderFooterType_HEADER];
        
        CGFloat mainHeight = 60;
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:mainHeight cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:nil left:15];
            m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"05-10 13：20：07", [UIColor kjwd_subTitleColor969696], @15) bottomAttributedText:WDCKJAttributed2(@"现金", [UIColor kjwd_titleColor333333], nil) topEdge:UIEdgeInsetsMake(5, 0, 0, 0) bottomEdge:UIEdgeInsetsMake(0, 0, 5, 0)];
            m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed2(@"500.00元", [UIColor kjwd_titleColor333333], nil) top:0 bottom:0 right:8];
            m.btn8Model = btn8;
        } didSelectRowBlock:nil];
        
        CKJCellModel *model2 = [CKJCellModel modelWithCellHeight:mainHeight cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:nil left:15];
            m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"05-10 13：20：07", [UIColor kjwd_subTitleColor969696], @15) bottomAttributedText:WDCKJAttributed2(@"现金", [UIColor kjwd_titleColor333333], nil) topEdge:UIEdgeInsetsMake(5, 0, 0, 0) bottomEdge:UIEdgeInsetsMake(0, 0, 5, 0)];
            m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed2(@"500.00元", [UIColor kjwd_titleColor333333], nil) top:0 bottom:0 right:8];
            m.btn8Model = btn8;
        } didSelectRowBlock:nil];
        section.modelArray = @[model1, model2];
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}

- (NSArray <__kindof CKJCommonCellModel *>*)extensionCellModels {
    KJ_typeweakself
    CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:40 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
        m.showLine = NO;
        m.selectionStyle = UITableViewCellSelectionStyleNone;
        m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed5(@"月份筛选", [UIColor blackColor], @17) left:15];
    } didSelectRowBlock:nil];
    
    CGFloat squareHeight = 36;
    
    CKJSquareCell2Model *model2 = [CKJSquareCell2Model modelWithCellHeight:squareHeight cellModel_id:nil detailSettingBlock:^(__kindof CKJSquareCell2Model * _Nonnull m) {
        CKJSquare2FuncModel *(^block)(NSString *title) = ^CKJSquare2FuncModel *(NSString *title){
            CKJSquare2FuncModel *model = [CKJSquare2FuncModel modelWithTitle:WDCKJAttributed2(title, [UIColor kjwd_titleColor333333], nil) bgImage:[UIImage kjwd_imageWithColor:[UIColor kjwd_r:245 g:245 b:245 alpha:1] size:CGSizeMake(200, 30)] func:^{
                [weakSelf.simpleTableView removeAllCellModelAtSection:1 keepDisplayRows:@[@0] removeHiddenCellModel:YES withRowAnimation:UITableViewRowAnimationBottom animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                    animationBlock();
                }];
            }];
            return model;
        };
        
        m.showLine = NO;
        m.selectionStyle = UITableViewCellSelectionStyleNone;
        m.data = @[
                   block(@"2019年05月"),
                   block(@"2019年04月"),
                   block(@"2019年03月")
                   ];
    } didSelectRowBlock:nil];
    
    CKJEmptyCellModel *empty = [CKJEmptyCellModel emptyCellModelWithHeight:12.5 showLine:NO];
    
    CKJSquareCell2Model *model3 = [CKJSquareCell2Model modelWithCellHeight:squareHeight cellModel_id:nil detailSettingBlock:^(__kindof CKJSquareCell2Model * _Nonnull m) {
        m.showLine = NO;
        m.selectionStyle = UITableViewCellSelectionStyleNone;
        m.data = @[
                   [CKJSquare2FuncModel modelWithStyle:^(CKJSquare2StyleModel * _Nonnull __weak normalStyle, CKJSquare2StyleModel * _Nonnull __weak selectStyle) {
                       normalStyle.title = WDCKJAttributed2(@"Normal状态", [UIColor blackColor], nil);
                       normalStyle.bgImage = [UIImage kjwd_imageWithColor:[UIColor kjwd_colorWithHexString:@"#0E80C8"] size:CGSizeMake(100, 30)];
                       normalStyle.func = ^{
                           normalStyle.styleEnable = NO;
                           selectStyle.styleEnable = YES;
                       };
                       selectStyle.title = WDCKJAttributed2(@"Select状态", [UIColor blackColor], nil);
                       selectStyle.bgImage = [UIImage kjwd_imageWithColor:[[UIColor kjwd_colorWithHexString:@"#0E80C8"] colorWithAlphaComponent:0.5] size:CGSizeMake(100, 30)];
                       selectStyle.func = ^{
                           NSLog(@"%@ ", @"当前是Select状态");
                       };
                   }]
                   ];
    } didSelectRowBlock:nil];
    
    CKJTableViewCell1Model *model4 = [CKJTableViewCell1Model modelWithCellHeight:40 cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
        m.showLine = NO;
        m.selectionStyle = UITableViewCellSelectionStyleNone;
        m.textLabelAttStr = WDCKJAttributed2(@"显示最近半年明细", [UIColor kjwd_subTitleColor969696], @13.5);
        m.textAlignment = NSTextAlignmentCenter;
    } didSelectRowBlock:nil];
    
    return @[model1, model2, empty, model3, model4];
}


@end
