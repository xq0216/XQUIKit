//
//  XQExtension.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/7.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    /** 通过名字创建对象
    *     Swift中根据字符串转换的方法需要加上YourAppName,格式为”YouAPPName.类名”
    */
    static func creatFromString(_ className: String) -> UIViewController? {
        guard !className.isEmpty else { return nil }
        guard let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String, !className.isEmpty else {
            return nil
        }
        // 拼接完整的控制器名
        let totalName = "\(appName).\(className)"
        // 将控制名转换为类
        guard let type = NSClassFromString(totalName) as? UIViewController.Type else {
            return nil
        }
        return type.init()
    }
}

public typealias ButtonEventBlock = (_ button: UIButton) -> Void
private var kButtonEventBlockKey: String = "ButtonEventBlockKey"
public extension UIButton {

    // 通过block添加点击事件
    var eventBlock: ButtonEventBlock? {
        get {
            return (objc_getAssociatedObject(self, &kButtonEventBlockKey)) as? ButtonEventBlock
        }
        set {
            objc_setAssociatedObject(self, &kButtonEventBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    func addEvent(_ block: @escaping ButtonEventBlock) {
        eventBlock = block
        self.addTarget(self, action: #selector(buttonDidClick(_:)), for: .touchUpInside)
    }

    func removeEvent(){
        guard eventBlock != nil else {
            return
        }
        eventBlock = nil
        self.removeTarget(self, action: #selector(buttonDidClick(_:)), for: .touchUpInside)
    }

    @objc func buttonDidClick(_ button: UIButton) {
        eventBlock?(button)
    }
}

public extension NSObject {
    // 延迟执行及取消
    typealias Task = (_ cancel : Bool) -> Void
    func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {

        func dispatch_later(block: @escaping ()->()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        var closure: (()->Void)? = task
        var result: Task?

        let delayedClosure: Task = {
            cancel in
          if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }

        result = delayedClosure

        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
      return result
    }

    func cancel(_ task: Task?) {
        task?(true)
    }

}

public extension UIColor {
    convenience init(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }

    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

public enum UIImageType: String {
    case PNG = "png"
    case JPG = "jpg"
    case JPEG = "jpeg"
}



private let kRotationAnimationKey: String = "XQUIKit_rotationAnimation"
public extension UIView{
    func startRotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: kRotationAnimationKey)
    }
    func stopRotate() {
        self.layer.removeAnimation(forKey: kRotationAnimationKey)
    }
}

// MARK: XQUIKit 独有
extension UIImage {
    convenience init?(imgNameInBundle name: String) {
        guard let path = Bundle(for: XQRefreshBar.self).resourcePath,
            let bundle = Bundle(path: path+"/XQUIKit.bundle") else {
            return nil
        }
        self.init(named: name, in: bundle, compatibleWith: nil)
    }

}
