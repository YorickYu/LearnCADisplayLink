//
//  FirstViewController.swift
//  TestDisplayLink
//
//  Created by 郁洋 on 2018/5/3.
//  Copyright © 2018年 郁洋. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var circleView: CircleView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        setupView()
    }
    
    func setupView() {
        
        circleView = CircleView()
        circleView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circleView!)

        view.addConstraints([
            NSLayoutConstraint(item: circleView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: circleView!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: -50.0),
            NSLayoutConstraint(item: circleView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100),
            NSLayoutConstraint(item: circleView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
            ]
        )

        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        circleView?.addGestureRecognizer(tap)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        let targetv = sender.view as? CircleView
        targetv?.startCircle()
        /**
         * 这里视图点击一次后，屏蔽点击事件
         */
        targetv?.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        if (circleView != nil) {
            circleView?.endCircle()
        }
    }

}
