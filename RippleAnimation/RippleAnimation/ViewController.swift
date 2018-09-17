//
//  ViewController.swift
//  RippleAnimation
//
//  Created by WQ on 2018/9/17.
//  Copyright © 2018年 WQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var connectButton: RippleButton = {
        let res = RippleButton(frame: CGRect(x: 200, y: 200, width: 136, height: 136), rippleColor: UIColor(hex6: 0x4A6DFE))
        res.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        res.began()
        return res
    }()
    
    @objc func buttonPressed(sender: RippleButton) {
        sender.rippleState = !sender.rippleState
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(gradientLayer(from: UIColor(hex6: 0x31395F), to: UIColor(hex6: 0x31387B), frame: self.view.bounds, isCircle: false))
        view.addSubview(connectButton)
    }
    
    //背景渐变色
    private func gradientLayer(from: UIColor, to: UIColor, frame: CGRect, isCircle: Bool) -> CAGradientLayer {
        let res = CAGradientLayer()
        res.colors = [from.cgColor, to.cgColor]
        res.locations = [0, 1.0]
        res.startPoint = CGPoint(x: 0, y: 0)
        res.endPoint = CGPoint(x: 0, y: 1.0)
        if isCircle {
            res.cornerRadius = frame.width / 2.0
        }
        res.frame = frame
        return res
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

