//
//  RJSettingViewController.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/14.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "RJSettingViewController.h"
#import "UIView+CKJDesingable.h"
#import "WDYHFHospitalItem.h"
#import "CKJToolPickerView.h"
#import "CKJLeftRightCell.h"
#import "RJTestListVC.h"

@interface RJSettingViewController ()

/** 当前选中的区域 */
@property (strong, nonatomic, nullable) WDYHFAreaItem *selectAreaItem;
/** 当前选中的医院 */
@property (strong, nonatomic, nullable) WDYHFHospitalItem *selectHospitalItem;

/** 默认医院 */
@property (strong, nonatomic, nullable) WDYHFHospitalItem *defaultHospitalItem;
/** 默认区域 */
@property (strong, nonatomic, nullable) WDYHFAreaItem *defaultAreaItem;

@end

@implementation RJSettingViewController

#define kkkk_YHFStatusCellID 20

#define kkkk_NotificationCellID 21

#define kkkk_HospitalCellID 22

- (void)setSelectHospitalItem:(WDYHFHospitalItem *)selectHospitalItem {
    _selectHospitalItem = selectHospitalItem;
    self.defaultHospitalItem = selectHospitalItem;
}

- (void)setSelectAreaItem:(WDYHFAreaItem *)selectAreaItem {
    _selectAreaItem = selectAreaItem;
    self.defaultAreaItem = selectAreaItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self reloadUI];
}

#pragma mark - 父类相关

- (void)reloadUI {
    
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    NSDictionary *leftDic = @{NSForegroundColorAttributeName : [UIColor darkGrayColor]};
    NSDictionary *rightDic = @{NSForegroundColorAttributeName : [UIColor darkTextColor], NSFontAttributeName : [UIFont systemFontOfSize:16]};
    
    KJ_typeweakself
    
    CGFloat rowHeight = 55;
    
    CGFloat leftMarign = 15;
    CGFloat rightMarign = 15;
    
    UIImage *image = [[UIImage kjwd_imageNamed:@"wdyhfsdkright arrow"] kjwd_scaleToSize:CGSizeMake(15, 18)];
        
        {
            CKJCommonSectionModel *section = [CKJCommonSectionModel new];
            
            section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"CKJCell的结构", [UIColor grayColor], @15) type:CKJCommonHeaderFooterType_HEADER];
            
            NSMutableAttributedString *footer = WDCKJAttributed2(@"默认情况下title3、switch6是不会被拉伸和压缩的，优先级属于最高是1000；\nlikePrice7次之优先级是850； \nsubTitle4次之，会换行、自适应高度； \nTopBottom5优先级最低，容易拉伸和压缩", [UIColor grayColor], @15);
            [footer appendAttributedString:WDCKJAttributed2(@"\n\n因为CKJCell在CellForRow里面做了很多清除约束和添加约束的操作，所以一个CKJSimpleTableView不要使用过多的CKJCell。\n\n", [UIColor redColor], @15)];
            [footer appendAttributedString:WDCKJAttributed2(@"CKJCell.m文件里有BOOL debug = NO;可以将其改为YES调试", [UIColor grayColor], @15)];
            
            section.footerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:footer type:CKJCommonHeaderFooterType_FOOTER];;
            
            CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:84 cellModel_id:@(kkkk_YHFStatusCellID) detailSettingBlock:^(CKJCellModel *m) {
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"touxiang.jpg" size:CGSizeMake(25, 25) left:0];
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"title3", leftDic) left:0];
                m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"subTitle4", [UIColor kjwd_subTitleColor969696], @14) top:0 left:0 bottom:0 right:0];
                m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"topText5", [UIColor kjwd_titleColor333333], @14) bottomAttributedText:WDCKJAttributed2(@"bottomTex5", [UIColor kjwd_subTitleColor969696], @14) centerMarign:5 topBottomMargin:3 leftMargin:0 rightMargin:0];
                m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 right:0 bottom:0 callBack:^(BOOL switchOn, CKJCellModel * _Nonnull cellModel, UISwitch * _Nonnull senderSwitch) {
                    
                }];
                m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed2(@"likePrice7", [UIColor kjwd_subTitleColor969696], @14) top:0 bottom:0 right:0];
                m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(30, 30) normalImage:[UIImage kjwd_imageNamed:@"touxiang.jpg"] rightMargin:0 detailSettingBlock:nil didClickBtn8Handle:^(CKJCell * _Nonnull cell, CKJBtn8Model * _Nonnull btn8Model) {
                    NSLog(@"%@ ", @"点击了btn8");
                }];
                m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
            } didSelectRowBlock:nil];
            
            section.modelArray = @[model1];
            
            [sections addObject:section];
        }
        {
            CKJCommonSectionModel *section = [CKJCommonSectionModel new];
            section.rowHeight = rowHeight;
            
            
            CKJCellModel *model0 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"头像", leftDic) left:leftMarign];
                m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(30, 30) normalImage:[UIImage kjwd_imageNamed:@"touxiang.jpg"] rightMargin:10 detailSettingBlock:^(CKJBtn8Model *sender) {
                    sender.cornerRadius = 15;
                } didClickBtn8Handle:^(CKJCell * _Nonnull cell, CKJBtn8Model * _Nonnull btn8Model) {
                    NSLog(@"%@ ", @"点击头像");
                }];
                m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
            } didSelectRowBlock:nil];
            
            
            CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"名字", leftDic) left:leftMarign];
                m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"姓名务必和身份证上一致", [UIColor kjwd_subTitleColor969696], @15) top:10 left:10 bottom:10 right:10];
                m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed(@"吴振强", rightDic) top:0 bottom:0 right:rightMarign];
            } didSelectRowBlock:nil];
            
            CKJCellModel *model2 = [CKJCellModel modelWithCellHeight:65 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
                m.showLine = NO;
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"wdyhfsdkmark" size:CGSizeMake(30, 30) left:leftMarign];
                m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"结算失败。现金支付部分将在30分钟内，原路退回，请留意查看！", [UIColor kjwd_r:24 g:167 b:99 alpha:1], @16) top:10 left:10 bottom:10 right:10];
            } didSelectRowBlock:nil];
            
            
            CKJCellModel *model3 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"操作1", leftDic) left:25];
                m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(100, 30) normalImage:nil rightMargin:25 detailSettingBlock:^(CKJBtn8Model *sender) {
                    sender.cornerRadius = 15;
                    sender.normalBackgroundImage = [UIImage kjwd_imageWithColor:[UIColor redColor] size:CGSizeMake(100, 30)];
                    sender.normalAttributedTitle = WDCKJAttributed2(@"删除此行", [UIColor whiteColor], nil);
                } didClickBtn8Handle:^(CKJCell *cell, CKJBtn8Model *btn8Model) {
                    [cell.simpleTableView removeCellModelAtSection:cell.section rows:@[@(cell.row)] removeHiddenCellModel:NO withRowAnimation:UITableViewRowAnimationRight animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                        animationBlock();
                    }];
                }];
            } didSelectRowBlock:nil];
            
            
            CKJCellModel *model4 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"操作2", leftDic) left:25];
                m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(100, 30) normalImage:nil rightMargin:25 detailSettingBlock:^(CKJBtn8Model *sender) {
                    sender.cornerRadius = 15;
                    sender.normalBackgroundImage = [UIImage kjwd_imageWithColor:[UIColor brownColor] size:CGSizeMake(100, 30)];
                    sender.normalAttributedTitle = WDCKJAttributed2(@"增加2行", [UIColor whiteColor], nil);
                } didClickBtn8Handle:^(CKJCell *cell, CKJBtn8Model *btn8Model) {
                    CKJCellModel *temp1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:@(kkkk_HospitalCellID) detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                        m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed([NSString kjwd_returnArc4randomWithNum:5 type:KJWDArc4randomType_Number_Up_Char], leftDic) left:5];
                        m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
                    } didSelectRowBlock:nil];
                    CKJCellModel *temp2 = [CKJCellModel modelWithCellHeight:44 cellModel_id:@(kkkk_HospitalCellID) detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                        m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed([NSString kjwd_returnArc4randomWithNum:5 type:KJWDArc4randomType_Number_Up_Char], leftDic) left:5];
                        m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
                    } didSelectRowBlock:nil];
                    
                    [cell.simpleTableView appendCellModelArray:@[temp1, temp2] atLastRow_InAllCellModelArrayOfSection:cell.section withRowAnimation:UITableViewRowAnimationRight animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                        animationBlock();
                    }];
                    
                }];
            } didSelectRowBlock:nil];
            
            section.modelArray = @[model0, model1, model2, model3, model4];
            [sections addObject:section];
        }
    
        {
            CKJCommonSectionModel *section = [CKJCommonSectionModel new];
            
            section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"高德地图", [UIColor grayColor], @15) type:CKJCommonHeaderFooterType_HEADER];
            section.footerHeight = 15;
            
            CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"开启常用地点入口", [UIColor kjwd_titleColor333333], @15) bottomAttributedText:WDCKJAttributed2(@"关闭后，将隐藏首页的常用地点入口", [UIColor kjwd_subTitleColor969696], @13) centerMarign:5 topBottomMargin:8 leftMargin:leftMarign rightMargin:0];
                m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 right:leftMarign bottom:0 callBack:^(BOOL switchOn, CKJCellModel *cellModel, UISwitch *senderSwitch) {
                    NSLog(@"%@ %@", cellModel.view5Model.topText.string, switchOn ? @"开启" : @"关闭");
                }];
            } didSelectRowBlock:nil];
            
            section.modelArray = @[model1];
            [sections addObject:section];
        }
    
        {
            CKJCommonSectionModel *section = [CKJCommonSectionModel new];
            
            
            CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"yhf通知" size:CGSizeMake(30, 30) left:leftMarign];
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"推送通知", leftDic) left:5];
                m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 right:leftMarign bottom:0 callBack:^(BOOL switchOn, CKJCellModel *cellModel, UISwitch *senderSwitch) {
                    NSLog(@"%@ %@", cellModel.title3Model.attributedText.string, switchOn ? @"开启" : @"关闭");
                }];
            } didSelectRowBlock:nil];
            
            CKJCellModel *model2 = [CKJCellModel modelWithCellHeight:44 cellModel_id:@(kkkk_HospitalCellID) detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"wdyhfsdkhospital" size:CGSizeMake(30, 30) left:leftMarign];
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"请选择医院", leftDic) left:5];
                m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
            } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
                [weakSelf succShow];
            }];
            
            section.modelArray = @[model1, model2];
            
            [sections addObject:section];
        }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}


- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    NSLog(@"你点击了 %ld分区   %ld行， 一般情况下你可以在 CKJCommonCellModel.didSelectRowBlock这个block里面设置就可以得到回调", section, row);
}


- (void)succShow {
    
    __weak typeof(self) weakSelf = self;
    
    CKJConfirmBlock confirmBlock = ^(NSArray <CKJPickerRowModel *>*data, CKJToolPickerView *currentView) {
        [currentView masonryWithAnimateFromScreenButtom_hiddenBackGroundView];
        
        data = WDKJ_ConfirmArray(data);

        weakSelf.selectAreaItem = (WDYHFAreaItem *)[data kjwd_objectAtIndex:0];
        weakSelf.selectHospitalItem = (WDYHFHospitalItem *)[data kjwd_objectAtIndex:1];
        
        CKJCellModel *model = [weakSelf.simpleTableView cellModelOfID:kkkk_HospitalCellID];
        [model.title3Model changeText:weakSelf.selectHospitalItem.org_name];
        [weakSelf.simpleTableView kjwd_reloadData];
    };
    
    
    WDYHFSelectHospitalPickerView *pick = [[WDYHFSelectHospitalPickerView alloc] init];
    
    CKJToolPickerView *selectHospitalV = [[CKJToolPickerView alloc] initWithFrame:CGRectZero pickerView:pick];
    
    selectHospitalV.title = @"选择医院";
    
    selectHospitalV.targetView.dataArr = [self createToolPickerViewDataArray];
    selectHospitalV.cancelBlock = ^(CKJToolPickerView *currentView) {
        [currentView masonryWithAnimateFromScreenButtom_hiddenBackGroundView];
    };
    selectHospitalV.confirmBlock = confirmBlock;
    
    [selectHospitalV masonryWithAnimateFromScreenButtomWithDuration:0.2 superView:nil selfMasonryHeight:300 coverViewColor:nil animationCompletion:nil triggerTapGestureRecognizerBlock:^(void (^ _Nonnull disappearBlock)(void)) {
        disappearBlock();
    }];
}


- (NSArray *)createToolPickerViewDataArray {
    
    NSDictionary *myDic = @{
                            @"return_code": @"SUCCESS",
                            @"return_msg": @"响应成功",
                            @"result_code": @"SUCCESS",
                            @"details": @[
                                    @{
                                        @"details": @[
                                                @{
                                                    @"org_code": @"47117170333050211A1001",
                                                    @"org_name": @"湖州市中心医院"
                                                    },
                                                @{
                                                    @"org_code": @"47117166633050211A1001",
                                                    @"org_name": @"湖州市第一人民医院"
                                                    },
                                                @{
                                                    @"org_code": @"47117169033050211A5201",
                                                    @"org_name": @"湖州市第三人民医院"
                                                    },
                                                @{
                                                    @"org_code": @"47117172X33050211G1001",
                                                    @"org_name": @"湖州市妇幼保健院"
                                                    },
                                                @{
                                                    @"org_code": @"47117171133050211A2101",
                                                    @"org_name": @"湖州市中医院"
                                                    }
                                                ],
                                        @"area": @"330500",
                                        @"area_name": @"湖州市"
                                        },
                                    @{
                                        @"details": @[
                                                @{
                                                    @"org_code": @"47117183433050311A1001",
                                                    @"org_name": @"湖州市南浔区人民医院"
                                                    }
                                                ],
                                        @"area": @"330503",
                                        @"area_name": @"南浔区"
                                        }
                                    ]
                            };
    
    
    NSArray *(^block)(id data) = ^ NSArray * (id data) {
        
        NSMutableArray <CKJPickerRowModel *>*result = [NSMutableArray array];
        
        NSArray <NSDictionary *>*details = WDKJ_ConfirmArray(data[@"details"]);
        
        [details enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *tempDic = WDKJ_ConfirmDic(obj);
            
            WDYHFAreaItem *areaItem = [WDYHFAreaItem modelWithDic:tempDic];
            
            areaItem.hospitals = [NSMutableArray kjwd_arrayWithKeyValuesArray:tempDic[@"details"] modelClass:[WDYHFHospitalItem class] callBack:nil];
            
            [result addObject:areaItem];
        }];
        
        return result;
    };
    
    
    
    NSArray <WDYHFAreaItem *>*areas =  block(myDic);


    NSInteger areaSelectIndex = 0;


    NSMutableArray <CKJPickerComponentModel *>*sections = [NSMutableArray array];
    {
        CKJPickerComponentModel *section = [CKJPickerComponentModel new];
        section.widthOf_MultipliedByPickerView = 0.25;
        section.modelArray = areas;

        section.defaultSelectIndex = ({
            NSInteger index = 0;
            index = [areas kjwd_do_filter_returnConformIndex:^BOOL(WDYHFAreaItem *objc) {
                return [objc.area isEqualToString:WDKJ_ConfirmString(self.defaultAreaItem.area)];
            }].integerValue;
            index;
        });
        areaSelectIndex = section.defaultSelectIndex;

        [sections addObject:section];
    }
    {
        CKJPickerComponentModel *section = [CKJPickerComponentModel new];
        section.widthOf_MultipliedByPickerView = 0.65;


        WDYHFAreaItem *currentArea = [areas kjwd_objectAtIndex:areaSelectIndex];

        section.modelArray = currentArea.hospitals;

        section.defaultSelectIndex = ({
            NSInteger index = 0;
            index = [currentArea.hospitals kjwd_do_filter_returnConformIndex:^BOOL(WDYHFHospitalItem *objc) {
                return [objc.org_code isEqualToString:WDKJ_ConfirmString(self.defaultHospitalItem.org_code)];
            }].integerValue;
            index;
        });

        [sections addObject:section];
    }
    return sections;
}




@end
