//
//  CKJDemoCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"



@interface CKJDemoCell1Model : CKJCommonCellModel

@property (copy, nonatomic) NSString *image_Name;
@property (copy, nonatomic) NSString *image_URL;

@property (copy, nonatomic, nullable) NSAttributedString *title;
@property (copy, nonatomic, nullable) NSAttributedString *subTitle;
@property (copy, nonatomic, nullable) NSAttributedString *threeTitle;
@property (copy, nonatomic, nullable) NSAttributedString *fourTitle;
@property (copy, nonatomic, nullable) NSAttributedString *fiveTitle;


@end


@interface CKJDemoCell1 : CKJCommonTableViewCell

//@property (weak, nonatomic) IBOutlet UIImageView *imageV;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab;
//@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
//@property (weak, nonatomic) IBOutlet UILabel *threeLab;
//@property (weak, nonatomic) IBOutlet UILabel *fourLab;
//@property (weak, nonatomic) IBOutlet UILabel *fiveLab;


@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UILabel *subTitleLab;
@property (weak, nonatomic) UILabel *threeLab;
@property (weak, nonatomic) UILabel *fourLab;
@property (weak, nonatomic) UILabel *fiveLab;


@end


