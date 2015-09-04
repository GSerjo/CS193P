//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Serjo on 04/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

final class DiagnosedHappinessViewController : HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private struct History {
        
        private init(){}
        
        static let SegueId = "ShowDiognosticHistory"
        static let DiagnosticHistoty = "DiagnosticHistoty"
    }
    
    var diagnosticHistory: [Int]{
        get {
            return defaults.objectForKey(History.DiagnosticHistoty) as? [Int] ?? []
        }
        set {
            defaults.setObject(newValue, forKey: History.DiagnosticHistoty)
        }
    }
    
    override var happiness: Int {
        didSet {
            diagnosticHistory.append(happiness)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueId:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
