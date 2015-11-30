//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Serjo on 27/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate {

    var tweets = [[Tweet]]()
    
    private struct Storyboard {
        static let CellReuseIndentifier = "Tweet"
        static let MentionsSegueIdentifier = "ShowMentions"
    }
    
    var lastSuccessfullRequest: TwitterRequest?
    
    var nextRequestToAttempt: TwitterRequest? {
        if lastSuccessfullRequest == nil {
            if searchText != nil {
                return TwitterRequest(search: searchText!, count: 100)
            }
            else {
                return nil
            }
        }
        else {
            return lastSuccessfullRequest!.requestForNewer
        }
    }
    
    var searchText: String? = "#stanford" {
        didSet {
            lastSuccessfullRequest = nil
            searchTextField?.text = searchText
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Storyboard.MentionsSegueIdentifier:
                if let cell = sender as? TweetTableViewCell {
                    let controller = segue.destinationViewController as! MentionsTableViewController
                    controller.tweet = cell.tweet
                }
            default:
                break
            }
        }
    }
    
    @IBAction func refresh(sender: UIRefreshControl?) {
        
        guard let currentSearch = searchText else {
            return
        }
        saveSearchText(currentSearch)
        if let request = nextRequestToAttempt {
            self.lastSuccessfullRequest = request
            request.fetchTweets { newTweets -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    
                    defer { sender?.endRefreshing() }

                    guard newTweets.isEmpty == false else {
                        return
                    }
                    
                    self.tweets.insert(newTweets, atIndex: 0)
                    self.tableView.reloadData()
                }
            }
        }
        else {
            sender?.endRefreshing()
        }
    }
    
    private func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
    }
    
    private func saveSearchText(search: String) {
        RecentSearches().add(search)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIndentifier, forIndexPath: indexPath) as! TweetTableViewCell
        
        let tweet = tweets[indexPath.section][indexPath.row]
        cell.tweet = tweet        
        return cell
    }
}
