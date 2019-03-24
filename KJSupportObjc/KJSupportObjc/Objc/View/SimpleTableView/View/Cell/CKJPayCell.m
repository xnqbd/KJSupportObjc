//
//  CKJPayCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/24.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CKJPayCell.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJSimpleTableView.h"

@implementation CKJPayCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

@implementation CKJPayCell

- (void)installData:(CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    self.imageV.image = [UIImage kjwd_imageNamed:model.image_Name];
    self.chooseBtn.selected = model.chooseBtn_Selected;
}

- (void)setupSubViews {
    [super setupSubViews];
    
    
    [self.chooseBtn  setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisHorizontal];
    [self.chooseBtn  setContentCompressionResistancePriority:755 forAxis:UILayoutConstraintAxisHorizontal];
    
    CGSize size = CGSizeMake(25, 25);
    
    UIImage *image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选空"] kjwd_scaleToSize:size];
    UIImage *select_image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选"] kjwd_scaleToSize:size];
    
    
    [self.chooseBtn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.top.bottom.equalTo(superview);
        make.right.equalTo(superview).offset(-10);
    }];
    
    [self.chooseBtn setImage:image forState:UIControlStateNormal];
    [self.chooseBtn setImage:select_image forState:UIControlStateSelected];
}

- (void)chooseBtnAction {
    NSMutableArray <NSIndexPath *>*array = [NSMutableArray array];
    
    [self.simpleTableView.payCellModels enumerateObjectsUsingBlock:^(__kindof CKJPayCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.chooseBtn_Selected = NO;
        [array addObject:[NSIndexPath indexPathForRow:obj.cell.row inSection:obj.cell.section]];
    }];
    
    self.cellModel.chooseBtn_Selected = YES;

    WDCKJdispatch_async_main_queue(^{
        [UIView performWithoutAnimation:^{
            [self.simpleTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
        }];
    });
}




@end
