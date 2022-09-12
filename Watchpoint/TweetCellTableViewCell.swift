//
//  TweetCellTableViewCell.swift
//  Watchpoint
//
//  Created by Kyle Gavin on 8/19/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userProfileTweetCell: UIImageView!
    
    @IBOutlet weak var userNameTweetCell: UILabel!
    
    @IBOutlet weak var userTweetTweetCell: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBAction func retweetAction(_ sender: Any) {
        
        
    }
    
    var tweetId:Int = -1
    

    @IBAction func likeAction(_ sender: Any) {
        let toBeFavorited = !isFavorite
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("failed to favorite \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("failed to unfavorite \(error)")
            })
        }
        
        
    }
    var isFavorite:Bool = false
    
    func setFavorite(_ isFavorited:Bool) {
        isFavorite = isFavorited
        if (isFavorite) {
            heartButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            heartButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
