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
import ContactsUI

class ContactsViewController: UIViewController, CNContactPickerDelegate {
    lazy var contentLabel: UILabel = {
        return UILabel.init()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = .blue
        btn.setTitle("选择联系人", for: .normal)
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
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

    @objc func clickBtn() {
        // 弹出系统联系人界面
        XQContactsManager.shared.showPageOnTarget(self, selected: {[weak self] (model) in
                self?.contentLabel.text = model.familyName
            }) {
                 print("xq-cancel")
            }
    }
}
