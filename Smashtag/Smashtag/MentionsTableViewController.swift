//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Serjo on 19/10/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController {

    var tweet: Tweet?
    
    private struct Storyboard {
        static let KeywordCellReuseIndentifier = "KeywordCell"
        static let ImageCellReuseIndentifier = "ImageCell"
    }
    
    private var mentionTypes: [MentionType] = []
    
    private struct MentionType: CustomStringConvertible {
        var type: String
        var mentions: [Mention]
        
        var description: String {
            return "\(type): \(mentions)"
        }
    }
    
    private enum Mention: CustomStringConvertible {
        case KeyWord(String)
        case Image(NSURL, Double)
        
        var description: String {
            switch self {
            case .Image(let url, _):
                return url.path!
            case .KeyWord(let keyword):
                return keyword
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mentionTypes.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentionTypes[section].mentions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mention = mentionTypes[indexPath.section].mentions[indexPath.row]
        
        switch mention {
        case .KeyWord(let keyword):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.KeywordCellReuseIndentifier, forIndexPath: indexPath)
            cell.textLabel?.text = keyword
            return cell
            
        case .Image(let url, _):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ImageCellReuseIndentifier, forIndexPath: indexPath) as! ImageTableViewCell
            cell.imageUrl = url
            return cell
        }
    }
}
