//
//  ViewController.swift
//  MicropostsClient
//
//  Created by usr0600244 on 2015/07/02.
//  Copyright (c) 2015年 mo-fu.org. All rights reserved.
//

import UIKit
import Social
import Alamofire

let defaultAvatarURL = NSURL(string: "https://abs.twimg.com/sticky/default_profile_images/" + "default_profile_6_200x200.png")

class ViewController: UITableViewController {
    var parsedTweets: Array<ParsedTweet> = [
        ParsedTweet(tweetText: "ほにゃらら", userName: "kurotaky", createdAt: "2014-08-20 19:46:30 JST", userAvatarURL: defaultAvatarURL),
        ParsedTweet(tweetText: "ふぇーーー", userName: "kurotaky", createdAt: "2014-08-20 19:46:30 JST", userAvatarURL: defaultAvatarURL),
        ParsedTweet(tweetText: "ふぇーーー", userName: "kurotaky", createdAt: "2014-08-20 19:46:30 JST", userAvatarURL: defaultAvatarURL)
    ]
    
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
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private var isAuthenticated = false

    override func viewWillAppear(animated: Bool) {
        // ログイン済みなら ViewContorller (TimeLineView)を表示
        // 認証していなかったら LoginViewController を表示

        // トークンがセットされていたらAPIにtokenとemailを送って認証する
        let userDefault = NSUserDefaults.standardUserDefaults()
        if let token = userDefault.objectForKey("authentication_token") as? String {
            let email = userDefault.objectForKey("email") as? String
            authenticateFromToken(token, email: email!) // 認証結果をresultに格納
        }
    }

    func authenticateFromToken(token: String, email: String) {
        // NSUserDefaults から値を取り出す
        // tokenがNSUserDefaultsに存在するかチェック
        // 存在しなかったらfalseを返す
        // tokenがuserDefaultsに存在するならAPIにtokenを送って認証する
        // Alamofire.request でemailとauthentication_tokenを渡す
        let params = ["authentication_token": token, "email": email]
        // Alamofire.request(.GET, "http://localhost:3000/api/microposts/feed_items", parameters: params)
        Alamofire.request(.GET, "https://sample-app-1234kuro.sqale.jp/api/microposts/feed_items", parameters: params)
            .response { request, response, data, error in
                if response?.statusCode == 200 {
                    println("200 !!!")
                    self.isAuthenticated = true
                } else {
                    println("40x !!!")
                    self.isAuthenticated = false
                }
                if !self.isAuthenticated {
                    // 認証していないならログイン画面を表示する
                    let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginNavigationController") as! UINavigationController
                    self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
                }
        }
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
    
    @IBAction func comeHome(segue: UIStoryboardSegue) {
        
    }

}