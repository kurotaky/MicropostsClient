//
//  LoginViewController.swift
//  MicropostsClient
//
//  Created by usr0600244 on 2015/07/21.
//  Copyright (c) 2015年 mo-fu.org. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeViewController(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            println("closed !!!")
        })
    }
    
    @IBAction func loginButtonDidPush(sender: UIBarButtonItem) {
    // BASIC認証
    let user = usernameTextField.text
    let password = passwordTextField.text
    println("username \(user)")
    println("password \(password)")
    
    var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/api/microposts.json")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 0.0)
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
    // Alamofire.request(.GET, "http://localhost:3000/api/microposts.json/")
    Alamofire.request(request)
        .authenticate(user: user, password: password)
        .response { (request, response, data, error) -> Void in
            println(request)
            println(response)
            if response?.statusCode == 200 {
                // 情報を保存
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setObject(user, forKey: "username")
                userDefaults.setObject(password, forKey: "password")
                userDefaults.synchronize()
                println(userDefaults.stringForKey("username"))
                println(userDefaults.stringForKey("password"))
            } else {
                // アラート: もう一回入力してね
                let alertController = UIAlertController(title: "エラー", message: "入力項目を確認してね", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
