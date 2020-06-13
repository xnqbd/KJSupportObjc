//
//  RJSelectDateCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/12.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "SelectDateCell.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJHUD+KJSupport.h"

@implementation SelectDateCellConfig

- (instancetype)init {
    if (self = [super init]) {
        self.endDateUserInteractionEnabled = YES;
    }
    return self;
}

@end



@implementation SelectDateCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end


@interface SelectDateCell ()

@property (weak, nonatomic) UIButton *beginDateBtn;
@property (weak, nonatomic) UIButton *endDateBtn;


@end

@implementation SelectDateCell

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    
}

- (void)setupSubViews {
    [super setupSubViews];
    
    self.subviews_SuperView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    SelectDateCellConfig *config = self.readOnly_configDic[KJPrefix_configDicKEY_ConfigModel];
    
    
    UIImage *image = [[UIImage imageNamed:@"person_date"] kjwd_scaleToSize:CGSizeMake(20, 20)];
    UIButton *(^block)(NSString *date) = ^UIButton *(NSString *date){
        date = WDKJ_ConfirmString(date);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(dateAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor kjwd_title] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:date forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self.subviews_SuperView addSubview:btn];
        return btn;
    };
    
    
    UILabel *lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"-";
    [self.subviews_SuperView addSubview:lab];
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    [search addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [search setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    
    [self.subviews_SuperView addSubview:search];
    
    
    self.beginDateBtn = block(config.beginDate);
    self.endDateBtn = block(config.endDate);
    self.endDateBtn.userInteractionEnabled = config.endDateUserInteractionEnabled;
    if (self.endDateBtn.userInteractionEnabled == NO) {
        self.endDateBtn.backgroundColor = [UIColor clearColor];
    }
    
    
    [self.beginDateBtn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(7.3);
        make.centerY.equalTo(superview);
        make.height.equalTo(@30);
        make.height.width.equalTo(self.endDateBtn);
    }];
    [lab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.beginDateBtn.mas_right).offset(5);
        make.right.equalTo(self.endDateBtn.mas_left).offset(-5);
        make.centerY.equalTo(self.beginDateBtn);
        make.width.equalTo(@10);
    }];
    
    [self.endDateBtn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(self.beginDateBtn);
        make.right.equalTo(search.mas_left).offset(-10);
    }];
    
    [search kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(self.beginDateBtn);
        make.width.height.equalTo(@25);
        make.right.equalTo(superview).offset(-10);
    }];
}

- (void)dateAction:(UIButton *)sender {
    NSLog(@"弹框选择日期");
}
- (void)searchAction:(UIButton *)sender {
    NSString *startDate = self.beginDateBtn.titleLabel.text;
    NSString *endDate   = self.endDateBtn.titleLabel.text;
    if (!startDate.length) {
        NSLog(@"请输入开始日期");
        [CKJHUD kjwd_showMessage:@"请输入开始日期"];
        return;
    }
    if (!endDate.length) {
        NSLog(@"请输入结束日期");
        [CKJHUD kjwd_showMessage:@"请输入结束日期"];
        return;
    }
    if (startDate.longLongValue > endDate.longLongValue) {
        NSLog(@"开始时间不能大于结束时间");
        [CKJHUD kjwd_showMessage:@"开始时间不能大于结束时间"];
        return;
    }
   NSLog(@"得到日期");
}


@end
