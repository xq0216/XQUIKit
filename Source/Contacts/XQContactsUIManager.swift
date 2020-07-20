//
//  XQContactUIManager.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/20.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit
import ContactsUI

/// >= iOS9，使用ContactsUI调用系统通讯录UI选择获取联系人信息
class XQContactsUIManager: NSObject, XQContactsManagerProtocol {
    private let contactPicker: CNContactPickerViewController
    // 遵循协议申明handler
    var selectedHandler: XQContactsSelectedHandler?
    var cancelHandler: XQContactsCancelHandler?
    // 遵循协议实现构造器
    required init(selected: XQContactsSelectedHandler?, cancel:XQContactsCancelHandler?){
        selectedHandler = selected
        cancelHandler = cancel
        contactPicker = CNContactPickerViewController.init()
        super.init()
        // TODO: 目前选中联系人进入详情，无法选中联系人返回
        contactPicker.predicateForSelectionOfContact = NSPredicate(value: true)
        contactPicker.delegate = self
    }

    // 显示界面
    func showPageOnTarget(viewController: UIViewController){
        viewController.present(contactPicker, animated: true, completion: nil)
    }
}

extension XQContactsUIManager:CNContactPickerDelegate {
    // 取消选择
    func contactPickerDidCancel(_ picker: CNContactPickerViewController){
        cancelHandler?()
    }
    // 选中一个联系人
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact){

        // 电话
        let phoneNumbers:[XQContactsItem] = contact.phoneNumbers.map { (labelValue: CNLabeledValue) -> XQContactsItem in
            let title = labelValue.label
            var value: String?
            let str: String = labelValue.value.stringValue
            if str.count > 0 {
                value = str.replacingOccurrences(of: "-", with: "")
                value = value?.replacingOccurrences(of: " ", with: "")
            }
            return XQContactsItem.init(title: title, value: value)
        }

        // 邮箱
        let emails:[XQContactsItem] = contact.emailAddresses.map { (labelValue) -> XQContactsItem in
            let title = labelValue.label
//            var value = labelValue.value.stringValue
            return XQContactsItem.init(title: title, value: nil)
        }

        let model = XQContactsModel.init(familyName: contact.familyName,
                                         givenName: contact.givenName,
                                         company: contact.organizationName,
                                         phoneNumbers: phoneNumbers,
                                         emails: emails)
        selectedHandler?(model)
    }
}
