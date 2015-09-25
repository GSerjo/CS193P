//
//  GraphViewController.swift
//  Calculator
//
//  Created by Serjo on 08/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

final class GraphViewController: UIViewController, GraphViewDataSource {
    
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            
            graphView.dataSource = self
            
            let tapGesture = UITapGestureRecognizer(target: graphView, action: "origion:")
            tapGesture.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tapGesture)

            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "scale:"))
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "origionMove:"))
        }
    }
    
    func y(x: CGFloat) -> CGFloat? {
        return cos(1.0/x) * x
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
