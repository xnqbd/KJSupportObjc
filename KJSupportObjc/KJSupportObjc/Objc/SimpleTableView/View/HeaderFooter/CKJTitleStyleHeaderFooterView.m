//
//  CKJTitleStyleTableViewHeaderFooterView.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/17.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CKJTitleStyleHeaderFooterView.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJSimpleTableView.h"

@implementation CKJTitleStyleHeaderFooterModel

+ (nonnull instancetype)modelWithAttributedString:(nullable NSAttributedString *)attributedString textAlignment:(NSTextAlignment)textAlignment type:(CKJCommonHeaderFooterType)type {
    CKJTitleStyleHeaderFooterModel *model = [[self alloc] init];
    model.attributedTitle = attributedString;
    model.textAlignment = textAlignment;
    model.type = type;
    return model;
}

@end


@interface CKJTitleStyleBGView : UIView

@end

@implementation CKJTitleStyleBGView

@end

@interface CKJTitleStyleHeaderFooterView ()

@property (strong, nonatomic) CKJTitleStyleBGView *bgV;

@end

@implementation CKJTitleStyleHeaderFooterView

- (void)setupSubViews {

    CKJTitleStyleBGView *bgV = ({
        CKJTitleStyleBGView *view = [CKJTitleStyleBGView new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view.superview);
        }];
        self.bgV = view;
    });

    self.customTitleLab = ({
        UILabel *view = [[UILabel alloc] init];
        view.numberOfLines = 0;
        view.textColor = [UIColor lightGrayColor];
        view.font = [UIFont systemFontOfSize:14];
        [bgV addSubview:view];
        UIEdgeInsets edge = UIEdgeInsetsMake(8, 10, 8, 10);
        if ([self.delegate respondsToSelector:@selector(return_TitleLabEdge)]) {
            edge = [self.delegate return_TitleLabEdge];
        }
        UIView *superV = view.superview;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superV.kjwdMas_safeAreaLeft).offset(edge.left);
            make.right.equalTo(superV.kjwdMas_safeAreaRight).offset(-(edge.right)).priority(900);
            make.top.equalTo(superV.kjwdMas_safeAreaTop).offset(edge.top);
            make.bottom.equalTo(superV.kjwdMas_safeAreaBottom).offset(-(edge.bottom)).priority(900);
        }];
        view;
    });
}


- (void)setupData:(CKJCommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(CKJSimpleTableView *)tableView {
    if (self.bgV.backgroundColor != tableView.backgroundColor) {
        self.bgV.backgroundColor = tableView.backgroundColor;
    }
    if ([headerFooterModel isKindOfClass:[CKJTitleStyleHeaderFooterModel class]]) {
        CKJTitleStyleHeaderFooterModel *model = (CKJTitleStyleHeaderFooterModel *)headerFooterModel;
        self.customTitleLab.attributedText = WDKJ_ConfirmAttString(model.attributedTitle);
        self.customTitleLab.textAlignment = model.textAlignment;
        if ([self.delegate respondsToSelector:@selector(setupCKJTitleStyleHeaderFooterView:label:bgV:data:section:tableView:)]) {
            [self.delegate setupCKJTitleStyleHeaderFooterView:self label:self.customTitleLab bgV:_bgV data:headerFooterModel section:section tableView:tableView];
        }
    }
}


@end
