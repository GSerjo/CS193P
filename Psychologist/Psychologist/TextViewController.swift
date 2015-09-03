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
}
