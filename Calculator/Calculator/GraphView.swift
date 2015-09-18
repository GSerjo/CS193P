//
//  GraphView.swift
//  Calculator
//
//  Created by Serjo on 08/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    
    let axesDrawer = AxesDrawer(color: UIColor.blueColor())
    private var graphCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    @IBInspectable
    var scale: CGFloat = 50 { didSet { setNeedsDisplay() } }
    
    var origin: CGPoint? { didSet { setNeedsDisplay() } }
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    func origionMove(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(self)
            if translation == CGPointZero {
                break
            }
            origin?.x += translation.x
            origin?.y += translation.y
            gesture.setTranslation(CGPointZero, inView: self)
        default: break
        }
    }
    
    func origion(gesture: UITapGestureRecognizer) {
        if gesture.state == .Ended {
            origin = gesture.locationInView(self)
        }
    }
    
    override func drawRect(rect: CGRect) {
        axesDrawer.contentScaleFactor = scale
        origin = origin ?? graphCenter
        axesDrawer.drawAxesInRect(bounds, origin: origin!, pointsPerUnit: scale)
    }
}
