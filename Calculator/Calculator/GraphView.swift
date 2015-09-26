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
    weak var dataSource: GraphViewDataSource?
    
    private var graphCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    @IBInspectable
    var scale: CGFloat = 50 { didSet { setNeedsDisplay() } }
    
    var origin: CGPoint? { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.blackColor() { didSet { setNeedsDisplay() } }
    var lineWidth: CGFloat = 2.0 { didSet { setNeedsDisplay() } }
    
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
    
    func drawCurveInRect(bounds: CGRect, origin: CGPoint, pointsPerUnits: CGFloat) {
        color.set()
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        var point = CGPoint()
        
        var firstValue = true
        for var i = 0; i <= Int(bounds.size.width * contentScaleFactor); i++ {
            point.x = CGFloat(i) / contentScaleFactor
            if let y = dataSource?.y((point.x - origin.x)/scale) {
                if !y.isNormal && !y.isZero {
                    firstValue = true
                    continue
                }
                point.y = origin.y - y * scale
                if firstValue {
                    path.moveToPoint(point)
                    firstValue = false
                }
                else {
                    path.addLineToPoint(point)
                }
            }
            else {
                firstValue = true
            }
        }
        path.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        axesDrawer.contentScaleFactor = scale
        origin = origin ?? graphCenter
        axesDrawer.drawAxesInRect(bounds, origin: origin!, pointsPerUnit: scale)
        drawCurveInRect(bounds, origin: origin!, pointsPerUnits: scale)
    }
}
