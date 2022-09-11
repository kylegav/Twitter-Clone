//
//  HomeTableViewController.swift
//  Watchpoint
//
//  Created by Kyle Gavin on 8/19/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    
    var tweetArray = [NSDictionary]()
    var tweetQuantity: Int!
    
    let homeTableRefreshControl = UIRefreshControl()
    
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableRefreshControl.addTarget(self, action: #selector(getTweets), for:  .valueChanged)
        tableView.refreshControl = homeTableRefreshControl
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getTweets()
    }
    
    @objc func getTweets() {
        
        tweetQuantity = 40
        
        let twitterTimelineUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        let timelineParams = ["count": 40]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: twitterTimelineUrl, parameters: timelineParams as [String: Any], success: { (tweets: [NSDictionary] ) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                
                self.tweetArray.append(tweet)
                
            }
            self.tableView.reloadData()
            self.homeTableRefreshControl.endRefreshing()
            
            print("Get Tweet Success")
        }, failure: { (Error) in
            print("Failed to Grab Tweets")
            print(Error.localizedDescription)
        })
        
    }
    
    func getMoreTweets() {
        let twitterTimelineUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        tweetQuantity += 20
        
        let timelineParams = ["count": tweetQuantity]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: twitterTimelineUrl, parameters: timelineParams as [String : Any], success: { (tweets: [NSDictionary] ) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                
                self.tweetArray.append(tweet)
                
            }
            self.tableView.reloadData()
            self.homeTableRefreshControl.endRefreshing()
            
            print("Get Tweet Success")
        }, failure: { (Error) in
            print("Failed to Grab Tweets")
            print(Error.localizedDescription)
        })
        
        
    }

    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "userIsLoggedIn")
    }
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userTweetTweetCell.text = (tweetArray[indexPath.row]["text"] as! String)
        cell.userNameTweetCell.text = (user["name"] as! String)
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.userProfileTweetCell.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == tweetArray.count {
            getMoreTweets()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
