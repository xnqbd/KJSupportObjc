//
//  CKJInputCustomSuperCell.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/24.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJInputCustomSuperCell.h"
#import "CKJLibraryHelper.h"

@implementation CKJInputCustomSuperCellModel


- (void)addRequired:(CKJInputExpressionRequiredModel *)model {
    if (WDKJ_IsNullObj(model, [CKJInputExpressionRequiredModel class])) return;
    NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.expressionRequiredArray];
    [arr addObject:model];
    self.expressionRequiredArray = arr;
}

- (void)updateTFModel:(void(^_Nullable)(CKJTFModel *_Nonnull tfModel))block {
    if (block && _tfModel) {
        block(_tfModel);
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tfModel = [[CKJTFModel alloc] init];
    }
    return self;
}

@end

@implementation CKJInputCustomSuperCell

- (void)setupData:(CKJInputCustomSuperCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJInputCustomSuperCellModel class]] == NO) return;
    
    [CKJLibraryHelper commomCode1WithTFModel:model.tfModel tf:self.tf];
}

- (void)setupSubViews {
    [super setupSubViews];
    [self changeTFDelegate];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self changeTFDelegate];
}

- (void)changeTFDelegate {
    [self.tf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEditingEvents];
}

// 监听文字改变
- (void)textChange:(UITextField *)tf {
    CKJInputCustomSuperCellModel *_model = (CKJInputCustomSuperCellModel *)self.cellModel;
    CKJTFModel *tfModel = _model.tfModel;
    [CKJLibraryHelper commomCode2WithTFModel:tfModel tf:self.tf];
}


@end
