//
//  XQContactsManager.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/20.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit

public class XQContactsManager: NSObject {
     public func showContactsPage(_ parentViewController: UIViewController,
                                 selected: XQContactsSelectedHandler?,
                                 cancel:XQContactsCancelHandler?){
//        var controller:<T: XQContactsManagerProtocol>?
        // >= 9.0
        if #available(iOS 9.0, *) {
            let controller = XQContactsUIManager.init(selected: selected, cancel: cancel)
            controller.showPageOnTarget(viewController: parentViewController)
        }
    }
}
