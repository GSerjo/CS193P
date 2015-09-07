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
    
    override func drawRect(rect: CGRect) {
        axesDrawer.contentScaleFactor = scale
        origin = origin ?? graphCenter
        axesDrawer.drawAxesInRect(bounds, origin: origin!, pointsPerUnit: scale)
    }
}
