//
//  ParsedTweet.swift
//  MicropostsClient
//
//  Created by usr0600244 on 2015/07/11.
//  Copyright (c) 2015年 mo-fu.org. All rights reserved.
//

import UIKit

class ParsedTweet: NSObject {
    var tweetText: String?
    var userName: String?
    var createdAt: String?
    var userAvatarURL: NSURL?

    override init () {
        super.init()
    }

    init(tweetText: String?,
        userName: String?,
        createdAt: String?,
        userAvatarURL: NSURL?) {
            super.init()
            self.tweetText = tweetText
            self.userName = userName
            self.createdAt = createdAt
            self.userAvatarURL = userAvatarURL
    }
}
