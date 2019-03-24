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


@interface CKJCommonTableViewCell ()

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;

@property (weak, nonatomic) CKJSimpleTableView *simpleTableView;
@property (weak, nonatomic) CKJCommonSectionModel *sectionModel;

@end

@implementation CKJCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configDic:(NSDictionary *)configDic {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setValue:configDic forKey:@"configDic"];
        self.bgV = ({
            UIView *bgV = [[UIView alloc] init];
            [self.contentView addSubview:bgV];
            [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.contentView);
                make.width.equalTo(self.contentView).priority(800);
                make.height.equalTo(self.contentView).priority(800);
            }];
            bgV;
        });
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
}

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
}

- (void)_privateMethodWithSimpleTableView:(CKJSimpleTableView *)tabV sectionModel:(CKJCommonSectionModel *)sectionModel section:(NSInteger)section row:(NSInteger)row {
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


