//
//  CKJCKJBaseTableVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJBaseViewController.h"
#import "CKJSimpleTableView.h"

NS_ASSUME_NONNULL_BEGIN



/*
 
 @interface WDMaxFailLoginVC ()

 @end

 @implementation WDMaxFailLoginVC

 - (UITableViewStyle)simpleTableViewStyle {
     return UITableViewStylePlain;
 }

 - (void)viewDidLoad {
     [super viewDidLoad];
     
     self.simpleTableView.backgroundColor = [UIColor whiteColor];
     [self.simpleTableView updateStyle:^(CKJSimpleTableViewStyle * _Nonnull s) {
         s.onlyViewEdge = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
         s.needUpdateOnlyViewConstraints = YES;
     }];
     
     CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
         
         CKJImageViewCellModel *model1 = [CKJImageViewCellModel imageViewWithCellHeight:@230 detailSettingBlock:^(__kindof CKJImageViewCellModel * _Nonnull m) {
             [m updateBGConfig:^(CKJCommonCellBGImageViewConfig * _Nonnull bg) {
                 bg.edge = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
             }];
             [m _showLine:NO];
             m.localImage = [UIImage kjwd_imageNamed:@"ic_Icon"];
         } updateConstraint:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
             make.size.mas_equalTo(CGSizeMake(100, 100));
             make.center.equalTo(superview);
         }];
         
         
         CKJInputCellModel* (^blo)(NSString *imagName, NSString *text) = ^CKJInputCellModel *(NSString *imagName, NSString *text){
             return [CKJInputCellModel inputWithCellHeight:@44 cellModel_id:nil detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull __weak m) {
                 [m _showLine:NO];
                 m.image2Model = [CKJImage2Model image2ModelWithImageString:imagName size:CGSizeMake(20, 20) left:12];
                 m.title3Model = [CKJTitle3Model title3ModelWithText:@"" left:10];
                 [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                     [tfModel _setText:text];
                 }];
                 [m updateBGConfig:^(CKJCommonCellBGImageViewConfig * _Nonnull bg) {
                     bg.radius = 22;
                     bg.bgColor = [UIColor kjwd_rbg:246 alpha:1];
                 }];
             }];
         };
         
         
         CKJInputCellModel *account = blo(@"ic_use", @"177");
         CKJEmptyCellModel *emp = [CKJEmptyCellModel emptyCellModelWithHeight:15 showLine:NO];
         
         CKJInputCellModel *pwd = blo(@"ic_lock", @"pwd");
         [pwd updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
             tfModel.secureTextEntry = YES;
         }];
         
         
         CKJOneBtnCellModel *commit = [CKJOneBtnCellModel oneBtnWithCellHeight:@100 title:@"下一步" detail:^(__kindof CKJOneBtnCellModel * _Nonnull m) {
             [m _showLine:NO];
             [m updateBGConfig:^(CKJCommonCellBGImageViewConfig * _Nonnull bg) {
                 bg.bgColor = self.simpleTableView.backgroundColor;
             }];
             [m updateBtnData:^(CKJBtnItemData * _Nonnull btnData) {
                 btnData.cornerRadius = 23;
                 btnData.normalBgImage = [UIImage kjwd_imageWithColor:[UIColor kjwd_blueBtnColor] size:CGSizeMake(300, 40)];
             }];
         } clickBtn:^(__kindof CKJOneBtnCellModel * _Nonnull cm, UIButton * _Nonnull btn) {
             NSLog(@"%@   ", @"点击提交");
         } updateConstraint:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
 //            make.height.equalTo(@50);
 //            make.edges.equalTo(superview).insets(UIEdgeInsetsMake(20, 30, 20, 30));
             make.size.mas_equalTo(CGSizeMake(180, 46));
             make.center.equalTo(superview);
         }];
         
         
         _sec.modelArray = @[model1, account, emp, pwd, commit];
     }];
     
     self.simpleTableView.dataArr = @[section1];
 }


 @end

 
 

 class RJInHospitalTransactVC: CKJBaseTableVC {
     
     override func simpleTableViewStyle() -> UITableView.Style {
         .plain
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         navigationItem.title = "入院办理";
         
         simpleTableView.updateStyle { (s) in
             s.rowHeight = 44
             s.lineEdge = UIEdgeInsets.zero as NSValue
         }
         
         let set = CKJGeneralSetting()
         set.image2_margin_title = 12;
         set.arrow9_margin_super = 12;
         
         
         let section1 = CKJCommonSectionModel.section { (_sec) in
             let model1 = RJStepCellModel.common(withCellHeight: NSNumber(value: 100), cellModel_id: nil, detailSettingBlock: nil, didSelectRowBlock: nil)
             let model2 = CKJGeneralCellModel.general(withTitle: "吕露露", likePriceAttText: "个人信息详情", setting: set, arrow: nil, didSelectRowBlock: nil)
             let model3 = CKJGeneralCellModel.general(withTitle: "入院申请单", likePriceAttText: "东测试", setting: set, arrow: nil, didSelectRowBlock: nil)
             _sec.modelArray = [model1, model2, model3]
         }
         
         
         simpleTableView.dataArr = [section1, section2]
     }
     
     override func returnCell_Model_keyValues(_ s: CKJSimpleTableView) -> [String : [String : Any]] {
         return [NSStringFromClass(RJStepCellModel.self) : [KJPrefix_cellKEY : NSStringFromClass(RJStepCell.self), KJPrefix_isRegisterNibKEY : true]]
     }
 }

 
 
 
 
 
 
 
 
 
 
 

CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
    
 
    
 
    _sec.modelArray = @[model1, model2, model3, model4];
}];

self.simpleTableView.dataArr = @[section1];


*/



@interface CKJBaseTableVC : CKJBaseViewController <CKJSimpleTableViewDataSource, CKJSimpleTableViewDelegate, TitleStyleHeaderFooterViewDelegate>


@property (strong, nonatomic) IBOutlet CKJSimpleTableView *simpleTableView;
- (UITableViewStyle)simpleTableViewStyle;

/**
 CKJSimpleTableView的约束或者 frame
 */
- (void)layoutTableViewFrame:(CKJSimpleTableView *)tableV;

- (void)initSimpleTableViewData;


/// 添加尾视图
- (void)createFooterViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender, __kindof CKJBaseTableVC *se, CKJSimpleTableView *simpleTableView))clickHandle;


@end

NS_ASSUME_NONNULL_END
