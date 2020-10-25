//
// CKJCommonTableViewCell.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJCommonTableViewCell.h"
#import "CKJSimpleTableView.h"
#import "NSObject+WDYHFCategory.h"
#import <Masonry/Masonry.h>



@interface CKJCommonCellOnlyView : UIView
@end
@implementation CKJCommonCellOnlyView
@end






@implementation CKJCommonCellConfig

+ (instancetype)cellConfigWithDetail:(nullable CKJCommonCellConfigBlock)detailSettingBlock {
    return [super configWithDetail:detailSettingBlock];
}

@end


@interface CKJCommonTableViewCell ()




@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;

@property (weak, nonatomic) CKJSimpleTableView *simpleTableView;
@property (weak, nonatomic) CKJCommonSectionModel *sectionModel;

@end

@implementation CKJCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configDic:(NSDictionary *)configDic {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.readOnly_configDic = configDic;
        [self kjInit];

        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self kjInit];
    }
    return self;
}

- (void)kjInit {
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *onlyView = [[CKJCommonCellOnlyView alloc] init];
    [self.contentView insertSubview:onlyView atIndex:0];
    [onlyView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
//        make.center.equalTo(superview);
//        make.width.equalTo(superview).priority(900);
//        make.height.equalTo(superview).priority(900);
#warning 如果这里变了，在setupData也要更新约束
        make.left.equalTo(superview).offset(0);
        make.right.equalTo(superview).offset(0).priority(900);
        make.top.equalTo(superview).offset(0);
        make.bottom.equalTo(superview).offset(0).priority(900);
    }];
    self.onlyView = onlyView;
    self.subviews_SuperView = onlyView;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.contentView insertSubview:imageV atIndex:0];
    self.bgImageView = imageV;
    
    [imageV kjwd_mas_makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.left.right.top.bottom.equalTo(onlyView);
    }];
    
    

    CAShapeLayer *layer = [CAShapeLayer layer];
//    [self.contentView.layer insertSublayer:layer atIndex:0];

    [self.contentView.subviews[0].layer insertSublayer:layer atIndex:0];

    self.cornerLayer = layer;
}

- (void)setupSubViews {
//    NSLog(@"父类的 setupSubViews，   真实 %@ ", self);
}
-(nonnull CKJSimpleTableView *)simpleTableView {
    return _simpleTableView;
}

- (nonnull __kindof CKJCommonSectionModel *)sectionModel {
    return _sectionModel;
}
- (CKJCommonCellConfig *)configModel {
    return self.readOnly_configDic[KJPrefix_configDicKEY_ConfigModel];
}

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
}

- (void)_privateMethodWithSimpleTableView:(nonnull CKJSimpleTableView *)tabV sectionModel:(CKJCommonSectionModel *)sectionModel section:(NSInteger)section row:(NSInteger)row cell:(CKJCommonTableViewCell *)cell model:(CKJCommonCellModel *)model {
    if (self.simpleTableView != tabV) {
        self.simpleTableView = tabV;
    }
    if (self.sectionModel != sectionModel) {
        self.sectionModel = sectionModel;
    }
    if (self.section != section) {
        self.section = section;
    }
    if (self.row != row) {
        self.row = row;
    }
    
    
    CKJCommonCellBGImageViewConfig *bgConfig = nil;
    if (model.cellBGConfig) {
        bgConfig = model.cellBGConfig;
    } else if (sectionModel.cellBGConfig) {
        bgConfig = sectionModel.cellBGConfig;
    } else {
        bgConfig = tabV.simpleStyle.cellBGConfig;
    }
    
    
    
    // 背景
    if (cell.bgImageView.backgroundColor != bgConfig.bgColor) {
        cell.bgImageView.backgroundColor = bgConfig.bgColor;
    }
    if (cell.bgImageView.image != bgConfig.image) {
        cell.bgImageView.image = bgConfig.image;
    }
    if (cell.bgImageView.contentMode != bgConfig.contentMode) {
        cell.bgImageView.contentMode = bgConfig.contentMode;
    }
    if (cell.bgImageView.layer.cornerRadius != bgConfig.radius) {
        cell.bgImageView.layer.cornerRadius = bgConfig.radius;
    }
    
    
    CKJSimpleTableViewStyle *simpleStyle = self.simpleTableView.simpleStyle;
    
    if (simpleStyle.needUpdateOnlyViewConstraints) {
        UIEdgeInsets edge = UIEdgeInsetsZero;
        
        if (bgConfig.edge) {
            edge = bgConfig.edge.UIEdgeInsetsValue;
        } else if (simpleStyle.onlyViewEdge) {
            edge = simpleStyle.onlyViewEdge.UIEdgeInsetsValue;
        }

        [cell.onlyView kjwd_mas_updateConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.left.equalTo(superview).offset(edge.left);
            make.right.equalTo(superview).offset(-(edge.right)).priority(900);
            make.top.equalTo(superview).offset(edge.top);
            make.bottom.equalTo(superview).offset(-(edge.bottom)).priority(900);
        }];
    }
}



- (NSArray <__kindof CKJCommonCellModel *>*)currentSectionAllCellModelArray {
    NSArray <CKJCommonSectionModel *>* dataArr = self.simpleTableView.dataArr;
    NSArray <CKJCommonCellModel *>*modelArray = [dataArr kjwd_objectAtIndex:self.section].modelArray;
    return modelArray;
}


@end

