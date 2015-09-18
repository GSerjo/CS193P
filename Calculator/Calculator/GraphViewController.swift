//
//  GraphViewController.swift
//  Calculator
//
//  Created by Serjo on 08/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

final class GraphViewController: UIViewController {
    
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: graphView, action: "origion:")
            tapGesture.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tapGesture)

            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "scale:"))
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "origionMove:"))
        }
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
