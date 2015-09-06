//
//  PieView.swift
//  Pie
//
//  Created by Ling Wang on 9/4/15.
//  Copyright © 2015 Moke. All rights reserved.
//

import UIKit

class PieView: UIView {
    class PieLayer: CALayer {
        // FIXME: workaround for bug 22595617
        @NSManaged var progress: CGFloat
        
        override class func needsDisplayForKey(key: String) -> Bool {
            return key == "progress" || super.needsDisplayForKey(key)
        }
        
        override func actionForKey(event: String) -> CAAction? {
            if event == "progress" {
                let animation = CABasicAnimation(keyPath: event)
                animation.fromValue = presentationLayer()?.valueForKey(event)
                return animation
            } else {
                return super.actionForKey(event)
            }
        }
        
        // Can not override UView.drawRect(:) to achieve the same result because it does not support animations.
        override func drawInContext(ctx: CGContext) {
            UIGraphicsPushContext(ctx)
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let startAngle = CGFloat(-M_PI_2)
            let endAngle = startAngle + 2 * CGFloat(M_PI) * progress
            let path = UIBezierPath(arcCenter: center, radius: bounds.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLineToPoint(center)
            path.closePath()
            UIColor.whiteColor().setFill()
            path.fill()
            UIGraphicsPopContext()
        }
    }
    
    override class func layerClass() -> AnyClass {
        return PieLayer.self
    }
    
    var progress: CGFloat {
        get {
            return (layer as! PieLayer).progress
        }
        set {
            setProgress(newValue, animated: false)
        }
    }
    
    func setProgress(progress: CGFloat, animated: Bool) {
        CATransaction.begin()
        if !animated {
            CATransaction.setDisableActions(true)
        }
        (layer as! PieLayer).progress = progress
        CATransaction.commit()
    }
    
    // Workaround for bug 22595655.
    override func drawRect(rect: CGRect) {}

    // UView.drawRect(:) does not support animations while CALayer.drawInContext(:) does.
//    override func drawRect(rect: CGRect) {
//        let center = CGPoint(x: bounds.midX, y: bounds.midY)
//        let startAngle = CGFloat(-M_PI_2)
//        let endAngle = startAngle + 2 * CGFloat(M_PI) * progress
//        let path = UIBezierPath(arcCenter: center, radius: bounds.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        path.addLineToPoint(center)
//        path.closePath()
//        UIColor.whiteColor().setFill()
//        path.fill()
//    }
}