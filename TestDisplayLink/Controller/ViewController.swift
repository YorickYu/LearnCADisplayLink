//
//  ViewController.swift
//  TestDisplayLink
//
//  Created by 郁洋 on 2018/4/25.
//  Copyright © 2018年 郁洋. All rights reserved.
//

import UIKit

struct YYInfo {
    let header_title = "CADisplayLink"
    let cell_title = ["自动画圆", "简易画板"]
    let target_vc = [FirstViewController(), SecondViewController()]
}

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tb = UITableView(frame: view.frame, style: .grouped)
        tb.delegate = self
        tb.dataSource = self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tb.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tb.tableFooterView = UIView()
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YY"
        configTableView()
    }
    
    func runtime() {
        var count: UInt32 = 0
        let objc_property_t = class_copyPropertyList(UITableView.self, &count)
        
        for idx in 0..<count {
            let por = objc_property_t![Int(idx)]
            let ivarName = property_getName(por)
            let name = String(cString: ivarName)
            print(name)
        }
    }
    
    func configTableView() {
        view.addSubview(tableView)
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YYInfo().cell_title.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = YYInfo().cell_title[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let target_vc = YYInfo().target_vc[indexPath.row]
        target_vc.title = YYInfo().cell_title[indexPath.row]
        navigationController?.pushViewController(target_vc, animated: true)
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = YYInfo().header_title
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        return label
    }
    
}

