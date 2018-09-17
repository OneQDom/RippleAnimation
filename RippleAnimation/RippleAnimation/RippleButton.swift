//
//  RippleButton.swift
//  RippleAnimation
//
//  Created by WQ on 2018/7/23.
//  Copyright © 2018年 WQ. All rights reserved.
//

import UIKit

class RippleButton: UIButton {
    
    //添加了一个属性表示波纹是否出现
    var rippleState = false
    //按钮描边颜色变化
//    var borderColorState = false
    //私有属性
    private var rippleColor: UIColor!
    private var rippleLayer: CALayer?
    
    init(frame: CGRect, rippleColor: UIColor) {
        super.init(frame: frame)
        self.rippleColor = rippleColor
        layer.borderWidth = 6
        layer.borderColor = UIColor(hex6: 0x47FDD3).cgColor
        layer.cornerRadius = frame.width / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        rippleState ? began() : stop()
    }
    
    func began() {
        rippleLayer = CALayer.createRippleLayer(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), duration: 2, ripColor: rippleColor)
        layer.insertSublayer(rippleLayer!, at: 0)
        rippleState = true
    }
    
    func stop() {
        rippleLayer?.removeFromSuperlayer()
        rippleLayer = nil
        rippleState = false
    }
    
}

extension CALayer {
    //创建出动画layer
    static func createRippleLayer(frame: CGRect, duration: CFTimeInterval, ripColor: UIColor) -> CALayer {
        let shape = CAShapeLayer()
        let newFrame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        let bound = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        shape.frame = bound
        shape.path = UIBezierPath(ovalIn: bound).cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = ripColor.cgColor
        shape.opacity = 0.1
        shape.repeatCount = HUGE
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [alphaAnimation(from: 1, to: 0.1), scaleAnimation()]
        animationGroup.duration = duration
        animationGroup.autoreverses = false
        animationGroup.repeatCount = HUGE
        shape.add(animationGroup, forKey: "animationGroup")
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = newFrame
        replicatorLayer.instanceCount = 4
        replicatorLayer.instanceDelay = 0.5
        replicatorLayer.instanceAlphaOffset = 0.2
        replicatorLayer.addSublayer(shape)
        return replicatorLayer
    }
    
    //透明度动画
    private static func alphaAnimation(from: CGFloat, to: CGFloat) -> CABasicAnimation {
        let alpha = CABasicAnimation(keyPath: "opacity")
        alpha.fromValue = from
        alpha.toValue = to
        return alpha
    }
    
    //放大动画
    private static func scaleAnimation() -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform")
        scale.fromValue = CATransform3DScale(CATransform3DIdentity, 1, 1, 0)
        scale.toValue = CATransform3DScale(CATransform3DIdentity, 1.15, 1.15, 0)
        return scale
    }
}
