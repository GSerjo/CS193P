//
//  RecentSearches.swift
//  Smashtag
//
//  Created by Serjo on 29/11/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import Foundation

final class RecentSearches {
    
    private let _defaults = NSUserDefaults.standardUserDefaults()
    
    private struct Constants {
        static let MaxSearches = 100
        static let SearchKey = "RecentSearches.Values"
    }
    
    private (set) var searches: [String] {
        get {
            return _defaults.objectForKey(Constants.SearchKey) as? [String] ?? []
        }
        set {
            _defaults.setObject(newValue, forKey: Constants.SearchKey)
        }
    }
    
}
