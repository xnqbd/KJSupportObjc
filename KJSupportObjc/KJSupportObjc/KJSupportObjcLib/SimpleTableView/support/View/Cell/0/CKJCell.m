//
//  CKJCell.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJCell.h"
#import <Masonry/Masonry.h>

#import "UIView+CKJDesingable.h"

@implementation CKJCellBtnModel


+ (nonnull instancetype)btnModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJCellBtnModel *_Nonnull sender))detailSettingBlock didClickBtnHandle:(nullable CKJDidClickBtnHandle)didClickBtnHandle {
    CKJCellBtnModel *model = [[self alloc] init];
    model.normalImage = normalImage;
    model.rightMargin = rightMargin;
    model.size = size;
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    model.didClickBtnHandle = didClickBtnHandle;
    return model;
}

@end


@implementation CKJView5Model

+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText centerMarign:(CGFloat)centerMarign topBottomMargin:(CGFloat)topBottomMargin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    
    CKJView5Model *model = [[self alloc] init];
    model.topText = topText;
    model.bottomText = bottomText;
    
    UIEdgeInsets topEdge = UIEdgeInsetsMake(topBottomMargin, leftMargin, centerMarign / 2.0, rightMargin);
    UIEdgeInsets bottomEdge = UIEdgeInsetsMake(centerMarign / 2.0, leftMargin, topBottomMargin, rightMargin);
    
    model.topLabelEdge = topEdge;
    model.bottomLabelEdge = bottomEdge;
    
    return model;
}

+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText topEdge:(UIEdgeInsets)topEdge bottomEdge:(UIEdgeInsets)bottomEdge {
    
    CKJView5Model *model = [[self alloc] init];
    model.topText = topText;
    model.bottomText = bottomText;
    
    model.topLabelEdge = topEdge;
    model.bottomLabelEdge = bottomEdge;
    
    return model;
}

- (void)changeTopText:(nullable NSString *)text {
    self.topText = [CKJWorker changeOriginAtt:self.topText text:text];
}

- (void)changeBottomText:(nullable NSString *)text {
    self.bottomText = [CKJWorker changeOriginAtt:self.bottomText text:text];
}

@end

@implementation CKJSwitch6Model


+ (nonnull instancetype)switch6ModelWithSwitchOn:(BOOL)switchOn left:(CGFloat)left top:(CGFloat)top bottom:(CGFloat)bottom callBack:(nonnull CKJSwitch6Block)callBack {
    CKJSwitch6Model *model = [[self alloc] init];
    model.switchOn = switchOn;
    model.left = left;
    model.top = top;
    model.bottom = bottom;
    model.swicthBlock = callBack;
    return model;
}

@end

#pragma mark - -----UI组件-----

@interface CKJTopBottomView : UIView
@end
@implementation CKJTopBottomView
@end



@interface CKJButton5 : UIButton
@end
@implementation CKJButton5
@end


@interface CKJView5TopLabel : UILabel
@end
@implementation CKJView5TopLabel
@end

@interface CKJView5BottomLabel : UILabel
@end
@implementation CKJView5BottomLabel
@end



@interface CKJButton7 : UIButton
@end
@implementation CKJButton7
@end

@implementation CKJLikePriceLabel61Model

+ (instancetype)likePriceModelWithAttText:(NSAttributedString *)text left:(CGFloat)left right:(CGFloat)right {
    CKJLikePriceLabel61Model *model = [[self alloc] init];
    model.attributedText = text;
    model.leftMargin = left;
    model.rightMargin = right;
    return model;
}
- (void)changeText:(nullable NSString *)text {
    self.attributedText = [CKJWorker changeOriginAtt:self.attributedText text:text];
}

+ (instancetype)likePriceModelWithLeftMargin:(CGFloat)leftMargin {
    return [self likePriceModelWithAttText:WDAtt15_5(@"") left:leftMargin right:0];
}

@end

#pragma mark - -----模型和cell-----
@implementation CKJCellModel

- (instancetype)init {
    if (self = [super init]) {
        [self _showLine:YES];
    }
    return self;
}

+ (instancetype)ckjCellWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCellModelRowBlock)didSelectRowBlock {
    return [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end




@interface CKJCell ()

@property (strong, nonatomic) UILabel *subTitle4;

@property (strong, nonatomic) UIButton *btn5;

@property (strong, nonatomic) CKJTopBottomView *view5;
@property (strong, nonatomic) UILabel *view5_topLabel;
@property (strong, nonatomic) UILabel *view5_bottomLabel;


/**
 中间的附加View
 */
@property (strong, nonatomic) CKJTextFieldWrapperView *tfWrapperView;



@property (strong, nonatomic) UIView *kjSwitch6;
@property (strong, nonatomic) UILabel *alikePriceLabel61;
@property (strong, nonatomic) UIButton *btn7;

@end

@implementation CKJCell

- (void)setupSubViews {
    [super setupSubViews];
    
    __weak typeof(self) weakSelf = self;
    
    [self create_subtitle4];
    [self create_btn5];
    [self create_View5];
    [self create_tfWrapperView];
    [self create_67];

    /*
     顺序
     
     [subTitle4  btn5  View5  tfWrapperView  kjSwitch6  price61  btn7]
     
     */
    
    
    // 约束 subTitle4
    [self origin_subTitle4_Constraint];
    
    
    // 约束 View5的子视图
    [self origin_topBottomView_Constraint];
    
  
    
    [_view5 kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.equalTo(superview);
        make.right.equalTo(weakSelf.tfWrapperView.mas_left);
    }];
    [_tfWrapperView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.equalTo(superview);
        make.right.equalTo(weakSelf.kjSwitch6.mas_left);
    }];
    
    [self origin_switchView6_Constraint];
    
    [_btn7 kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.right.equalTo(superview);
    }];
    
    WDCKJ_ifDEBUG(^{
        BOOL debug = [self __privateMethod_openDebug];
        if (debug) {
            
            //        self.leftWrapView.backgroundColor = [UIColor redColor];
            self.imageBtn2.backgroundColor = [UIColor purpleColor];
            self.title3.backgroundColor = [UIColor brownColor];
            self.subTitle4.backgroundColor = [UIColor yellowColor];
            
            
            self.btn5.backgroundColor = [UIColor magentaColor];
            
            self.view5.backgroundColor = [UIColor cyanColor];
            self.view5_topLabel.backgroundColor = [UIColor purpleColor];
            self.view5_bottomLabel.backgroundColor = [UIColor magentaColor];
            
            self.tfWrapperView.backgroundColor = [UIColor redColor];
            
            self.kjSwitch6.backgroundColor = [UIColor blueColor];
            //        self.rightWrapView.backgroundColor = [UIColor darkGrayColor];
            self.alikePriceLabel61.backgroundColor = [UIColor kjwd_blueBtnColor];
            
            self.btn7.backgroundColor = [UIColor systemRedColor];
            self.arrowImageView9.backgroundColor = [UIColor grayColor];
        }
    }, nil);
}

- (BOOL)__privateMethod_openDebug {
    return NO;
}

- (void)setupData:(CKJCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    [super setupData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
    if ([model isKindOfClass:[CKJCellModel class]] == NO) return;
    
    [self origin_subTitle4_Constraint];
    
    [self origin_btn5_Constraint];
    
    // 设置 top bottom
    [self origin_topBottomView_Constraint];
    
    [self update_tfWrapperView_Constraint];
    
    [self origin_switchView6_Constraint];
    
    [self update_alikePriceLabel61_Constraint];
    
    [self origin_btn7_Constraint];
}


- (void)swicthAction:(UISwitch *)swicth {
    BOOL on = swicth.on;
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    model.switch6Model.switchOn = on;
    if (model.switch6Model.swicthBlock) {
        model.switch6Model.swicthBlock(on, model, swicth);
    }
}

- (void)create_subtitle4 {

    UILabel *subTitle4 = [CKJSubTitle4Label new];
    subTitle4.numberOfLines = 0;
    [self.subviews_SuperView addSubview:subTitle4];
    
    self.subTitle4 = subTitle4;
    
    __weak typeof(self) weakSelf = self;
    [subTitle4 kjwd_addGestureRecognizer:[[UITapGestureRecognizer alloc] init] handleBlock:^(UIGestureRecognizer * _Nonnull _gestureRecognizer, UIView * _Nonnull _currentView) {
        CKJCellModel *m = (CKJCellModel *)weakSelf.cellModel;
        if (m.subTitle4Model.click) {
            m.subTitle4Model.click(weakSelf);
        }
    }];
}

- (void)create_btn5 {
    __weak typeof(self) weakSelf = self;
    CKJButton5 *btn5 = [CKJButton5 buttonWithType:UIButtonTypeCustom];
    [btn5 kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull _sender) {
        CKJCellModel *model = (CKJCellModel *)weakSelf.cellModel;
        if (model.btn5Model.didClickBtnHandle) {
            model.btn5Model.didClickBtnHandle(weakSelf, model.btn5Model);
        }
    }];
    [self.subviews_SuperView addSubview:btn5];
    self.btn5 = btn5;
}

- (void)create_View5 {
    
    CKJTopBottomView *view5 = [CKJTopBottomView new];
    [self.subviews_SuperView addSubview:view5];
    self.view5 = view5;
    
    UILabel *title = [CKJView5TopLabel new];
    [view5 addSubview:title];
    self.view5_topLabel = title;
    
    UILabel *subTitle = [CKJView5BottomLabel new];
    [view5 addSubview:subTitle];
    self.view5_bottomLabel = subTitle;
    
    [title setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [title setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [title setContentHuggingPriority:242 forAxis:UILayoutConstraintAxisVertical];
    [title setContentCompressionResistancePriority:742 forAxis:UILayoutConstraintAxisVertical];
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisVertical];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisVertical];
}

- (void)create_tfWrapperView {
    CKJTextFieldWrapperView *tfWrapperView = [CKJTextFieldWrapperView new];
    self.tfWrapperView = tfWrapperView;
    [self.subviews_SuperView addSubview:tfWrapperView];
}

- (void)create_67 {
    __weak typeof(self) weakSelf = self;
    
    CKJSwitchView *switchView6 = [[CKJSwitchView alloc] init];
    [switchView6.swicth addTarget:self action:@selector(swicthAction:) forControlEvents:UIControlEventValueChanged];
    [switchView6 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [switchView6 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.subviews_SuperView addSubview:switchView6];
    
    
    UILabel *alikePriceLabel61 = [CKJLikePriceLabel61 new];
    [self.subviews_SuperView addSubview:alikePriceLabel61];
    self.alikePriceLabel61 = alikePriceLabel61;
    [alikePriceLabel61 kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.equalTo(superview);
    }];

    CKJButton7 *btn7 = [CKJButton7 buttonWithType:UIButtonTypeCustom];
    [btn7 kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull _sender) {
        CKJCellModel *model = (CKJCellModel *)weakSelf.cellModel;
        if (model.btn7Model.didClickBtnHandle) {
            model.btn7Model.didClickBtnHandle(weakSelf, model.btn7Model);
        }
    }];
    [self.subviews_SuperView addSubview:btn7];
    
    self.kjSwitch6 = switchView6;
    self.btn7 = btn7;
}

- (void)origin_subTitle4_Constraint {
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    CKJSubTitle4Model *subTitle4Model = model.subTitle4Model;
    
    CGFloat subTitle4LeftMarign = subTitle4Model.leftMargin;
    
    NSAttributedString *subTitle4 = subTitle4Model.attributedText;
    _subTitle4.attributedText = WDKJ_ConfirmAttString(subTitle4);
    _subTitle4.userInteractionEnabled = subTitle4Model.enable;
    
    CGFloat topMargin = subTitle4Model.topMargin;
    CGFloat bottomMargin = subTitle4Model.bottomMargin;
    CGFloat rightMargin = subTitle4Model.rightMargin;
    
    // [subTitle4  btn5  View5  tfWrapperView  kjSwitch6  price61  btn7]
    
    [_subTitle4 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(subTitle4LeftMarign);
        make.top.equalTo(superview).offset(topMargin);
        make.bottom.equalTo(superview).offset(-(bottomMargin));
        make.right.equalTo(_btn5.mas_left).offset(-(rightMargin));
//        make.right.equalTo(_view5.mas_left).offset(-(rightMargin));
    }];
}

- (void)origin_btn5_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    CKJCellBtnModel *btn5Model = model.btn5Model;
    
    UIButton *btn5 = self.btn5;
    
    // [subTitle4  btn5  View5  tfWrapperView  kjSwitch6  price61  btn7]
    [CKJWorker reloadWithBtnModel:btn5Model btn:btn5 emptyHandle:^(CKJCellBtnModel * _Nonnull btnM) {
        
        [self.btn5 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.equalTo(superview);
            make.width.height.equalTo(@0);
            make.right.equalTo(self.view5.mas_left);
        }];
    } noEmptyHandle:^(CKJCellBtnModel * _Nonnull btnM) {
        
        [self.btn5 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.equalTo(superview).offset(btnM.centerYOffset);
            make.size.mas_equalTo(btnM.size);
            make.right.equalTo(self.view5.mas_left).offset(-(btnM.rightMargin));
        }];
    }];
}

- (void)origin_topBottomView_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    
    UILabel *title = _view5_topLabel;
    UILabel *subTitle = _view5_bottomLabel;
    
    UIEdgeInsets topEdge = model.view5Model.topLabelEdge;
    UIEdgeInsets bottomEdge = model.view5Model.bottomLabelEdge;
    
    title.attributedText = WDKJ_ConfirmAttString(model.view5Model.topText);
    subTitle.attributedText = WDKJ_ConfirmAttString(model.view5Model.bottomText);
    
    [title kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(superview).offset(topEdge.top);
        make.left.equalTo(superview).offset(topEdge.left);
        make.right.equalTo(superview).offset(-(topEdge.right));
        make.bottom.equalTo(superview.mas_centerY).offset(-(topEdge.bottom));
    }];
    [subTitle kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(superview.mas_centerY).offset(bottomEdge.top);
        make.left.equalTo(superview).offset(bottomEdge.left);
        make.right.equalTo(superview).offset(-(bottomEdge.right));
        make.bottom.equalTo(superview).offset(-(bottomEdge.bottom));
    }];
    
    title.textAlignment = model.view5Model.topLabelTextAlignment;
    subTitle.textAlignment = model.view5Model.bottomLabelTextAlignment;
}

- (void)update_tfWrapperView_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    
    CKJSwitch6Model *switch6Model = model.switch6Model;
    CGFloat left = switch6Model.left;
    
    [_tfWrapperView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.right.equalTo(self.kjSwitch6.mas_left).offset(-(left));
    }];
}
    
- (void)origin_switchView6_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    
    CKJSwitch6Model *switch6Model = model.switch6Model;
    // CGFloat left = switch6Model.left;
    CGFloat top = switch6Model.top;
    CGFloat bottom = switch6Model.bottom;
    
    // [subTitle4  btn5  View5  tfWrapperView  kjSwitch6  price61  btn7]
    
    if (switch6Model == nil) {
        _kjSwitch6.hidden = YES;
        [_kjSwitch6 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.top.bottom.equalTo(superview);
            make.width.equalTo(@0);
        }];
    } else {
        self.kjSwitch6.hidden = NO;
        
        [_kjSwitch6 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.top.equalTo(superview).offset(top);
            make.bottom.equalTo(superview).offset(-(bottom));
            make.width.equalTo(@60);
        }];
        ((CKJSwitchView *)self.kjSwitch6).swicth.on = switch6Model.switchOn;
    }
}

- (void)update_alikePriceLabel61_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    
    // [subTitle4  btn5  View5  tfWrapperView  kjSwitch6  price61  btn7]
    
    _alikePriceLabel61.attributedText = WDKJ_ConfirmAttString(model.likePrice61Model.attributedText);
    
    CGFloat left = model.likePrice61Model.leftMargin;
    CGFloat right = model.likePrice61Model.rightMargin;
    
    [_alikePriceLabel61 kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        MASViewAttribute *temp = _btn7.mas_left;
        
        make.left.equalTo(_kjSwitch6.mas_right).offset(left);
        make.right.equalTo(temp).offset(-(right));
    }];
}


- (void)origin_btn7_Constraint {
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    CKJCellBtnModel *btn7Model = model.btn7Model;
    
    UIButton *btn7 = self.btn7;
    
    [CKJWorker reloadWithBtnModel:btn7Model btn:btn7 emptyHandle:^(CKJCellBtnModel * _Nonnull btnM) {
        
        [self.btn7 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.right.equalTo(superview);
            make.width.equalTo(@0);
            make.right.equalTo(superview);
        }];
    } noEmptyHandle:^(CKJCellBtnModel * _Nonnull btnM) {
        
        [self.btn7 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.equalTo(superview).offset(btnM.centerYOffset);
            make.size.mas_equalTo(btnM.size);
            make.right.equalTo(superview).offset(-(btnM.rightMargin));
        }];
    }];
}

- (UIView *_Nonnull)tfWrapperView {
    return _tfWrapperView;
}


@end



