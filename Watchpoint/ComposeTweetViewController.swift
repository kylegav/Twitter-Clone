//
//  ComposeTweetViewController.swift
//  Watchpoint
//
//  Created by Kyle Gavin on 9/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var tweetText: UITextView!
    
    @IBAction func composeTweetCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func composeTweetSend(_ sender: Any) {
        
        if (!tweetText.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success:{
                self.dismiss(animated:true, completion: nil)
            }, failure: { (error) in
                print("Error posting Tweet")
                self.dismiss(animated:true, completion: nil)
            })
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
