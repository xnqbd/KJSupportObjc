//
//  RJAddPersonVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/9/23.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "InputDemoVC.h"
#import "RJProjectResorce.h"
#import "MBProgressHUD+WJ.h"

@interface InputDemoVC ()

@property (assign, nonatomic) BOOL currentIsShowJianHuPerson;

@end

@implementation InputDemoVC

#define JianHuPersonName         3874918
#define JianHuPersonidCardNumber 1239823

- (void)handleZhengJianHao:(NSString *)text {
    
    void (^removeAction)(void) = ^{
        [self.simpleTableView removeAllCellModelAtSection:1 keepDisplayRows:@[] removeHiddenCellModel:YES withRowAnimation:UITableViewRowAnimationTop animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
            animationBlock();
        }];
    };
    
    void (^dateBlock)(NSString *date) = ^(NSString *date){
        
        [self.simpleTableView kjwd_filterCellModelForID:kInput_Birthday finishBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            if (![m.tfModel.attributedText.string isEqualToString:date]) {
                [m.tfModel _setText:date];
                [self.simpleTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:(UITableViewRowAnimationLeft)];
            }
        }];
    };
    
    if (text.length != 18) {
        
        dateBlock(@"");
        if (_currentIsShowJianHuPerson) {
            removeAction();
            _currentIsShowJianHuPerson = NO;
        }
        
        return;
    }
    
    NSString *birthday = [NSDate kjwd_format1:[text kjwd_idCardBirthday]];
    
    dateBlock(birthday);
    
    NSString *birthday_year = [text kjwd_idCardBirthday_Year];
    
    NSInteger result = [[NSDate date] kjwd_dateYear].intValue - birthday_year.intValue;
    
    if (result > 14) {
        if (_currentIsShowJianHuPerson) {
            removeAction();
            _currentIsShowJianHuPerson = NO;
        }
    } else if (result > 0) { // 小于14岁
        _currentIsShowJianHuPerson = YES;
        [self jianhuren];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJInput示例1";
    KJ_typeweakself
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithFooterHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull sec) {
//        sec.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"Demo会自动识别证件号的出生年月，\n如果小于14岁，则必须填写监护人信息，\n如果大于等于14岁，则只需填写本人信息\n并且证件号TextField输入框会有延迟识别的能力", [UIColor grayColor], @15) type:CKJCommonHeaderFooterType_HEADER];
//  sec.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"Demo会自动识别证件号的出生年月，\n如果小于14岁，则必须填写监护人信息，\n如果大于等于14岁，则只需填写本人信息\n并且证件号TextField输入框会有延迟识别的能力", [UIColor grayColor], @15) type:CKJCommonHeaderFooterType_HEADER];
        
        CKJInputCellModel *name = [self image:nil title:@"姓名" tfText:@"" placeholder:@"请输入姓名" required:YES cellId:kInput_Name didSelectRowBlock:nil];
        CKJInputCellModel *sex = [self image:nil title:@"性别" tfText:@"" placeholder:@"" required:YES cellId:kInput_Sex didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            m.stringChoose = [CKJStringChooseHelper helperWithHeader:m.title3Text items:[RJProjectResorce Gender] detailSetting:nil];
        }];
        CKJInputCellModel *idCardType = [self image:nil title:@"证件类型" tfText:@"" placeholder:@"" required:YES cellId:kInput_idCardType didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            // 选择器数据源
            m.stringChoose = [CKJStringChooseHelper helperWithHeader:m.title3Text items:[RJProjectResorce IDCardType] detailSetting:nil];
        }];
        CKJInputCellModel *idCardNumber = [self image:nil title:@"证件号" tfText:@"" placeholder:@"请输入证件号" required:YES cellId:kInput_idCardNumber  didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            // 延迟0.7秒处理输入框文本，给用户好的体验
            [m.tfModel _afterSecondsListenTextChange:0.7 callBack:^(NSAttributedString * _Nullable attText) {
                // 处理输入框文本回调
                [weakSelf handleZhengJianHao:attText.string];
            }];
        }];
        CKJInputCellModel *birthday = [self image:nil title:@"出生年月" tfText:@"" placeholder:@"" required:YES cellId:kInput_Birthday didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
            m.dateChoose = [CKJDateChooseHelper dateHelperWithHeader:m.title3Text detailSetting:^(__kindof CKJDateChooseHelper * _Nonnull helper) {
                [helper systemConfig];
            }];
        }];
        
        sec.modelArray = @[name, idCardType, idCardNumber, sex, birthday];
    }];
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithFooterHeight:10 detailSetting:nil];
    
    
    
    self.simpleTableView.dataArr = @[section1, section2];

    [self createFooterViewWithBtnTitle:@"保存" clickHandle:^(UIButton * _Nonnull sender, InputDemoVC *se, CKJSimpleTableView *simpleTableView) {
        [se saveAction];
    }];
    [self.simpleTableView reloadData];
    [self jianhuren];
}

/// 统一创建inputCell
- (CKJInputCellModel *)image:(NSString *)image title:(NSString *)title tfText:(NSString *)text placeholder:(NSString *)placeholder required:(BOOL)required cellId:(NSInteger)cellId  didSelectRowBlock:(nullable CKJInputCellModelRowBlock)didSelectRowBlock  {
    
    CGFloat left_margin = 10;
    NSDictionary *leftDic = @{NSForegroundColorAttributeName : [UIColor kjwd_titleColor333333], NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CKJInputCellModel *model = [CKJInputCellModel modelWithCellHeight:44 cellModel_id:@(cellId) detailSettingBlock:^(CKJInputCellModel * _Nonnull m) {
        m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(title, leftDic) left:0];
               
        didSelectRowBlock ? didSelectRowBlock(m) : nil;
        
        CGSize size = CGSizeMake(20, 20);
        UIImage *image = [CKJInputAddition systemStarImageWithSize:size];
        m.image2Model = [CKJImage2Model image2ModelWithNormalImage:required ? image : [UIImage new] size:[NSValue valueWithCGSize:size] left:left_margin];
        if (required) {
            [m addRequired:WDKJ_ER(m.title3Model.attributedText.string)];
        }
        if (m.stringChoose || m.dateChoose) {
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        }
        
        [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
            [tfModel _setText:text];
            [tfModel _setPlaceholder:placeholder];
            tfModel.userInteractionEnabled = !m.arrow9Model;
            tfModel.textAlignment = NSTextAlignmentRight;
        }];
    } didSelectRowBlock:nil];
    return model;
}

- (void)jianhuren {
    
    CKJInputCellModel *name = [self image:nil title:@"监护人姓名" tfText:@"" placeholder:@"请输入姓名" required:YES cellId:JianHuPersonName didSelectRowBlock:nil];
    CKJInputCellModel *idCardNumber = [self image:nil title:@"监护人身份证号" tfText:@"" placeholder:@"请输入证件号" required:YES cellId:JianHuPersonidCardNumber didSelectRowBlock:nil];
    CKJInputCellModel *relate = [self image:nil title:@"关系" tfText:@"" placeholder:@"" required:YES cellId:kInput_Relationship didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
        m.stringChoose = [CKJStringChooseHelper helperWithHeader:m.title3Text items:[RJProjectResorce Relationship] detailSetting:nil];
    }];
    CKJInputCellModel *phone = [self image:nil title:@"手机号" tfText:@"" placeholder:@"请输入手机号" required:YES cellId:kInput_Phone didSelectRowBlock:^(__kindof CKJInputCellModel * _Nonnull m) {
        [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
           tfModel.keyboardType = UIKeyboardTypePhonePad;
        }];
        [m addRequired:[CKJInputExpressionRequiredModel modelWithRequiredText:@"手机号格式错误" failExpression:^BOOL(NSAttributedString * _Nonnull attText, CKJInputCellModel * _Nonnull cm) {
            return [attText.string kjwd_varityPhoneFail];
        }]];
    }];
    CKJInputCellModel *address = [self image:nil title:@"地址" tfText:@"" placeholder:@"请输入联系地址" required:NO cellId:kInput_Address didSelectRowBlock:nil];
    CKJInputCellModel *email = [self image:nil title:@"邮箱" tfText:@"" placeholder:@"请输入邮箱" required:NO cellId:kInput_Email didSelectRowBlock:nil];

    [self.simpleTableView appendCellModelArray:@[name, idCardNumber, relate, phone, address, email] atLastRow_InAllCellModelArrayOfSection:1 withRowAnimation:UITableViewRowAnimationTop animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
        animationBlock();
    }];
}

- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    
    KJ_typeweakself
    if ([model isKindOfClass:[CKJInputCellModel class]] == NO) return;
    __weak CKJInputCellModel *_model = model;
    if (_model.stringChoose) { // 选择的样式
        [_model.stringChoose showWithSelectedStr:_model.stringChoose.currentSelectedItem.content origin:self.view callBack:^(CKJStringChooseHelper *__weak  _Nonnull helper, __kindof CKJStringChooseItem * _Nonnull item, NSInteger selectedIndex) {
            helper.currentSelectedItem = item;
            [_model.tfModel _setText:item.content];
            [weakSelf.simpleTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    } else if (_model.dateChoose) {
        [_model.dateChoose showWithOrigin:self.view callBack:^(CKJDateChooseHelper *__weak  _Nonnull helper) {
            NSString *str = [helper.currentSelectedDate kjwd_dateStringWithFormatter:CKJDateFormat2];
            [_model.tfModel _setText:str];
            [weakSelf.simpleTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

// 点击 保存
- (void)saveAction {
    if ([self.simpleTableView verityInputFail]) return;
    
    NSString *_name = [self.simpleTableView inputCellModelOfID:kInput_Name].tfText;
    
    // 证件类型
    CKJStringChooseItem *_idCardType = [self.simpleTableView inputCellModelOfID:kInput_idCardType].stringChoose.currentSelectedItem;
    
    // 证件号
    NSString *_idCardNumber = [self.simpleTableView inputCellModelOfID:kInput_idCardNumber].tfText;
    
    // 性别
    CKJStringChooseItem *_sex = [self.simpleTableView inputCellModelOfID:kInput_Sex].stringChoose.currentSelectedItem;
    
    // 出生日期
    CKJStringChooseItem *_birthday = [self.simpleTableView inputCellModelOfID:kInput_Birthday].stringChoose.currentSelectedItem;
    
    // 监护人姓名
    NSString *_jianhuPersonName = [self.simpleTableView inputCellModelOfID:JianHuPersonName].tfText;

    // 监护人身份证号
    NSString *_jianHuPersonidCardNumber = [self.simpleTableView inputCellModelOfID:JianHuPersonidCardNumber].tfText;

    // 关系
    CKJStringChooseItem *relationShip = [self.simpleTableView inputCellModelOfID:kInput_Relationship].stringChoose.currentSelectedItem;

    // 手机号
    NSString *_phone = [self.simpleTableView inputCellModelOfID:kInput_Phone].tfText;
    
    // 地址
    NSString *_address = [self.simpleTableView inputCellModelOfID:kInput_Address].tfText;
    
    // 邮箱
    NSString *_email = [self.simpleTableView inputCellModelOfID:kInput_Email].tfText;

//    // 验证码
//    NSString *_verityCode = [self.simpleTableView inputCellModelOfID:kInput_VerityCode].tfText;
    
    
    [self.simpleTableView readInputValue];
}


@end
