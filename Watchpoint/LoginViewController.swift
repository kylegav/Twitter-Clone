//
//  LoginViewController.swift
//  Watchpoint
//
//  Created by Kyle Gavin on 8/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Skip login process if "userIsLoggedIn" is true
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userIsLoggedIn") == true {
            
            self.performSegue(withIdentifier: "loginAction", sender: self)
    
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        TwitterAPICaller.client?.login(url: "https://api.twitter.com/oauth/request_token", success: {
            
            // Debugging Text Output
            print("Login Sucess")
            
            UserDefaults.standard.set(true, forKey: "userIsLoggedIn")
            
            self.performSegue(withIdentifier: "loginAction", sender: self)
        
        }, failure: { (Error) in
            
            // Debugging Text Output
            print("Login Failed")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
