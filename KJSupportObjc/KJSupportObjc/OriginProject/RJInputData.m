//
//  RJInputData.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJInputData.h"
#import "CKJSimpleTableView.h"

@implementation RJInputData

- (instancetype)initWithSimpleTableView:(CKJSimpleTableView *)simpleTableView {
    if (self = [super initWithSimpleTableView:simpleTableView]) {
        
        // 监护人姓名
        NSString *_jianhuPersonName = [simpleTableView inputCellModelOfID:JianHuPersonName].getTfText;
        
        // 监护人身份证号
        NSString *_jianHuPersonidCardNumber = [simpleTableView inputCellModelOfID:JianHuPersonidCardNumber].getTfText;
        
        self.Guardian = _jianhuPersonName;
        self.GuardianIdCardNo = _jianHuPersonidCardNumber;
    }
    return self;
}


@end
