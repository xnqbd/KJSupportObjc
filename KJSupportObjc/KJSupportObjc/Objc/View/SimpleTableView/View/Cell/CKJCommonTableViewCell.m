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


@implementation CKJCommonCellConfig

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJCommonCellConfigBlock)detailSettingBlock {
    CKJCommonCellConfig *config = [[self alloc] init];
    if (detailSettingBlock) {
        detailSettingBlock(config);
    }
    return config;
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
        self.configDic = configDic;
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
    UIView *bgV = [[UIView alloc] init];
    [self.contentView insertSubview:bgV atIndex:0];
    [bgV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.center.mas_equalTo(superview);
        make.width.equalTo(superview).priority(900);
        make.height.equalTo(superview).priority(900);
    }];
    self.bgV = bgV;
}

- (void)setupSubViews {
    
}

- (CKJCommonCellConfig *)configModel {
    return self.configDic[configDicKEY_ConfigModel];
}


- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
}

- (void)_privateMethodWithSimpleTableView:(nonnull CKJSimpleTableView *)tabV sectionModel:(CKJCommonSectionModel *)sectionModel section:(NSInteger)section row:(NSInteger)row {
    self.simpleTableView = tabV;
    self.sectionModel = sectionModel;
    self.section = section;
    self.row = row;
}



- (NSArray <__kindof CKJCommonCellModel *>*)currentSectionAllCellModelArray {
    NSArray <CKJCommonSectionModel *>* dataArr = self.simpleTableView.dataArr;
    NSArray <CKJCommonCellModel *>*modelArray = [dataArr kjwd_objectAtIndex:self.section].modelArray;
    return modelArray;
}


@end

