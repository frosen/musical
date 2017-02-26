//
//  User.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class User: BaseData {
    static let classname = "_User"

    //个人信息
    var name: String = "玩家"
    var sign: String = "个性签名，啦啦啦"
    var avatarURL: String = ""
    var isRegistered: Bool = false

    //状态数据

    convenience init(ID: DataID, name: String, url: String) {
        self.init(ID: ID)
        self.name = name
        self.avatarURL = url
    }

    override init(ID: DataID) {
        super.init(ID: ID)
    }
}


