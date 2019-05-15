//
//  RJBindCardVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/15.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJBindCardVC.h"
#import "CKJStackCell.h"

typedef NS_ENUM(NSUInteger, RJInputStyle) {
    RJInputStyle_Normal,
    RJInputStyle_Choose
};

@interface RJBindCardVC ()

@end

@implementation RJBindCardVC


#define kInput_ZhengJianStyle   704
#define kInput_ZhengJianHao   805


#define kInput_CardStyle   906
#define kInput_CardNumber   1002

#define kInput_GuanXi   1201
#define kInput_Address   2302
#define kInput_Email   3403

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定就诊卡";
    
    [self initSimpleTableViewData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateUI];
    });
}

- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
    
    CKJStackCellConfig *config2 = [CKJStackCellConfig configWithDetailSettingBlock:^(__kindof CKJStackCellConfig * _Nonnull m) {
        m.edge = UIEdgeInsetsMake(0, 20, 0, 20);
        UIImage *(^block)(NSString *title) = ^UIImage *(NSString *title){
            UIImage *image = [UIImage kjwd_imageNamed:title];
            //image = [image kjwd_scaleToSize:CGSizeMake(36, 36)];
            return image;
        };
        m.data = @[
                   @[
                       [CKJFuncModel modelWithTitle:@"预交金充值" image:block(@"zhuyuan预交金充值") func:^(UIButton * _Nonnull sender) {
                       }],
                       [CKJFuncModel modelWithTitle:@"充值记录" image:block(@"zhuyuan充值记录") func:^(UIButton * _Nonnull sender) {
                       }],
                       [CKJFuncModel modelWithTitle:@"日清单查询" image:block(@"zhuyuan日清单查询") func:^(UIButton * _Nonnull sender) {
                       }]
                       ],
                   @[
                       [CKJFuncModel modelWithTitle:@"出院结算" image:block(@"zhuyuan出院结算") func:^(UIButton * _Nonnull sender) {
                       }],
                       [CKJFuncModel modelWithTitle:@"住院记录查询" image:block(@"zhuyuan历史住院记录") func:^(UIButton * _Nonnull sender) {
                       }],
                       [CKJFuncModel modelWithTitle:@"" image:block(@"") func:^(UIButton * _Nonnull sender) {
                       }]
                       ]
                   ];
    }];
    return @{
             NSStringFromClass([CKJStackCellModel class]) : @{cellKEY : NSStringFromClass([CKJStackCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config2}
             };
}


- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    if ([model isKindOfClass:[CKJInputCellModel class]] == NO) return;
    
    CKJInputCellModel *_model = model;
    if (_model.kj_enumValue == RJInputStyle_Choose) {
        NSLog(@"可以进行弹框了 %@", _model.title3Model.attributedText.string);
    }
    
}


- (void)updateUI {
    void(^block)(NSInteger cellModelId, NSString *text) = ^(NSInteger cellModelId, NSString *text) {
        [self.simpleTableView kjwd_filterCellModelForID:cellModelId finishBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            m.tfModel.text = text;
        }];
    };
    
    block(kInput_Name, @"张三");
    block(kInput_Sex, @"男");
    block(kInput_ZhengJianStyle, @"身份证");
    block(kInput_ZhengJianHao, @"4139231995072717283");
    block(kInput_Phone, @"12345678901");
    block(kInput_CardStyle, @"医保卡");
    block(kInput_CardNumber, @"A627103");
    block(kInput_GuanXi, @"本人");
    block(kInput_Address, @"上海市虹口区");
    block(kInput_Email, @"1772222@163.com");
    
    [self.simpleTableView kjwd_reloadData];
}

- (void)initSimpleTableViewData {
    
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];

    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 15;
        
        CKJStackCellModel *model1 = [CKJStackCellModel modelWithCellHeight:190 cellModel_id:nil detailSettingBlock:nil didSelectRowBlock:nil];
        
        section.modelArray = @[model1];
        
        [sections addObject:section];
    }
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 15;
        
        CKJInputCellModel *name = [self image:@"jzk_name" title:@"姓名" tfText:@"" placeholder:@"请输入姓名" haveStar:YES cellId:kInput_Name style:RJInputStyle_Normal didSelectRowBlock:nil];
        CKJInputCellModel *sex = [self image:@"jzk_xb" title:@"性别" tfText:@"" placeholder:@"" haveStar:YES cellId:kInput_Sex style:RJInputStyle_Choose didSelectRowBlock:nil];
        CKJInputCellModel *zhengjianType = [self image:@"jzk_card" title:@"证件类型" tfText:@"" placeholder:@"" haveStar:YES cellId:kInput_ZhengJianStyle style:RJInputStyle_Choose didSelectRowBlock:nil];
        CKJInputCellModel *zhengjianhao = [self image:@"jzk_card" title:@"证件号" tfText:@"" placeholder:@"请输入证件号" haveStar:YES cellId:kInput_ZhengJianHao style:RJInputStyle_Normal didSelectRowBlock:nil];
        CKJInputCellModel *phone = [self image:@"jzk_phone" title:@"手机号" tfText:@"" placeholder:@"请输入手机号" haveStar:YES cellId:kInput_Phone style:RJInputStyle_Normal didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            m.tfModel.keyboardType = UIKeyboardTypePhonePad;
        }];
        CKJInputCellModel *codeModel = [self image:@"jzk_yzm" title:@"验证码" tfText:@"" placeholder:@"请输入验证码" haveStar:NO cellId:kInput_VerityCode style:RJInputStyle_Normal didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            m.tfModel.keyboardType = UIKeyboardTypeNumberPad;
            m.getCodeModel = [CKJGetCodeModel modelWithClickCodeBtnBlock:^(CKJTriggerCodeBlock  _Nonnull triggerCodeBlock) {
                triggerCodeBlock(15); // 触发定时器
            } detailSettingBlock:^(__kindof CKJGetCodeModel * _Nonnull m) {
                m.codeBtnWidth = 130;
                m.countDownChanging = ^NSString * _Nonnull(CKJCountDownButton * _Nonnull countDownButton, NSUInteger second) {
                    return [NSString stringWithFormat:@"😀还有%lu秒", second];
                };
                m.countDownFinished = ^NSString * _Nonnull(CKJCountDownButton * _Nonnull countDownButton, NSUInteger second) {
                    countDownButton.enabled = YES; // 一定要设置这个，让按钮可用
                    return @"重新获取验证码";
                };
            }];
        }];
        CKJInputCellModel *cardStyle = [self image:@"jzk_lx" title:@"卡类型" tfText:@"" placeholder:@"" haveStar:YES cellId:kInput_CardStyle style:RJInputStyle_Choose didSelectRowBlock:nil];
        CKJInputCellModel *cardNumber = [self image:@"jzk_kh" title:@"卡号" tfText:@"" placeholder:@"请输入卡号" haveStar:YES cellId:kInput_CardNumber style:RJInputStyle_Normal didSelectRowBlock:nil];
        CKJInputCellModel *guanxi = [self image:@"jzk_relationship" title:@"关系" tfText:@"" placeholder:@"" haveStar:YES cellId:kInput_GuanXi style:RJInputStyle_Choose didSelectRowBlock:nil];
        CKJInputCellModel *address = [self image:@"jzk_address" title:@"住址" tfText:@"" placeholder:@"请输入住址" haveStar:NO cellId:kInput_Address style:RJInputStyle_Normal didSelectRowBlock:nil];
        CKJInputCellModel *mail = [self image:@"jzk_mail" title:@"邮箱" tfText:@"" placeholder:@"请输入邮箱" haveStar:NO cellId:kInput_Email style:RJInputStyle_Normal didSelectRowBlock:nil];
      
        section.modelArray = @[name, sex, zhengjianType, zhengjianhao, phone, codeModel, cardStyle, cardNumber, guanxi, address, mail];
        
        [sections addObject:section];
    }
    
    CGFloat left_margin = 15;
    CGFloat width = 70;
    CGSize size = CGSizeMake(20, 20);
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 15;
        
        NSDictionary *leftDic = @{NSForegroundColorAttributeName : [UIColor kjwd_titleColor333333], NSFontAttributeName : [UIFont systemFontOfSize:14]};
        CKJInputCellModel *model1 = [CKJInputCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"就诊卡号", leftDic) left:left_margin width:width];
            m.tfModel = [CKJTFModel modelWithDetailSettingBlock:^(__kindof CKJTFModel * _Nonnull tfM) {
                tfM.textAlignment = NSTextAlignmentRight;
                tfM.placeholder = @"请输入就诊卡卡号";
            }];
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model1];
        
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}

- (CKJInputCellModel *)image:(NSString *)image title:(NSString *)title tfText:(NSString *)text placeholder:(NSString *)placeholder haveStar:(BOOL)haveStar cellId:(NSInteger)cellId style:(RJInputStyle)style didSelectRowBlock:(nullable CKJInputCellModelRowBlock)didSelectRowBlock  {
    
    CGFloat left_margin = 15;
    CGFloat width = 70;
    CGSize size = CGSizeMake(20, 20);
    NSDictionary *leftDic = @{NSForegroundColorAttributeName : [UIColor kjwd_titleColor333333], NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CKJInputCellModel *model = [CKJInputCellModel modelWithCellHeight:44 cellModel_id:@(cellId) detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
        m.kj_enumValue = style;
        m.image2Model = [CKJImage2Model image2ModelWithImageString:image size:size left:left_margin];
        m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(title, leftDic) left:left_margin width:width];
        m.tfModel = [CKJTFModel modelWithDetailSettingBlock:^(__kindof CKJTFModel * _Nonnull tfM) {
            tfM.placeholder = placeholder;
            tfM.text = text;
            
            // 选择
            if (style == RJInputStyle_Choose) {
                tfM.userInteractionEnabled = NO;
            }
        }];
        
        if (style == RJInputStyle_Choose) {
            m.btn8Model = [CKJBtn8Model btn8ModelWithSize:size normalImage:[UIImage kjwd_imageNamed:@"hs_gh_arrowDown"] rightMargin:0 detailSettingBlock:^(CKJBtn8Model * _Nonnull sender) {
                sender.userInteractionEnabled = NO;
            } didClickBtn8Handle:nil];
        }
        if (haveStar) {
            m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:[UIImage kjwd_imageWithColor:[UIColor whiteColor] size:CGSizeMake(30, 30) text:@"*" textAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:16]} circular:NO] right:@5];
        }
        didSelectRowBlock ? didSelectRowBlock(m) : nil;
    } didSelectRowBlock:nil];
    return model;
}


@end
