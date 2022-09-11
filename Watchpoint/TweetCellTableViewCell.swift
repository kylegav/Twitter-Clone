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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
