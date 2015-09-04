//
//  ViewController.swift
//  Psychologist
//
//  Created by Serjo on 01/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

final class PsychologistViewController: UIViewController {
    
    private struct SegueId {
        
        private init(){}
        
        static let Sad = "sad"
        static let Happy = "happy"
        static let Nothing = "nothing"
    }
    

    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier(SegueId.Nothing, sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let nav = segue.destinationViewController as? UINavigationController else {
            return
        }
        
        if let hvc = nav.visibleViewController as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case SegueId.Sad: hvc.happiness = 0
                case SegueId.Happy: hvc.happiness = 100
                case SegueId.Nothing: hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }
}