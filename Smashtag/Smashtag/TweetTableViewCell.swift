//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Serjo on 27/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    
    private struct Color {
        static let hashTag = UIColor.purpleColor()
        static let url = UIColor.blueColor()
        static let user = UIColor.orangeColor()
    }
    
    private func colorTweet(tweet: Tweet) -> NSMutableAttributedString {
        var tweetText: String = tweet.text
        
        for _ in tweet.media {
            tweetText += " 📷"
        }
        
        let result = NSMutableAttributedString(string: tweetText)
        result.setKeywordColor(tweet.hashtags, color: Color.hashTag)
        result.setKeywordColor(tweet.urls, color: Color.url)
        result.setKeywordColor(tweet.userMentions, color: Color.user)
        
        return result
    }
    
    func updateUI() {
        
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        
        // load new information from our tweet (if any)
        guard let tweet = self.tweet else {
            return
        }
        
        tweetTextLabel?.attributedText = colorTweet(tweet)
        
        tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
        
        if let profileImageURL = tweet.user.profileImageURL {
            if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                tweetProfileImageView?.image = UIImage(data: imageData)
            }
        }
    }
}

private extension NSMutableAttributedString {
    
    func setKeywordColor(keywords: [Tweet.IndexedKeyword], color: UIColor) {
        for keyword in keywords {
            addAttribute(NSForegroundColorAttributeName, value: color, range: keyword.nsrange)
        }
    }
}
