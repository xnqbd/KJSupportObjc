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
#import "CustomViewController.h"

@interface RJSettingViewController ()
@property (strong, nonatomic) UIButton *cancleBtn;


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

- (void)layoutTableViewFrame:(CKJSimpleTableView *)tableV {
    [tableV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview.kjwdMas_safeAreaLeft);
        make.right.equalTo(superview.kjwdMas_safeAreaRight);
        make.top.equalTo(superview.kjwdMas_safeAreaTop);
        make.bottom.equalTo(self.cancleBtn.mas_top).offset(-20);
    }];
}

- (NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
    return @{
             NSStringFromClass([CKJLeftRightCellModel class]) : @{cellKEY : NSStringFromClass([CKJLeftRightCell class]), isRegisterNibKEY : @NO, configDicKEY_leftLab_width : @80}
             };
}

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
            
            NSMutableAttributedString *footer = WDCKJAttributed2(@"默认情况下title3、switch6是不会被拉伸和压缩的，优先级属于最高是1000；\nlikePrice7次之优先级是999； \nsubTitle4次之，会换行、自适应高度； \nTopBottom5优先级最低，容易拉伸和压缩", [UIColor grayColor], @15);
            [footer appendAttributedString:WDCKJAttributed2(@"\n\n因为CKJCell在CellForRow里面做了很多清除约束和添加约束的操作，所以一个CKJSimpleTableView不要使用过多的CKJCell。\n\n", [UIColor redColor], @15)];
            [footer appendAttributedString:WDCKJAttributed2(@"如果是开发者自定义的Cell，那滑动起来是很流畅的，自定义Cell请点击CustomViewController这一行\n\n", [UIColor redColor], @15)];
            
            [footer appendAttributedString:WDCKJAttributed2(@"CKJCell.m文件里有BOOL debug = NO;可以将其改为YES调试", [UIColor grayColor], @15)];
            
            section.footerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:footer type:CKJCommonHeaderFooterType_FOOTER];;
            
            CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:84 cellModel_id:@(kkkk_YHFStatusCellID) detailSettingBlock:^(CKJCellModel *m) {
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"touxiang.jpg" size:CGSizeMake(25, 25) left:0];
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"title3", leftDic) left:0];
                m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"subTitle4", [UIColor kjwd_subTitleColor969696], @14) top:0 left:0 bottom:0 right:0];
                m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"topText5", [UIColor kjwd_titleColor333333], @14) bottomAttributedText:WDCKJAttributed2(@"bottomTex5", [UIColor kjwd_subTitleColor969696], @14) centerMarign:5 topBottomMargin:3 leftMargin:0 rightMargin:0];
                m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 right:0 bottom:0 callBack:nil];
                m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed2(@"likePrice7", [UIColor kjwd_subTitleColor969696], @14) top:0 bottom:0 right:0];
                m.btn8Model = [CKJBtn8Model btn8ModelWithNormalImage:@"touxiang.jpg" size:CGSizeMake(30, 30) rightMargin:0 detailSettingBlock:^(CKJBtn8Model *sender) {
                } didClickBtn8Handle:nil];
                m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
            } didSelectRowBlock:nil];
            
            section.modelArray = @[model1];
            
            [sections addObject:section];
        }
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        
        section.headerHeight = 15;
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:@(kkkk_YHFStatusCellID) detailSettingBlock:^(CKJCellModel *m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"进入CustomViewController", leftDic) left:leftMarign];
            m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            CustomViewController *vc = [CustomViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
        CKJCellModel *model2 = [CKJCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
            m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"设置是否在朋友、蚂蚁森林、新的朋友等页面向你推荐可能认识的人 （这一行是如果CellHeight设置为0，那么会自适应高度）", [UIColor kjwd_subTitleColor969696], @14) top:10 left:leftMarign bottom:10 right:leftMarign];
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model1, model2];
        
        [sections addObject:section];
    }
    
        {
            CKJCommonSectionModel *section = [CKJCommonSectionModel new];
            section.footerHeight = 20;
            
            CKJCellModel *model0 = [CKJCellModel modelWithCellHeight:65 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
                m.showLine = NO;
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"wdyhfsdkmark" size:CGSizeMake(30, 30) left:leftMarign];
                m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"结算失败。现金支付部分将在30分钟内，原路退回，请留意查看！", [UIColor kjwd_r:24 g:167 b:99 alpha:1], @16) top:10 left:10 bottom:10 right:10];
            } didSelectRowBlock:nil];
           
            
            section.modelArray = @[model0];
            
            [sections addObject:section];
        }
        
        
        {
            CKJCommonSectionModel *section = [CKJCommonSectionModel new];
            section.footerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"上面这个几个CKJLeftRightCell, 可以在CKJLeftRightCell.h里面找到可配置的KEY，当你需要的时候在returnCell_Model_keyValues里面做此配置\n1. leftLab的固定宽度、或相对于父视图的倍数\n2. leftLab 和 rightLab的对齐方式 \n3. leftLabel 距离顶部的距离，如果设置了此值，那么LeftLabel就不再Y轴方向居中了\n4. rightLab 距离底部的距离，如果不设置此值，默认高度是5", [UIColor grayColor], @15) type:CKJCommonHeaderFooterType_FOOTER];
            
          
            
            CKJLeftRightCellModel *(^block)(NSString *, NSString *) = ^CKJLeftRightCellModel *(NSString *left, NSString *right) {
                CKJLeftRightCellModel *sender = [CKJLeftRightCellModel modelWithLeftMargin:20 centerMargin:0 rightMargin:20];
                sender.showLine = NO;
                sender.leftStr = left;
                sender.rightStr = right;
                return sender;
            };
            
            CKJLeftRightCellModel *model1 = block(@"就诊人：", @"吴振强");
            CKJLeftRightCellModel *model2 = block(@"社保卡号：", @"A05111650");
            CKJLeftRightCellModel *model3 = block(@"就诊医院：", @"湖州市中心医院");
            CKJLeftRightCellModel *model4 = block(@"订单时间：", @"2019-01-07 14:43:54");
            CKJLeftRightCellModel *model5 = block(@"订单标号：", @"jXG8sAA6ni");
            
            
            
            section.modelArray = @[ model1, model2, model3, model4, model5];
            
            [sections addObject:section];
        }
        
        
        {
            CKJCommonSectionModel *section = [CKJCommonSectionModel new];
            section.rowHeight = rowHeight;
            
            
            CKJCellModel *model0 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"头像", leftDic) left:leftMarign];
                m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
                m.btn8Model = [CKJBtn8Model btn8ModelWithNormalImage:@"touxiang.jpg" size:CGSizeMake(30, 30) rightMargin:10 detailSettingBlock:^(CKJBtn8Model *sender) {
                    sender.cornerRadius = 15;
                } didClickBtn8Handle:^(CKJCell *cell, CKJBtn8Model *btn8Model) {
                    NSLog(@"%@ ", @"点击头像");
                }];
            } didSelectRowBlock:nil];
            
            
            CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"名字", leftDic) left:leftMarign];
                m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"姓名务必和身份证上一致", [UIColor kjwd_subTitleColor969696], @15) top:10 left:10 bottom:10 right:10];
                m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed(@"吴振强", rightDic) top:0 bottom:0 right:rightMarign];
            } didSelectRowBlock:nil];
            
            
            section.modelArray = @[model0, model1];
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
            
            CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:@(kkkk_YHFStatusCellID) detailSettingBlock:^(CKJCellModel *m) {
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"医后付状态", leftDic) left:leftMarign];
                m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed2(@"正常", [UIColor kjwd_colorWithHexString:@"0aae65"], @17) top:0 bottom:0 right:10];
            } didSelectRowBlock:nil];
            
            CKJCellModel *model2 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"yhf通知" size:CGSizeMake(30, 30) left:leftMarign];
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"推送通知", leftDic) left:5];
                m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 right:leftMarign bottom:0 callBack:^(BOOL switchOn, CKJCellModel *cellModel, UISwitch *senderSwitch) {
                    NSLog(@"%@ %@", cellModel.title3Model.attributedText.string, switchOn ? @"开启" : @"关闭");
                }];
            } didSelectRowBlock:nil];
            
            CKJCellModel *model3 = [CKJCellModel modelWithCellHeight:44 cellModel_id:@(kkkk_HospitalCellID) detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
                m.image2Model = [CKJImage2Model image2ModelWithImageString:@"wdyhfsdkhospital" size:CGSizeMake(30, 30) left:leftMarign];
                m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"请选择医院", leftDic) left:5];
                m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:nil];
            } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
                [weakSelf succShow];
            }];
            
            section.modelArray = @[model1, model2, model3];
            
            [sections addObject:section];
        }
    
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"设置 -> 通用 -> 接力 -> 接力", [UIColor grayColor], @15) type:CKJCommonHeaderFooterType_HEADER];
        section.footerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"通过“接力”功能，您在某设备开始操作后，可立即使用iCloud账号从另一设备继续相同操作。您需要的应用会显示在应用切换器和Mac的程序坞上。", [UIColor grayColor], @15) type:CKJCommonHeaderFooterType_FOOTER];;
        
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"接力", leftDic) left:leftMarign];
            m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 right:leftMarign bottom:0 callBack:^(BOOL switchOn, CKJCellModel *cellModel, UISwitch *senderSwitch) {
                NSLog(@"%@ %@", cellModel.title3Model.attributedText.string, switchOn ? @"开启" : @"关闭");
            }];
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model1];
        [sections addObject:section];
    }
    
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}


- (UIButton *)cancleBtn {
    if (_cancleBtn) return _cancleBtn;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor kjwd_r:51 g:147 b:251 alpha:1];
    
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"取消医后付" forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont systemFontOfSize:15]];
    btn2.kCornerRadius = 4;
    KJ_typeweakself
    [btn2 kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
        NSLog(@"%@ ", @"取消医后付");
        CKJCellModel *model = [weakSelf.simpleTableView cellModelOfID:kkkk_YHFStatusCellID];
        if (model) {
            model.likePrice7Model.attributedText = WDCKJAttributed2(@"已取消", [UIColor kjwd_colorWithHexString:@"0aae65"], @17);
            [weakSelf.simpleTableView kjwd_reloadData];
        }
    }];
    [self.view addSubview:btn2];
    
    CGFloat leftMargin = 20;
    
    [btn2 kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.bottom.equalTo(superview.kjwdMas_safeAreaBottom).offset(-leftMargin);
        make.right.equalTo(superview).offset(-leftMargin);
        make.left.equalTo(superview).offset(leftMargin);
        make.height.equalTo(@45);
    }];
    _cancleBtn = btn2;
    return _cancleBtn;
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
