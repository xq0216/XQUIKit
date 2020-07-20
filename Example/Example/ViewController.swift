//
//  ViewController.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/6.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cellIdentifier = "XQCell"

    @IBOutlet weak var itemTableView: UITableView!

    var dataAry = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        itemTableView.tableFooterView = UIView()
        dataAry.append(contentsOf: [CellData("RefreshBar", subTitle: "刷新栏", details: "RefreshBarViewController"),
                                    CellData("Contacts", subTitle: "通讯录", details: "ContactsViewController")])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataAry.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                let aCell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
                aCell.detailTextLabel?.textColor = UIColor(hexString: "")
                aCell.selectionStyle = .none
                return aCell
            }
            return cell
        }()
        let model = dataAry[indexPath.row]
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.subTitle
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataAry[indexPath.row]
        guard let controller = model.detailsController() else { return }
        controller.title = model.title
        navigationController?.pushViewController(controller, animated: true)
    }
}
