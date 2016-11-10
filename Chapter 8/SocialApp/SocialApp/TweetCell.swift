//
//  TweetCell.swift
//  SocialApp
//
//  Created by Matthew Knott on 18/10/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetUserAvatar: UIImageView!
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
