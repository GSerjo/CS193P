//
//  GrapthViewDataSource.swift
//  Calculator
//
//  Created by Serjo on 18/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

protocol GraphViewDataSource: class {
    func y(x: CGFloat) -> CGFloat?
}
