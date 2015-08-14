//
//  LoginViewController.swift
//  MicropostsClient
//
//  Created by usr0600244 on 2015/07/21.
//  Copyright (c) 2015年 mo-fu.org. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
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
        let email = emailTextField.text
        let password = passwordTextField.text

        let params = ["email": email, "password": password]
        Alamofire.request(.POST, "http://localhost:3000/api/authentication_tokens", parameters: params)
            .response { request, response, data, error in
                if response?.statusCode == 200 {
                    let json = JSON(data: data!)
                    let token: String? = json["authentication_token"].string
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    userDefaults.setObject(token!, forKey: "authentication_token")
                    userDefaults.setObject(email, forKey: "email")
                    userDefaults.synchronize()
                    // tokenを保存したらTimelineを表示する
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
