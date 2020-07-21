//
//  XQContactsManager.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/20.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit
import ContactsUI

public class XQContactsManager: NSObject {
    lazy var manager: XQContactsUIManager = {
        return XQContactsUIManager()
    }()
    // 单例
    public static let shared = XQContactsManager()
    // 私有化构造方法，不允许外界创建实例
    private override init() {
        // 进行初始化工作
    }
    // 显示界面
    public func showPageOnTarget(_ viewController: UIViewController, selected: XQContactsSelectedHandler?, cancel:XQContactsCancelHandler?){
        manager.showPageOnTarget(viewController, selected: selected, cancel: cancel)
    }
}
