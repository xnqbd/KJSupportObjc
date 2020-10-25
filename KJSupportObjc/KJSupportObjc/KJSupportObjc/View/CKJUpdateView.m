//
//  CKJUpdateView.m
//  MobileManage
//
//  Created by admin2 on 2020/9/11.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJUpdateView.h"


@implementation CKJUpdateModel


@end



@interface CKJUpdateView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIView *vLineV;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) CKJUpdateViewTapUpdate tapUpdate;

@property (strong, nonatomic) CKJUpdateModel *model;

@end


@implementation CKJUpdateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.2];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.lineV];
    [self.bgView addSubview:self.cancleButton];
    [self.bgView addSubview:self.confirmButton];
    [self.bgView addSubview:self.vLineV];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
//        make.height.mas_equalTo(200);
        make.center.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(10);
        make.height.mas_equalTo(30);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
    }];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(1);
    }];
    
    if (_model.isMustUpdate) {
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineV.mas_bottom).offset(0);
            make.right.bottom.width.equalTo(self.bgView);
            make.height.mas_equalTo(49);
        }];
    } else {
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineV.mas_bottom).offset(0);
            make.left.bottom.equalTo(self.bgView);
            make.width.mas_equalTo(([UIScreen mainScreen].bounds.size.width - 40) / 2);
            make.height.mas_equalTo(45);
        }];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.bgView);
            make.width.height.mas_equalTo(self.cancleButton);
        }];
        [self.vLineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineV.mas_bottom);
            make.bottom.equalTo(self.bgView);
            make.width.mas_equalTo(1);
            make.centerX.equalTo(self.bgView);
        }];
    }
}

#pragma mark - buttonAction
- (void)cancel:(UIButton *)sender {
    [self exeRemoveAction];
}

- (void)updateAction:(UIButton *)sender {
    if (self.tapUpdate) {
        self.tapUpdate(self);
    }
}

#pragma mark - 从父视图上面移除
- (void)exeRemoveAction {
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self) {
            [self removeFromSuperview];
        }
    }];
}



- (void)showUpdateView:(CKJUpdateModel *)model tapUpdate:(CKJUpdateViewTapUpdate)tapUpdate {
    self.tapUpdate = tapUpdate;
    self.model = model;
    self.frame = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 1;
        self.contentLabel.text = [NSString stringWithFormat:@"%@", model.content];
    }];
}


#pragma mark - lazy loading

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 8;
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"版本更新";
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"我是更新的内容";
        _contentLabel.textColor = [UIColor kjwd_rbg:145 alpha:1];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = [UIColor kjwd_rbg:230 alpha:1];
    }
    return _lineV;
}

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"我知道了" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancleButton.tag = 1001;
        [_cancleButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UIView *)vLineV {
    if (!_vLineV) {
        _vLineV = [[UIView alloc] init];
        _vLineV.backgroundColor = [UIColor kjwd_rbg:230 alpha:1];
    }
    return _vLineV;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"更新" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _confirmButton.tag = 1002;
        [_confirmButton addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}





@end
