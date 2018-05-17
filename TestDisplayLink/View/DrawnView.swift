//
//  DrawnView.swift
//  TestDisplayLink
//
//  Created by 郁洋 on 2018/5/17.
//  Copyright © 2018年 郁洋. All rights reserved.
//

import UIKit

class DrawnView: UIView {

    var displaylink: CADisplayLink?
    var paths: NSMutableArray = {
       return NSMutableArray(capacity: 1)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        displaylink = CADisplayLink(target: self, selector: #selector(update(_:)))
        displaylink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        displaylink?.isPaused = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func update(_ link: CADisplayLink) {
        print("update")
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 激活displaylink
        displaylink?.isPaused = false
        
        // 创建uibezierpath
        let path = YYBezierPath()
        path.lineColor = UIColor.orange

        // 初始化path到触摸点
        if let touch = (touches as NSSet).anyObject() {
            if let point = (touch as? UITouch)?.location(in: self) {
                path.move(to: point)
                paths.add(path)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var path: YYBezierPath?
        if paths.count > 0 {
            path = paths.lastObject as? YYBezierPath
        }
        if let touch = (touches as NSSet).anyObject() {
            if let point = (touch as? UITouch)?.location(in: self) {
                path?.addLine(to: point)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        displaylink?.isPaused = true
    }
    
    override func draw(_ rect: CGRect) {
        guard paths.count >= 0 else { return }
        for path in paths {
            let p = path as? YYBezierPath
            p?.lineJoinStyle = .round
            p?.lineCapStyle = .round
            p?.lineColor?.set()
            p?.stroke()
        }
    }
    
    func endDraw() {
        displaylink?.isPaused = true
        displaylink?.invalidate()
        displaylink = nil
    }

}
