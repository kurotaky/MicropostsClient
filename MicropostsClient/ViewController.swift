//
//  ViewController.swift
//  MicropostsClient
//
//  Created by usr0600244 on 2015/07/02.
//  Copyright (c) 2015年 mo-fu.org. All rights reserved.
//

import UIKit
import Social

let defaultAvatarURL = NSURL(string: "https://abs.twimg.com/sticky/default_profile_images/" + "default_profile_6_200x200.png")

class ViewController: UITableViewController {
    var parsedTweets: Array<ParsedTweet> = [
        ParsedTweet(tweetText: "ほにゃらら", userName: "kurotaky", createdAt: "2014-08-20 19:46:30 JST", userAvatarURL: defaultAvatarURL),
        ParsedTweet(tweetText: "ふぇーーー", userName: "kurotaky", createdAt: "2014-08-20 19:46:30 JST", userAvatarURL: defaultAvatarURL),
        ParsedTweet(tweetText: "ふぇーーー", userName: "kurotaky", createdAt: "2014-08-20 19:46:30 JST", userAvatarURL: defaultAvatarURL)
    ]
    
    @IBOutlet weak var twitterWebView: UIWebView!

    @IBAction func handleTweetButtonTapped(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController (forServiceType: SLServiceTypeTwitter)
            tweetVC.setInitialText("weeeeeei")
            presentViewController(tweetVC, animated: true, completion: nil)
        } else {
            println("Can't send tweet")
        }
    }

    @IBAction func handleShowMyTweetsTapped(sender: UIButton) {
        twitterWebView.loadRequest(NSURLRequest(URL: NSURL(string: "http://twitter.com/kurotaky")!))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedTweets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTweetCell") as! ParsedTweetCell
        let parsedTweet = parsedTweets[indexPath.row]
        cell.userNameLabel.text = parsedTweet.userName
        cell.tweetTextLabel.text = parsedTweet.tweetText
        cell.createdAtLabel.text = parsedTweet.createdAt
        if parsedTweet.userAvatarURL != nil {
            if let imageData = NSData(contentsOfURL: parsedTweet.userAvatarURL!) {
                cell.avatarImageView.image = UIImage(data: imageData)
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func reloadTweets() {
        tableView.reloadData()
    }

}