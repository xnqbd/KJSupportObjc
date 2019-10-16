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


NSInteger const kInput_Name = 3673620;
NSInteger const kInput_Sex = 4021728;
NSInteger const kInput_Phone = 5025618;
NSInteger const kInput_VerityCode = 6032293;
NSInteger const kInput_idCardType = 6729211;
NSInteger const kInput_idCardNumber = 12934174;
NSInteger const kInput_Birthday = 362891;
NSInteger const kInput_Relationship = 372902;
NSInteger const kInput_Address = 886252;
NSInteger const kInput_Email = 2628390;



@interface CKJTFModel ()

@property (assign, nonatomic) CGFloat seconds;
@property (copy, nonatomic) void(^block)(NSAttributedString *_Nullable attText);

@end

@implementation CKJTFModel


- (void)__privateMethod__exeCallBack {
    if (_block) {
        _block(self.attributedText);
    }
}

- (void)_setText:(NSString *_Nullable)text {
    self.attributedText = WDCKJAttributed2(text, [UIColor darkTextColor], @15);
}
- (void)_setPlaceholder:(NSString *_Nullable)placeholder; {
    self.attributedPlaceholder = WDCKJAttributed2(placeholder, [UIColor kjwd_r:190 g:190 b:190 alpha:1], @15);
}
- (void)_afterSecondsListenTextChange:(CGFloat)seconds callBack:(void(^_Nullable)(NSAttributedString *_Nullable attText))callBack {
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
        self.rightMargin = 15;
    }
    return self;
}

/// 检验手机号
+ (BOOL)verityPhone:(NSString *)phone {
    
    //  可以复制文字  @"手机号为空或有误"    或代码  [MBProgressHUD showError:@"手机号为空或有误"];
       
    if (WDKJ_IsEmpty_Str(phone)) {
        return NO;
    }
    return [phone kjwd_validatePhone];
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

- (NSString *_Nullable)tfText {
    return self.tfModel.attributedText.string;
}

- (void)updateTFModel:(void(^_Nullable)(CKJTFModel *_Nonnull tfModel))block {
    if (block && _tfModel) {
        block(_tfModel);
    }
}

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJInputCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJInputCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tfModel = [[CKJTFModel alloc] init];
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

    NSAttributedString *attributedText = _model.tfModel.attributedText;

    NSAttributedString *attributedPlaceholder = _model.tfModel.attributedPlaceholder;
    
    if (WDKJ_IsEmpty_AttributedStr(attributedText)) {
        self.tf.attributedText = nil;
    } else {
        self.tf.attributedText = attributedText;
    }
    
    if (WDKJ_IsEmpty_AttributedStr(attributedPlaceholder)) {
        self.tf.attributedPlaceholder = nil;
    } else {
        self.tf.attributedPlaceholder = attributedPlaceholder;
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
    
    BOOL debug = NO;
    if (debug) {
        tf.backgroundColor = [UIColor yellowColor];
        btn.backgroundColor = [UIColor greenColor];
    }
}

- (void)countDownTouched:(CKJCountDownButton *)sender {

    __weak typeof(self) weakSelf = self;

    CKJInputCellModel *phoneCellModel = [self.simpleTableView cellModelOfID:kInput_Phone];
    NSString *text = phoneCellModel.tfModel.attributedText.string;
    
    NSString *phone = [text kjwd_trimWhiteAndNewline];
    
    if (![CKJTFModel verityPhone:phone]) {
        NSLog(@"%@ ", @"手机号为空或有误");
        [MBProgressHUD showError:@"手机号为空或有误"];
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
    
    if ([tfModel isKindOfClass:[CKJTFModel class]] == NO) return;
    
//    NSLog(@"tf.attributedText.string  %@", tf.attributedText.string);
    
    if (![tfModel.attributedText.string isEqualToString:tf.attributedText.string]) {
        tfModel.attributedText = tf.attributedText;
        
        SEL sel = @selector(__privateMethod__exeCallBack);
        [NSObject cancelPreviousPerformRequestsWithTarget:tfModel selector:sel object:nil];
        [tfModel performSelector:sel withObject:nil afterDelay:tfModel.seconds];
//        NSLog(@"后 %@", tf.attributedText.string);
    }
}

@end

@implementation CKJInputAddition

+ (nonnull UIImage *)systemStarImageWithSize:(CGSize)size {
    return [UIImage kjwd_imageWithColor:[UIColor whiteColor] size:size text:@"*" textAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:16]} circular:NO];
}

@end
