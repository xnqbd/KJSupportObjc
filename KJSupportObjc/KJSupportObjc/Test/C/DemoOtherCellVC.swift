//
//  DemoOtherCell.swift
//  MobileHospital_Renji
//
//  Created by admin2 on 2020/6/13.
//  Copyright © 2020 Lyc. All rights reserved.
//

import UIKit

class DemoOtherCellVC: CKJBaseTableVC {
    
    override func layoutTableViewFrame(_ tableV: CKJSimpleTableView) {
        tableV.kjwd_mas_makeConstraints { (make, superView) in
            make.edges.equalTo()(superView)?.with()?.insets()(UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20))
        }
    }
    
    override func simpleTableViewStyle() -> UITableView.Style {
        .plain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        simpleTableView.backgroundColor = view.backgroundColor
        simpleTableView.updateStyle { (s) in
            s.haveTitleStyle.left = 0
            s.rowHeight = NSNumber(40)
            s.tfStyle_Right = 0
        }
        
        let section1 = CKJCommonSectionModel.section { (_sec: CKJCommonSectionModel) in
            let logo = CKJImageViewCellModel.imageView(withCellHeight: NSNumber(value: 132), detailSettingBlock: { (m) in
                m.localImage = UIImage.kjwd_imageNamed("dy_logo")
                m._showLine(false)
            }) { (make, superView) in
                make.center.equalTo()(superView)
                make.size.equalTo()(CGSize(width: 120, height: 120))
            }
            let phone = self.simpleTableView._newtitle(nil, tfText: "12345678901", placeholder: "手机号码", emptyRequirdText: "手机号", cellId: kOInput_Phone, detail: { (m) in
                m.lineEdge = NSValue(uiEdgeInsets: UIEdgeInsets.zero)
                m.addRequired(CKJInputExpressionRequiredModel.system_phoneRegError())
            })
            
            let pwd = self.simpleTableView._newtitle(nil, tfText: "123456", placeholder: "密码", emptyRequirdText: "密码", cellId: kOInput_Pwd) {(m) in
                m.lineEdge = NSValue(uiEdgeInsets: UIEdgeInsets.zero)
            }
            
            let empty1 = CKJEmptyCellModel(height: 10, showLine: false)
            
            
            let login = CKJOneBtnCellModel.oneBtnFillStyle(withCellHeight: NSNumber(value: 46), title: "登录", radius: NSNumber(value: 4), bgColor: UIColor.kjwd_blueBtn(), detail: { (m) in
                
            }, clickBtn: {(m, btn) in
                print("点击 登录")
            }) { (make, superView) in
                make.edges.equalTo()
            }
            
            let leftRight = CKJTwoBtnCellModel.twoBtn(withCellHeight: NSNumber(value: 50), leftTitle: "忘记密码", leftHandle: { (btn, data) in
                print("点击 忘记密码")
            }, rightTitle: "注册", rightHandle: { (btn, data) in
                print("点击 注册")
            }, fontSize: nil, textColor: nil) { m in
                m._showLine(false)
            }
            
            
            _sec.modelArray = [logo, phone, pwd, empty1, login, leftRight]
        }
        
        simpleTableView.dataArr = [section1]
    }
    
}
