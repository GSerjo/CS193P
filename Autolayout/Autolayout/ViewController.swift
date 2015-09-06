//
//  ViewController.swift
//  Autolayout
//
//  Created by Serjo on 06/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var secure = false { didSet { updateUI() } }
    var loggedInUser: User? { didSet { updateUI() } }
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRationConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRation,
                        constant: 0)
                }
                else {
                    aspectRationConstraint = nil
                }
            }
        }
    }
    var aspectRationConstraint: NSLayoutConstraint? {
        willSet {
            if let existeingConstraint = aspectRationConstraint {
                view.removeConstraint(existeingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRationConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Sesure Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }
}

extension User {
    var image: UIImage? {
        guard let image = UIImage(named: login) else {
            return UIImage(named: "unknown_user")
        }
        return image
    }
}

extension UIImage {
    var aspectRation: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
