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


@implementation CKJTFModel


+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^)(__kindof CKJTFModel *_Nonnull tfM))detailSettingBlock {
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
        self.rightMargin = 15;
    }
    return self;
}

@end


@implementation CKJGetCodeModel

+ (nonnull instancetype)modelWithClickCodeBtnBlock:(void (^)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock))clickCodeBlock detailSettingBlock:(void(^)(__kindof CKJGetCodeModel *_Nonnull m))detailSettingBlock {
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
        self.rightMargin = 15;
        
        self.countDownChanging = ^NSString *(CKJCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%zds", (long)second];
            return title;
        };
        self.countDownFinished = ^NSString * _Nonnull(CKJCountDownButton * _Nonnull countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"获取验证码";
        };
    }
    return self;
}

@end


@implementation CKJInputCellModel


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJInputCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJInputCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

    if ([_model.tfModel isKindOfClass:[CKJTFModel class]] == NO) return;
    
    NSString *text = _model.tfModel.text;
    NSAttributedString *attributedText = _model.tfModel.attributedText;
    
    NSString *placeholder = _model.tfModel.placeholder;
    NSAttributedString *attributedPlaceholder = _model.tfModel.attributedPlaceholder;
    
    
    
    if (WDKJ_IsEmpty_AttributedStr(attributedText) == NO) {
        self.tf.attributedText = attributedText;
    } else if (WDKJ_IsEmpty_Str(text) == NO) {
        self.tf.text = text;
    } else {
        self.tf.attributedText = nil;
        self.tf.text = nil;
    }
    
    if (WDKJ_IsEmpty_AttributedStr(attributedPlaceholder) == NO) {
        self.tf.attributedPlaceholder = attributedPlaceholder;
    } else if (WDKJ_IsEmpty_Str(placeholder) == NO) {
        self.tf.placeholder = placeholder;
    } else {
        self.tf.attributedPlaceholder = nil;
        self.tf.placeholder = nil;
    }
    self.tf.userInteractionEnabled = _model.tfModel.userInteractionEnabled;
    self.tf.textAlignment = _model.tfModel.textAlignment;
    self.tf.borderStyle = _model.tfModel.borderStyle;
    self.tf.keyboardType = _model.tfModel.keyboardType;
    
    CKJTFModel *tfModel = _model.tfModel;
    CKJGetCodeModel *getCodeModel = _model.getCodeModel;
    
    
    BOOL tfIsNull = WDKJ_IsNullObj(tfModel, [CKJTFModel class]);
    BOOL getCodeIsNull = WDKJ_IsNullObj(getCodeModel, [CKJGetCodeModel class]);
    
    CGFloat width = getCodeModel.codeBtnWidth;
    CGFloat rightMargin = getCodeModel.rightMargin;
    
    [self.codeBtn kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        if (tfIsNull) {
            make.left.equalTo(self.tf.mas_right);
        } else {
            CGFloat rightMargin = tfModel.rightMargin;
            make.left.equalTo(self.tf.mas_right).offset(rightMargin);
        }
        
        
        if (getCodeIsNull) {
            make.width.equalTo(@0);
            make.right.equalTo(superview);
            
            [self.codeBtn kjwd_setHidden:YES];
        } else {
            [self.codeBtn kjwd_setHidden:NO];
            make.width.equalTo(@(width));
            make.right.equalTo(superview).offset(-(rightMargin));
        }
    }];
}

- (void)setupSubViews {
    [super setupSubViews];
    
    UITextField *tf = [[UITextField alloc] init];
    
    [tf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEditingEvents];
    tf.font = [UIFont systemFontOfSize:15];
    [self.centerExtraView addSubview:tf];
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
    [self.centerExtraView addSubview:btn];
    [btn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(tf.mas_right);
        make.centerY.equalTo(tf);
        make.right.equalTo(superview);
        make.width.equalTo(@0);
        make.height.equalTo(@28);
    }];
    self.codeBtn = btn;
    
    BOOL debug = NO;
    if (debug) {
        tf.backgroundColor = [UIColor yellowColor];
        btn.backgroundColor = [UIColor greenColor];
    }
}

- (void)countDownTouched:(CKJCountDownButton *)sender {

    __weak typeof(self) weakSelf = self;

    CKJInputCellModel *model = [self.simpleTableView cellModelOfID:kInput_Phone];
    NSString *text =   model.tfModel.text;
    NSAttributedString *att = WDKJ_ConfirmAttString(model.tfModel.attributedText);
 
    NSString *textPhone = [text kjwd_trimWhiteAndNewline];
    NSString *attPhone = [att.string kjwd_trimWhiteAndNewline];
    BOOL empty1 = WDKJ_IsEmpty_Str(textPhone);
    BOOL empty2 = WDKJ_IsEmpty_Str(attPhone);
    
    if (empty1 && empty2) {
        NSLog(@"%@ ", @"手机号为空或有误");
//        [MBProgressHUD showMessage:@"手机号为空或有误"];
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

- (void)textChange:(UITextField *)tf {
    if ([self.cellModel isKindOfClass:[CKJInputCellModel class]] == NO) return;
    
    CKJInputCellModel *_model = (CKJInputCellModel *)self.cellModel;
    
    if ([_model.tfModel isKindOfClass:[CKJTFModel class]] == NO) return;
    
    _model.tfModel.text = tf.text;
    _model.tfModel.attributedText = tf.attributedText;
}



@end
