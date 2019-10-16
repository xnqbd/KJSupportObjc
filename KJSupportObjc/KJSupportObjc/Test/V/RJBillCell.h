//
//  RJClinicTollBillCellTableViewCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

//"BillId":"34088769",
//"BillNumber":"",
//"BillStatus":2,
//"BillType":"药品",
//"AttendId":"4836480",
//"PatientId":"1707235892",
//"PatientName":"测试病人",
//"CardNum":"130001199101040",
//"CardType":"0",
//"BillDate":"20190410",
//"BillTime":"134135",
//"Total":42.32,
//"CreateTime":"2019-04-18 15:09:34",
//"UpdateTime":"2019-04-18 15:09:34",
//"Diagnosis":"",
//"DoctorWorkNum":"8866",
//"DoctorWorkName":"测试医生",
//"RegTypeName":"普通门诊",
//"DeptName":"东康复医学科门诊",
//"Position":null,
//"RegCode":"cd2",
//"HospitalId":"10002",
//"CFFlag":"0",
//"TreatPosition":"一楼7-9窗口a"


@interface RJBillCellConfig : CKJCommonCellConfig



@end




@interface RJBillCellModel : CKJCommonCellModel


/**
 科室
 */
@property (copy, nonatomic) NSString *DeptName;

@property (copy, nonatomic) NSString *BillDate;

/**
 账单编号
 */
@property (copy, nonatomic) NSString *BillId;

@property (copy, nonatomic) NSNumber *Total;



@end


NS_ASSUME_NONNULL_BEGIN

@interface RJBillCell : CKJCommonTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;


@end

NS_ASSUME_NONNULL_END
