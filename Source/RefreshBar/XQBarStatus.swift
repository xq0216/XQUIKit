//
//  XQRefreshBarStatus.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/7.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import Foundation
import UIKit

public enum XQBarStatus: Int {
    case unknown, refreshing, sucessed, failed

    func icon() -> UIImage? {
        var img: UIImage?
        switch self {
        case .refreshing:
            img = UIImage(imgNameInBundle: "ic_refresh")
        case .sucessed:
            img = UIImage(imgNameInBundle: "ic_sucessed")
        case .failed:
            img = UIImage(imgNameInBundle: "ic_refresh")
        default:
            img = nil
        }
        return img
    }

    func content() -> String {
        var str = ""
        switch self {
        case .refreshing:
            str = "正在努力更新数据..."
        case .sucessed:
            str = "已更新为最新数据"
        case .failed:
            str = "服务器开小差啦，请刷新重试"
        default:
            str = ""
        }
        return str
    }

    func bgColor() -> UIColor? {
        var color: UIColor?
        switch self {
        case .refreshing:
            color = UIColor(hexString: "F53E7B")
        case .sucessed:
            color = UIColor(hexString: "1FAF70")
        case .failed:
            color = UIColor(hexString: "F53E7B")
        default:
            color = nil
        }
        return color
    }
}
