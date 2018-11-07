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

@implementation CKJCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configDic:(NSDictionary *)configDic {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setValue:configDic forKey:@"configDic"];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
}

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
}

- (NSArray <CKJCommonCellModel *>*)currentSectionCellModelArray {
    NSArray <CKJCommonSectionModel *>* dataArr = self.simpleTableView.dataArr;
    NSArray <CKJCommonCellModel *>*modelArray = [dataArr kjwd_objectAtIndex:self.section].modelArray;
    return modelArray;
}

//- (void)addSubview:(UIView *)view {
////    static int a = 0;
////    if (a == 0) {
////        if ([view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]]) {
////            NSLog(@"找到了 %@ ", view);
////            a++;
////            return;
////        }
////    }
//
//    [super addSubview:view];
//}



@end


