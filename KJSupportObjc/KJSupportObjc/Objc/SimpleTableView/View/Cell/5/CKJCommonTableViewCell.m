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

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJCommonCellConfigBlock)detailSettingBlock {
    return [super configWithDetailSettingBlock:detailSettingBlock];
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
    UIView *onlyView = [[CKJCommonCellOnlyView alloc] init];
    [self.contentView insertSubview:onlyView atIndex:0];
    [onlyView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.center.equalTo(superview);
        make.width.equalTo(superview).priority(900);
        make.height.equalTo(superview).priority(900);
    }];
    self.onlyView = onlyView;
    self.subviews_SuperView = onlyView;
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
    return self.configDic[configDicKEY_ConfigModel];
}


- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
}

- (void)_privateMethodWithSimpleTableView:(nonnull CKJSimpleTableView *)tabV sectionModel:(CKJCommonSectionModel *)sectionModel section:(NSInteger)section row:(NSInteger)row {
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
}



- (NSArray <__kindof CKJCommonCellModel *>*)currentSectionAllCellModelArray {
    NSArray <CKJCommonSectionModel *>* dataArr = self.simpleTableView.dataArr;
    NSArray <CKJCommonCellModel *>*modelArray = [dataArr kjwd_objectAtIndex:self.section].modelArray;
    return modelArray;
}


@end

