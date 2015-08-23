//
//  NumberFormatter.swift
//  Calculator
//
//  Created by Serjo on 23/08/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import Foundation

final class NumberFormatter: NSNumberFormatter {
    
    static let sharedInstance = NumberFormatter()
    
    private override init() {
        super.init()
        
        self.locale = NSLocale(localeIdentifier: "en_US")
        self.groupingSeparator = " "
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}