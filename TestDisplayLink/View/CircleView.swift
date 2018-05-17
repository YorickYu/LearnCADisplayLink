//
//  CircleView.swift
//  TestDisplayLink
//
//  Created by 郁洋 on 2018/4/25.
//  Copyright © 2018年 郁洋. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    fileprivate var timeElapsed: CFTimeInterval = 0.0
    fileprivate let secondsToCount: CFTimeInterval = 3.0
    fileprivate var pass: CGFloat = 0.0
    
    var startAngle: CGFloat {
        return -.pi/2
    }
    var endAngle: CGFloat {
        return startAngle + pass
    }
    
    var displaylink : CADisplayLink?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        displaylink = CADisplayLink(target: self, selector: #selector(update(_:)))
        displaylink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        displaylink?.isPaused = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
    }

    
    @objc func update(_ link: CADisplayLink) {

        if timeElapsed == 0 {
            timeElapsed = link.timestamp
            return
        }
        
        pass = CGFloat(link.timestamp - timeElapsed)
        
        print(pass)
        if endAngle > startAngle + 2 * .pi {
            endCircle()
            timeElapsed = 0.0
            return
        }
        
        // 重绘
        setNeedsDisplay()
        
    }
    
    func startCircle() {
        timeElapsed = 0.0
        displaylink?.isPaused = false
    }
    
    
    func endCircle() {
        displaylink?.isPaused = true
        displaylink?.invalidate()
        displaylink = nil
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: center, radius: 30, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = nil
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        
    }
    
    deinit {
        print("cricle 释放了")
    }

}
