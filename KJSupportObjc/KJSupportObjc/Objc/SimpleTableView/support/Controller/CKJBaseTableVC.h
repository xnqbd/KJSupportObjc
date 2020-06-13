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

 class RJInHospitalTransactVC: CKJBaseTableVC {
     
     override func simpleTableViewStyle() -> UITableView.Style {
         .plain
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         navigationItem.title = "入院办理";
         
         simpleTableView.updateStyle { (s) in
             s.rowHeight = NSNumber(value: 44)
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




#warning  注意: 继承于本来的子类， 需实现 CKJSimpleTableViewDataSource 协议
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
