//
//  CKJInputCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJInputCell.h"
#import "UIView+CKJDesingable.h"
#import "CKJSimpleTableView.h"
#import "CKJLibraryHelper.h"
#import <Masonry/Masonry.h>
#import "CKJHUD+KJSupport.h"
#import "CKJSimpleTableViewStyle.h"

CGFloat const kOConst_Input_Tf_FontSize = 14;

// Empty required
CKJInputExpressionRequiredModel * WDKJ_ER(NSString *emptyRequiredText) {
    CKJInputExpressionRequiredModel *model = [[CKJInputExpressionRequiredModel alloc] init];
    model.requiredText = [NSString stringWithFormat:@"%@不能为空", emptyRequiredText];
    
    model.requiredExpression = ^BOOL(NSString * _Nullable text, __kindof CKJCommonCellModel * _Nonnull cm) {
        return WDKJ_IsEmpty_Str(text);
    };
    return model;
}

@implementation CKJInputExpressionRequiredModel

- (instancetype)init {
    if (self = [super init]) {
        self.required = YES;
    }
    return self;
}

+ (instancetype)modelWithRequiredText:(NSString *)requiredText failExpression:(CKJExpressionRequiredBlock)expression {
    CKJInputExpressionRequiredModel *model = [[CKJInputExpressionRequiredModel alloc] init];
    model.requiredText = requiredText;
    model.requiredExpression = expression;
    return model;
}

/// 手机号格式错误
+ (instancetype)system_phoneRegError {
    return [CKJInputExpressionRequiredModel modelWithRequiredText:@"手机号格式错误" failExpression:^BOOL(NSString * _Nullable text, __kindof CKJCommonCellModel * _Nonnull cm) {
        return ![text kjwd_varityPhoneSuccess];
    }];
}

/// 验证码格式错误
+ (instancetype)system_verityCodeLengthError {
    return [CKJInputExpressionRequiredModel modelWithRequiredText:@"验证码必须是6位" failExpression:^BOOL(NSString * _Nullable text, CKJInputCellModel * _Nonnull cm) {
        return text.length != 6;
    }];
}

/// 确认密码和密码不一致
+ (instancetype)system_confirmPwdNotEqualPwdWithTableView:(CKJSimpleTableView *)simpleTableView {
    return [CKJInputExpressionRequiredModel modelWithRequiredText:@"输入密码不一致" failExpression:^BOOL(NSString * _Nullable text, CKJInputCellModel * _Nonnull cm) {
        // 密码
        NSString *_pwd = [simpleTableView inputCellModelOfID:kOInput_Pwd].getTfText;
        return ![text isEqualToString:_pwd];
    }];
}

@end


@interface CKJTFModel ()

@end

@implementation CKJTFModel


- (void)__privateMethod__exeCallBack {
    if (_block) {
        _block(_attText.string);
    }
}

- (void)setAttText:(NSAttributedString *)attText {
    if (attText == nil || [attText isKindOfClass:[NSAttributedString class]]) {
        _attText = attText;
        self.readOnly_currentTF.attributedText = attText;
        if (self.updateText) {
            self.updateText(attText.string);
        }
    }
}

- (void)_setText:(NSString *)text {
    NSDictionary *att = self.readOnly_cm.style.tfTextAttributed;
    if (att) {
        self.attText = WDCKJAttributed2(text, att[NSForegroundColorAttributeName], att[NSFontAttributeName]);
    } else {
        self.attText = WDCKJAttributed2(text, [UIColor kjwd_title], @(kOConst_Input_Tf_FontSize));
    }
}

- (void)_setPlaceholder:(NSString *_Nullable)placeholder; {
    self.attPlaceholder = WDCKJAttributed2(placeholder, [UIColor kjwd_r:190 g:190 b:190 alpha:1], @(kOConst_Input_Tf_FontSize));
}
- (void)_afterSecondsListenTextChange:(CGFloat)seconds callBack:(void(^_Nullable)(NSString *_Nullable text))callBack {
    _seconds = seconds;
    _block = callBack;
}

+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJTFModel *_Nonnull tfM))detailSettingBlock {
    CKJTFModel *model = [[self alloc] init];
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    return model;
}
- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.keyboardType = UIKeyboardTypeDefault;
        self.tfRightMargin = 0;
        self.secureTextEntry = NO;
    }
    return self;
}

/// 检验手机号
+ (BOOL)varityPhoneFail:(NSString *)phone {
    
    //  可以复制文字  @"手机号为空或有误"    或代码  [CKJHUD showError:@"手机号为空或有误"];
       
    if (WDKJ_IsEmpty_Str(phone)) {
        return YES;
    }
    return ![phone kjwd_varityPhoneSuccess];
}

@end


@implementation CKJGetCodeModel

+ (nonnull instancetype)modelWithClickCodeBtnBlock:(void (^)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock))clickCodeBlock detailSettingBlock:(void(^_Nullable)(__kindof CKJGetCodeModel *m))detailSettingBlock {
    CKJGetCodeModel *model = [[self alloc] init];
    model.clickCodeBlock = clickCodeBlock;
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    return model;
}

- (instancetype)init {
    if (self = [super init]) {
        self.codeBtnWidth = 100;
        self.getCodeRightMargin = 15;
        
        self.countDownChanging = ^NSString *(CKJCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"还有%zd秒", (long)second];
            return title;
        };
        self.countDownFinished = ^NSString * _Nonnull(CKJCountDownButton * _Nonnull countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;  // 一定要设置这个，让按钮可用
            return @"重新发送";
        };
    }
    return self;
}

@end


@interface CKJInputCellModel ()

@property (strong, nonatomic, nonnull) CKJTFModel *tfModel;


@end

@implementation CKJInputCellModel

- (void)addRequired:(CKJInputExpressionRequiredModel *)model {
    if (WDKJ_IsNullObj(model, [CKJInputExpressionRequiredModel class])) return;
    NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.expressionRequiredArray];
    [arr kjwd_addObject:model];
    self.expressionRequiredArray = arr;
}

- (NSString *_Nullable)getTfText {
    return self.tfModel.attText.string;
}

- (void)updateTFModel:(void(^_Nullable)(CKJTFModel *_Nonnull tfModel))block {
    if (block && _tfModel) {
        block(_tfModel);
    }
}

+ (nonnull instancetype)inputWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJInputCellModelRowBlock)detailSettingBlock {
    CKJInputCellModel *m = [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:^(__kindof CKJCommonCellModel * _Nonnull m) {
        [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
            if ([cellModel_id isEqualToString:kOInput_Phone] || [cellModel_id isEqualToString:kOInput_SpecialPhone]) {
                 tfModel.keyboardType = UIKeyboardTypePhonePad;
                tfModel.maxInputLength = @11;
                [tfModel _setPlaceholder:@"请输入手机号"];
            } else if ([cellModel_id isEqualToString:kOInput_VerityCode]) {
                 tfModel.keyboardType = UIKeyboardTypeNumberPad;
                [tfModel _setPlaceholder:@"请输入验证码"];
            } else if ([cellModel_id isEqualToString:kOInput_Pwd]) {
                tfModel.secureTextEntry = YES;
                [tfModel _setPlaceholder:@"请输入密码"];
            } else if ([cellModel_id isEqualToString:kOInput_ConfirmPwd]) {
                tfModel.secureTextEntry = YES;
                [tfModel _setPlaceholder:@"请再次输入密码"];
            }
        }];
        if (detailSettingBlock) {
            detailSettingBlock(m);
        }
    } didSelectRowBlock:nil];
    return m;
}

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tfModel = [[CKJTFModel alloc] init];
        __weak typeof(self) weakSelf = self;
        self.tfModel.updateText = ^(NSString * _Nonnull text) {
            if (weakSelf.stringChoose) {
                weakSelf.stringChoose.currentSelectedStr = text;
            }
            if (weakSelf.dateChoose) {
                [weakSelf.dateChoose updateCurrentSelectedDateWithDateStr:text];
            }
        };
    }
    return self;
}

@end


@interface CKJInputCell ()

@property (strong, nonatomic) UITextField *tf;
@property (strong, nonatomic) CKJCountDownButton *codeBtn;

@end


@implementation CKJInputCell

- (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    [super setupData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
    
    if ([model isKindOfClass:[CKJInputCellModel class]] == NO) return;

    CKJInputCellModel *_model = model;
    _model.style = tableView.simpleStyle;
    CKJTFModel *tfModel = _model.tfModel;

    [CKJLibraryHelper commomCode1WithTFModel:tfModel tf:_tf];
    
    tfModel.readOnly_cm = model;
    
    CKJGetCodeModel *getCodeModel = _model.getCodeModel;
    
    
    BOOL tfIsNull = WDKJ_IsNullObj(tfModel, [CKJTFModel class]);
    BOOL getCodeIsNull = WDKJ_IsNullObj(getCodeModel, [CKJGetCodeModel class]);
    
    CGFloat width = getCodeModel.codeBtnWidth;
    CGFloat getCodeRightMargin = getCodeModel.getCodeRightMargin;
    
    [self.codeBtn kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        if (tfIsNull) {
            make.left.equalTo(_tf.mas_right);
        } else {
            CGFloat tfRightMargin = tfModel.tfRightMargin;
            make.left.equalTo(_tf.mas_right).offset(tfRightMargin);
        }
        
        
        if (getCodeIsNull) {
            make.width.equalTo(@0);
            make.right.equalTo(superview);
            [_codeBtn kjwd_setHidden:YES];
        } else {
            [_codeBtn kjwd_setHidden:NO];
            make.width.equalTo(@(width));
            make.right.equalTo(superview).offset(-(getCodeRightMargin));
        }
    }];
}

- (void)setupSubViews {
    [super setupSubViews];
    
    UITextField *tf = [[UITextField alloc] init];
    [tf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEditingEvents];
    tf.font = [UIFont systemFontOfSize:15];
    [self.tfWrapperView addSubview:tf];
    
    self.tf = tf;
    
    [tf kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.top.bottom.equalTo(superview);
    }];
    
    
    [tf setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisHorizontal];
    [tf setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    CKJCountDownButton *btn = [CKJCountDownButton buttonWithType:UIButtonTypeCustom];

    [btn setContentHuggingPriority:230 forAxis:UILayoutConstraintAxisHorizontal];
    [btn setContentCompressionResistancePriority:730 forAxis:UILayoutConstraintAxisHorizontal];

    btn.kCornerRadius = 5;
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];

    
    [btn setBackgroundImage:[UIImage kjwd_imageWithColor:[UIColor kjwd_r:14 g:128 b:200 alpha:1] size:CGSizeMake(100, 30)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(countDownTouched:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.tfWrapperView addSubview:btn];
    [btn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(tf.mas_right);
        make.centerY.equalTo(tf);
        make.right.equalTo(superview);
        make.width.equalTo(@0);
        make.height.equalTo(@28);
    }];
    self.codeBtn = btn;
    
    WDCKJ_ifDEBUG(^{
        BOOL debug = [self __privateMethod_openDebug];
        if (debug) {
            tf.backgroundColor = [UIColor yellowColor];
            btn.backgroundColor = [UIColor greenColor];
        }
    }, nil);
}

- (BOOL)__privateMethod_openDebug {
    return NO;
}

- (void)countDownTouched:(CKJCountDownButton *)sender {

    __weak typeof(self) weakSelf = self;

    CKJInputCellModel *phoneCellModel = [self.simpleTableView cellModelOfID:kOInput_Phone];
    NSString *text = phoneCellModel.getTfText;
    
    NSString *phone = [text kjwd_trimWhiteAndNewline];
    
    if ([CKJTFModel varityPhoneFail:phone]) {
        NSLog(@"%@ ", @"手机号为空或有误");
        //[CKJHUD showError:@"手机号为空或有误"];
        [CKJHUD kjwd_showMessage:@"手机号为空或有误"];
        return;
    }   
    CKJTriggerCodeBlock succ = ^(NSUInteger seconds) {
        sender.enabled = NO;
        //button type要 设置成custom 否则会闪动
        [sender startCountDownWithSecond:seconds];

        CKJInputCellModel *cellModel = (CKJInputCellModel *)weakSelf.cellModel;
        CKJGetCodeModel *codeModel = cellModel.getCodeModel;
        
        [sender countDownChanging:codeModel.countDownChanging];
        [sender countDownFinished:codeModel.countDownFinished];
    };
    
    if ([self.cellModel isKindOfClass:[CKJInputCellModel class]] == NO) return;
    
    CKJInputCellModel *_model = (CKJInputCellModel *)self.cellModel;
    void (^clickCodeBlock)(CKJTriggerCodeBlock triggerCodeBlock) = _model.getCodeModel.clickCodeBlock;
    
    clickCodeBlock ? clickCodeBlock(succ) : nil;
}

// 监听文字改变
- (void)textChange:(UITextField *)tf {
    if ([self.cellModel isKindOfClass:[CKJInputCellModel class]] == NO) return;
    CKJInputCellModel *_model = (CKJInputCellModel *)self.cellModel;
    CKJTFModel *tfModel = _model.tfModel;
    
    if (!WDKJ_IsNull_Num(tfModel.maxInputLength)) {
        
        NSInteger kMaxLength = tfModel.maxInputLength.integerValue;
        NSString *toBeString = tf.text;
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
        if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
            UITextRange *selectedRange = [tf markedTextRange];
            //获取高亮部分
            UITextPosition *position = [tf positionFromPosition:selectedRange.start offset:0];
            if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (toBeString.length > kMaxLength) {
                    tf.text = [toBeString substringToIndex:kMaxLength];
                }
            }
            else{//有高亮选择的字符串，则暂不对文字进行统计和限制
            }
        }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (toBeString.length > kMaxLength) {
                tf.text = [toBeString substringToIndex:kMaxLength];
            }
        }
    }
    
    [CKJLibraryHelper commomCode2WithTFModel:tfModel tf:self.tf];
}

@end

@implementation CKJInputAddition

+ (nonnull UIImage *)systemStarImageWithSize:(CGSize)size {
    return [UIImage kjwd_imageWithColor:[UIColor whiteColor] size:size text:@"*" textAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:16]} circular:NO];
}

@end
