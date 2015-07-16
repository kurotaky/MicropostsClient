//
//  ParsedTweetCell.swift
//  MicropostsClient
//
//  Created by usr0600244 on 2015/07/12.
//  Copyright (c) 2015年 mo-fu.org. All rights reserved.
//

import UIKit

class ParsedTweetCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
