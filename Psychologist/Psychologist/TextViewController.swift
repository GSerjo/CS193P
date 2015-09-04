//
//  TextViewController.swift
//  Psychologist
//
//  Created by Serjo on 03/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

final class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }
            else {
                return super.preferredContentSize
            }
        }
        set {
            super.preferredContentSize = newValue
        }
    }
}
