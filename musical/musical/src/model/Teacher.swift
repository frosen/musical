//
//  Teacher.swift
//  musical
//
//  Created by 卢乐颜 on 2017/2/26.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class Teacher: BaseData {
    static let classname = "teacher"

    var name: String = ""
    var avatarUrl: String = ""

    var location: Location = Location()

    var teachAge: Int = 0
    var selfDesc: String = ""

    var courseNum: Int = 0
    var trialNum: Int = 0

    // 价格
    var priceList: [Price] = []

    var imgList: [ShowImg] = []
}

class Price: NSObject {
    var atStuHome: Int = 0
    var atTchHome: Int = 0

    var title: String = ""
    var desc: String = ""

    init(title: String, atStu: Int, atTch: Int, desc: String? = nil) {
        self.title = title
        self.atStuHome = atStu
        self.atTchHome = atTch

        if desc != nil {
            self.desc = desc!
        }
        super.init()
    }
}

class ShowImg: NSObject {
    var imgUrl: String = ""
    var txt: String = ""
}




