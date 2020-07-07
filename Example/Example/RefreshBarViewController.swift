//
//  RefreshBarViewController.swift
//  Example
//
//  Created by LaiXuefei on 2020/7/10.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit
import XQUIKit

class RefreshBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let bar: XQRefreshBar = XQRefreshBar(supView:view, topMargin:60)
        bar.refreshBlock = { [weak self](status:XQBarStatus)-> Void in
            if (status == .failed){
                bar.updateStatus(.refreshing)
                _ = self?.delay(3, task: {
                    bar.updateStatus(.sucessed)
                })
            }
        }
        bar.updateStatus(.refreshing)
        _ = delay(3) {
            bar.updateStatus(.failed)
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
