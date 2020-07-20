//
//  XQExtension.swift
//  XQFoundation
//
//  Created by LaiXuefei on 2020/7/13.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import Foundation

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

public extension String {
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

extension Date {
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    func string(withFormat format: String = "yyyy/MM/dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    /// 倒计时描述文本。xx小时xx分xx秒
    /// - 不足1小时，展示xx分xx秒；不足1分钟，展示xx秒
    var countDownDesc: String {
        let countDownInSecond = Int(self.timeIntervalSince1970)
        let oneHourInSecond = 3600
        let oneMinuteInSecond = 60

        let hour = countDownInSecond/3600
        let minute = (countDownInSecond - hour*oneHourInSecond)/oneMinuteInSecond
        let second = countDownInSecond - hour*oneHourInSecond - minute*oneMinuteInSecond

        let hourStr = hour == 0 ? "" : String(hour) + "时"
        let minuteStr = minute == 0 && hour == 0 ? "" : String(minute) + "分"
        let secondStr = second == 0 ? "" : String(second) + "秒"
        //xx小时/xx分/xx秒
        return hourStr + minuteStr + secondStr
    }
}
