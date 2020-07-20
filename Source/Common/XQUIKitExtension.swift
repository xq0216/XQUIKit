//
//  XQExtension.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/7.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(imgNameInBundle name: String) {
        guard let path = Bundle(for: XQRefreshBar.self).resourcePath,
            let bundle = Bundle(path: path+"/XQUIKit.bundle") else {
            return nil
        }
        self.init(named: name, in: bundle, compatibleWith: nil)
    }

}
