//
//  XQContactModel.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/20.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit

public struct XQContactsItem {
    /// 通讯录前面的title，比如"手机"，"工作"，"主要"。。
    public var title: String?
    /// 手机号码，或者邮箱
    public var value: String?
}
public struct XQContactsModel {
    /// 姓。等同于lastName
    public var familyName: String?
    /// 名。等同于firstName
    public var givenName: String?
    /// 公司
    public var company: String?
    /// 一个人可能有多个电话
    public var phoneNumbers: [XQContactsItem]?
    /// 一个人可能有多个电话
    public var emails: [XQContactsItem]?
}
