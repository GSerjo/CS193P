//
//  ViewController.swift
//  Psychologist
//
//  Created by Serjo on 01/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    

    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let nav = segue.destinationViewController as? UINavigationController else {
            return
        }
        
        if let hvc = nav.visibleViewController as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "sad": hvc.happiness = 0
                case "happy": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }
}