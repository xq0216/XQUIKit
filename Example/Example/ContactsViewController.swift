//
//  ContactsViewController.swift
//  Example
//
//  Created by LaiXuefei on 2020/7/20.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit
import SnapKit
import XQUIKit

class ContactsViewController: UIViewController {

    lazy var contentLabel: UILabel = {
        return UILabel.init()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = .green
        btn.setTitle("选择联系人", for: .normal)
        btn.addEvent { (aBtn) in
            let manager:XQContactsManager = XQContactsManager.init()
            manager.showContactsPage(self, selected: {[weak self] (model) in
                self?.contentLabel.text = model.familyName
//                print(model.familyName)
            }) {
                 print("cancel")
            }
        }
        view.addSubview(btn)
        btn.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(80)
            maker.leading.greaterThanOrEqualToSuperview().offset(20)
            maker.height.equalTo(44)
        }

        view.addSubview(contentLabel)
        contentLabel.backgroundColor = .orange
        contentLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.top.equalTo(btn.snp_bottomMargin).offset(20)
        }
        view.layoutIfNeeded()


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
