//
//  UserMgr.swift
//  musical
//
//  Created by 卢乐颜 on 2017/2/26.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class UserMgr: DataMgr {

    var loc: Location = Location()

    func fetch(obKey: String, callback: ((Bool, User) -> Void)) {
        let user = User(ID: "12345")
        user.name = "明明"
        user.avatarURL = ""
        user.sign = "个性签名，啦啦啦"
        callback(true, user)
    }
}
