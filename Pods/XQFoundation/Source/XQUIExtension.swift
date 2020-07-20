//
//  XQUIExtension.swift
//  XQFoundation
//
//  Created by LaiXuefei on 2020/7/13.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit

public extension UIDevice {
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let versionCode: Int = Bundle.main.infoDictionary?["VersionCode"] as? Int ?? 0
}

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

public extension UIView{
    func corner(radius:Float, borderWidth:Float, borderColor:UIColor?) -> Void {
        if radius>0.0 {
            self.layer.cornerRadius = CGFloat(radius)
        }
        if borderWidth>0.0 {
            self.layer.borderWidth = CGFloat(borderWidth)
            self.layer.borderColor = borderColor?.cgColor
        }
        self.clipsToBounds = true
    }

    // 旋转
    func startRepeatRotate(key: String) -> Bool {
        guard !key.isEmpty else {return false}
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: key)
        return true
    }
    func stopRepeatRotate(key: String) -> Bool {
        guard !key.isEmpty else {return false}
        self.layer.removeAnimation(forKey: key)
        return true
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

    func set(title: String?) {
        let img = self.imageView?.image
        self.set(img: img, title: title)
    }

    func set(title: String?, color: UIColor?) {
        self.set(title: title)
        if let aColor = color {
            self.setTitleColor(aColor, for: .normal)
        }
    }

    func set(title: String?, color: UIColor?, font: UIFont) {
        self.set(title: title, color: color)
        titleLabel?.font = font
    }

    func set(img: UIImage?, title: String?) {
        self.set(img: img, title: title, for: .normal)
    }

    func set(img: UIImage?, title: String?, for state: UIControl.State) {
        self.setTitle(title, for: state)
        self.setImage(img, for: state)
    }

    func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing
        if self.imageView?.image != nil, let text = titleLabel?.text, !text.isEmpty {
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -edgeOffset,
                                           bottom: 0,
                                           right: edgeOffset)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: edgeOffset,
                                           bottom: 0,
                                           right: -edgeOffset)
        }
        if !imageFirst {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
            imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        // update contentEdgeInsets to change btn bounds
        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
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
