//
//  XQContactManagerProtocol.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/20.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import Foundation
import UIKit

public typealias XQContactsSelectedHandler = (XQContactsModel) -> Void
public typealias XQContactsCancelHandler = () -> Void

public protocol XQContactsManagerProtocol {
    var selectedHandler: XQContactsSelectedHandler? {get set}
    var cancelHandler: XQContactsCancelHandler? {get set}
    // 初始化器
    init(selected: XQContactsSelectedHandler?, cancel:XQContactsCancelHandler?)
    // 显示界面
    func showPageOnTarget(viewController: UIViewController)
}
