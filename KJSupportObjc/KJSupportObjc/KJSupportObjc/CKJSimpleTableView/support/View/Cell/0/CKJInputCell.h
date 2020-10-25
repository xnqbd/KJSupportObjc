//
//  CKJInputCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCell.h"
#import "CKJChooseHelper.h"
#import "CKJInputData.h"

typedef void(^CKJTriggerCodeBlock)(NSUInteger seconds);

NS_ASSUME_NONNULL_BEGIN


UIKIT_EXTERN CGFloat const kOConst_Input_Tf_FontSize;



@class CKJSimpleTableViewStyle;
@class CKJInputCellModel, CKJTFModel, CKJInputExpressionRequiredModel;

/// EmptyRequired 空必须
CKJInputExpressionRequiredModel * WDKJ_ER(NSString *emptyRequiredText);


typedef void(^CKJInputCellModelRowBlock)(__kindof CKJInputCellModel *_Nonnull __weak m);
typedef BOOL(^CKJExpressionRequiredBlock)(NSString *_Nullable text, __kindof CKJInputCellModel *cm);

@interface CKJInputExpressionRequiredModel : CKJBaseModel

/// 默认是YES，必须
@property (assign, nonatomic) BOOL required;

@property (copy, nonatomic) NSString *requiredText;
@property (copy, nonatomic) CKJExpressionRequiredBlock requiredExpression;

+ (instancetype)modelWithRequiredText:(NSString *)requiredText failExpression:(CKJExpressionRequiredBlock)expression;


/// 手机号格式错误
+ (instancetype)system_phoneRegError;

/// 验证码格式错误
+ (instancetype)system_verityCodeLengthError;

/// 确认密码和密码不一致
+ (instancetype)system_confirmPwdNotEqualPwdWithTableView:(CKJSimpleTableView *)simpleTableView;

/// 身份证号格式错误
+ (instancetype)system_verityIDCardError;


@end

@interface CKJTFModel : CKJBaseModel

/// 只读
@property (weak, nonatomic) UITextField *readOnly_currentTF;

@property (weak, nonatomic) CKJInputCellModel *readOnly_cm;

/// 右边的距离(距离验证码Btn.left的距离),  默认值0
@property (assign, nonatomic) CGFloat tfRightMargin;

@property (assign, nonatomic) BOOL userInteractionEnabled;

@property (assign, nonatomic) UITextBorderStyle borderStyle;
@property (assign, nonatomic) UIKeyboardType keyboardType;

@property(nonatomic) NSTextAlignment textAlignment;

/// 如果是NO 就是明文
@property (assign, nonatomic) BOOL secureTextEntry;

// 默认不设置， 如果设置 一般设置UITextFieldViewModeWhileEditing
@property (assign, nonatomic) UITextFieldViewMode clearButtonMode;

/// 最大输入长度
@property (strong, nonatomic) NSNumber *maxInputLength;

@property (nullable, nonatomic, copy) NSAttributedString *attText;
@property (nullable, nonatomic, copy) NSAttributedString *attPlaceholder;

- (void)_setText:(NSString *)text;
- (void)_setPlaceholder:(NSString *_Nullable)placeholder;


- (void)_becomeFirstResponder;

+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJTFModel *_Nonnull m))detailSettingBlock;

- (void)_afterSecondsListenTextChange:(CGFloat)seconds callBack:(void(^_Nullable)(NSString *_Nullable text))callBack;


/// 检验手机号
+ (BOOL)varityPhoneFail:(NSString *)phone;



#pragma mark - 下面是私有的
@property (assign, nonatomic) CGFloat seconds;
@property (copy, nonatomic) void(^block)(NSString *_Nullable text);

@property (copy, nonatomic) void (^updateText)(NSString *text);


@end



@interface CKJGetCodeModel : CKJBaseModel


/**
 右边的距离, 默认值15
 */
@property (assign, nonatomic) CGFloat getCodeRightMargin;

/**
 获取验证码Btn的宽度, 有默认值
 */
@property (assign, nonatomic) CGFloat codeBtnWidth;

@property (strong, nonatomic) UIImage *normalBGImage;

/**
 秒数正在减少的 文字, 有默认值
 */
@property (copy, nonatomic) NSString *(^countDownChanging)(CKJCountDownButton *countDownButton, NSUInteger second);

/**
 秒数正在减少的 文字, 有默认值
 */
@property (copy, nonatomic) NSString *(^countDownFinished)(CKJCountDownButton *countDownButton, NSUInteger second);

/**
 点击了验证码Block
 */
@property (copy, nonatomic) void (^clickCodeBlock)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock);


+ (nonnull instancetype)modelWithClickCodeBtnBlock:(void (^)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock))clickCodeBlock detail:(void(^_Nullable)(__kindof CKJGetCodeModel *m))detail;


@end



/*
 

 - (void)viewDidLoad {
     [super viewDidLoad];
     self.navigationItem.title = @"其他证件认证";
     KJ_typeweakself
     
     [self.simpleTableView updateStyle:^(CKJSimpleTableViewStyle * _Nonnull style) {
         style.rowHeight = @44;
         style.tfAlignment = NSTextAlignmentRight;
     }];
     
     CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
         
         CKJInputCellModel *idCardType = [self.simpleTableView _newtitle:@"证件类型" tfText:@"" placeholder:@"请选择" emptyRequirdText:@"证件类型" cellId:kOInput_idCardType detail:^(__kindof CKJInputCellModel * _Nonnull m) {
             m.stringChoose = [CKJStringChooseHelper helperWithHeader:m.title3Text items:[RJProjectResorce KJ_OtherCardType] detailSetting:^(__kindof CKJStringChooseHelper * _Nonnull helper) {
                 helper.currentSelectedStr = helper.chooseItems.firstObject.content.text;
             }];
         }];
         
         CKJInputCellModel *idCardNum = [self.simpleTableView _newtitle:@"证件号" tfText:@"" placeholder:@"请输入证件号" emptyRequirdText:@"证件号" cellId:kOInput_idCardNumber detail:^(__kindof CKJInputCellModel * _Nonnull m) {
         }];
         
         _sec.modelArray = @[idCardType, idCardNum];
     }];
     self.simpleTableView.dataArr = @[section1];
     
     
     [self createFooterViewWithBtnTitle:@"提交" clickHandle:^(UIButton * _Nonnull sender, UIViewController *se, CKJSimpleTableView *simpleTableView) {
         [weakSelf commit_action];
     }];
 }

 - (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
     
     KJ_typeweakself
     if ([model isKindOfClass:[CKJInputCellModel class]] == NO) return;
     __weak CKJInputCellModel *_model = model;
     if (_model.stringChoose) { // 选择的样式
         [_model.stringChoose showWithSelectedStr:_model.stringChoose.currentSelectedStr origin:self.view callBack:^(CKJStringChooseHelper *__weak  _Nonnull helper, __kindof CKJStringChooseItem * _Nonnull item, NSInteger selectedIndex) {
             [_model.tfModel _setText:item.content.text];
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

 - (void)commit_action {

     if ([self.simpleTableView verityInputFail]) return;
     
     [self.view endEditing:YES];
     

     RJInputData *data = [[RJInputData alloc] initWithSimpleTableView:self.simpleTableView];
     
     
     NSLog(@"%@   %@ ", data.idCardType._id, data.idCardNumber);
     
     NSInteger authType = 2;
     
     [RJCombineHttpRequest realtWithInputData:data authType:[NSString stringWithFormat:@"%ld", authType] animated:YES SuccessBlock:^(id responseObject) {
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dic = (NSDictionary *)responseObject;
             NSNumber *temp = dic[@"result"];
             if (temp.intValue == 0) {
                 [self kjwd_popToSpecifyVC:[RJPersonalVC class] currentStackBlock:^(RJPersonalVC * _Nonnull findZheVC) {
                     [findZheVC requestReadStatus];
                 } newAllocVC:nil];
             }
             if (!WDKJ_IsEmpty_Str(dic[@"message"])) {
                 [MBProgressHUD showSuccess:dic[@"message"] toView:[UIWindow kjwd_appdelegateWindow]];
             }
         }
     } failureBlock:^(NSError *error) {
         if (error.localizedDescription) {
             [MBProgressHUD showError:error.localizedDescription];
         }
     }];
 }

 
 
 
 
 
 
 
 
 
 
 

 - (void)viewDidLoad {
     [super viewDidLoad];
     self.navigationItem.title = @"注销账户";
     KJ_typeweakself
     
     [self.simpleTableView updateStyle:^(CKJSimpleTableViewStyle * _Nonnull style) {
         style.rowHeight = @44;
     }];
     
     CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
         
         CKJInputCellModel *phone = [self.simpleTableView _newtitle:@"手机号" tfText:[RJClient kj_Phone] placeholder:@"请输入手机号" emptyRequirdText:nil cellId:kOInput_Phone detail:^(__kindof CKJInputCellModel * _Nonnull m) {
             [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                 tfModel.userInteractionEnabled = NO;
             }];
         }];
         
         CKJInputCellModel *code = [self.simpleTableView _newtitle:@"验证码" tfText:@"" placeholder:@"请输入验证码" emptyRequirdText:@"验证码" cellId:kOInput_VerityCode detail:^(__kindof CKJInputCellModel * _Nonnull m) {
             [m addRequired:[CKJInputExpressionRequiredModel system_verityCodeLengthError]];
             // 注意：一定要设置 手机号的cellId 为 kOInput_Phone，不然无法发送验证码
             m.getCodeModel = [CKJGetCodeModel modelWithClickCodeBtnBlock:^(CKJTriggerCodeBlock  _Nonnull triggerCodeBlock) {
                 // 手机号
                 NSString *_phone = [weakSelf.simpleTableView inputCellModelOfID:kOInput_Phone].getTfText;
                 
                 [RJCombineHttpRequest getPhoneSmsCodeWithPhoneNum:_phone BusinessId:@"DeleteAppUserAndRelated" animated:YES SuccessBlock:^(id responseObject) {
                     triggerCodeBlock(60); // 触发定时器
                     [[weakSelf.simpleTableView inputCellModelOfID:kOInput_VerityCode].tfModel.readOnly_currentTF becomeFirstResponder];
                 } failureBlock:^(NSError *error) {
                     if (error.localizedDescription) {
                         [MBProgressHUD showError:error.localizedDescription];
                     }
                 }];
             } detailSettingBlock:nil];
             
         }];
         
         
         _sec.modelArray = @[phone, code];
     }];
     self.simpleTableView.dataArr = @[section1];
     
     
     [self createFooterViewWithBtnTitle:@"注销账户" clickHandle:^(UIButton * _Nonnull sender, RJDeleteUserVC *se, CKJSimpleTableView *simpleTableView) {
         
         if ([se.simpleTableView verityInputFail]) return;
         
         [weakSelf.view endEditing:YES];
         
         // 手机号
         NSString *_phone = [weakSelf.simpleTableView inputCellModelOfID:kOInput_Phone].getTfText;
         
         // 验证码
         NSString *_verityCode = [weakSelf.simpleTableView inputCellModelOfID:kOInput_VerityCode].getTfText;
         
         weakSelf.alert = [UIAlertController kjwd_alertTitle:@"确定要注销此账户吗？" message:@"注销账户将会删除该账户的所有信息，请谨慎操作" alertAction_Left:@"取消" leftBlock:nil right:@"确定" rightBlock:^(UIAlertController *a){
             [RJCombineHttpRequest deleteUserWithPhone:_phone code:_verityCode animated:YES SuccessBlock:^(id responseObject) {
                 [MBProgressHUD showError:@"注销账户成功"];
                 [[RJClient shareClient] clearUserInfo];
                 [weakSelf kjwd_popToSpecifyVC:[RJPersonalVC class] currentStackBlock:nil newAllocVC:nil];
             } failureBlock:^(NSError *error) {
                 if (error.localizedDescription) {
                     [MBProgressHUD showError:error.localizedDescription];
                 }
             }];
         } presentingVC:weakSelf];
     }];
 }

 - (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView {
     [self.view endEditing:YES];
 }
 
 
 */



@interface CKJInputCellModel : CKJCellModel

@property (weak, nonatomic) CKJSimpleTableViewStyle *style;

@property (strong, nonatomic, nullable) CKJStringChooseHelper *stringChoose;
@property (strong, nonatomic, nullable) CKJDateChooseHelper *dateChoose;

- (void)updateTFModel:(void(^_Nullable)(CKJTFModel *_Nonnull tfModel))block;

@property (strong, nonatomic, readonly) CKJTFModel *tfModel;

@property (strong, nonatomic, nullable) CKJGetCodeModel *getCodeModel;

/// 输入框的限制
@property (strong, nonatomic, nullable) NSArray <CKJInputExpressionRequiredModel *>*expressionRequiredArray;

/// 增加限制
- (void)addRequired:(CKJInputExpressionRequiredModel *)model;


- (NSString *_Nullable)getTfText;

+ (instancetype)inputWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJInputCellModelRowBlock)detailSettingBlock;

@end



@interface CKJInputCell : CKJCell

@end




@interface CKJInputAddition : CKJBaseModel

+ (nonnull UIImage *)systemStarImageWithSize:(CGSize)size;

@end


NS_ASSUME_NONNULL_END
