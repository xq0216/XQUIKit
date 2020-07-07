//
//  CellDataModel.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/7.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import Foundation
import UIKit
import XQUIKit

struct CellData {
    var title: String
    var subTitle: String?
    var detailsClassName: String?

    init(_ title: String, subTitle: String?, details: String?) {
        self.title = title
        self.subTitle = subTitle
        self.detailsClassName = details
    }

    func detailsController() -> UIViewController? {
        guard let name = detailsClassName else { return nil }
        return UIViewController.creatFromString(name)
    }
}
