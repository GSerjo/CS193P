//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Serjo on 19/10/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController {

    var tweet: Tweet? {
        didSet {
            title = tweet?.user.name
            
            if let media = tweet?.media where media.count > 0 {
                let mentions = media.map { Mention.Image($0.url, $0.aspectRatio) }
                mentionTypes.append(MentionType(type: "Images", mentions: mentions))
            }
            if let urls = tweet?.urls where urls.count > 0 {
                let mentions = urls.map { Mention.KeyWord($0.keyword) }
                mentionTypes.append(MentionType(type: "Urls", mentions: mentions))
            }
            if let hashtags = tweet?.hashtags where hashtags.count > 0 {
                let mentions = hashtags.map { Mention.KeyWord($0.keyword) }
                mentionTypes.append(MentionType(type: "Hastags", mentions: mentions))
            }
            
            if let users = tweet?.userMentions {
                var mentions = [Mention.KeyWord("@" + tweet!.user.screenName)]
                if users.count > 0 {
                    mentions += users.map { Mention.KeyWord($0.keyword)}
                }
                mentionTypes.append(MentionType(type: "Users", mentions: mentions))
            }
        }
    }
    
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mention = mentionTypes[indexPath.section].mentions[indexPath.row]
        
        switch mention {
        case .Image(_, let ration):
            return tableView.bounds.size.width/CGFloat(ration)
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mentionTypes[section].type
    }

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
