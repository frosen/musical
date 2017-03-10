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
    var sign: String = ""

    var availableTime: AvailableTime = AvailableTime()
    var location: Location = Location()

    // 价格
    var priceList: [Price] = []

    // 状态
    var trailNum: Int = 0
    var learnedNum: Int = 0 // 已经上过课程课时
    var learningNum: Int = 0 // 本周上课人数

    // 教师介绍
    var introduction: String = ""
    var imgList: [ShowImg] = []

    // 其他教师资料
    var teachAge: Int = 0
}

class AvailableTime: NSObject {
    private var times: [(Bool, Bool, Bool)] = [
        (false, false, false),
        (false, false, false),
        (false, false, false),
        (false, false, false),
        (false, false, false),
        (false, false, false),
        (false, false, false)
    ]

    // 0 为周日，其他1-6，返回上午下午晚上，有时间为
    func get(by week: Int) -> (Bool, Bool, Bool) {
        return times[week]
    }

    func set(time: (Bool, Bool, Bool), by week: Int) {
        times[week] = time
    }

    // --------------------------------------------------------
    private static let key = 2

    class func serialize(at: AvailableTime) -> Int {
        var num = 1
        var total = 0
        for t in at.times {
            total += (t.0 ? 1 : 0) * num
            num *= key

            total += (t.1 ? 1 : 0) * num
            num *= key

            total += (t.2 ? 1 : 0) * num
            num *= key
        }
        return total
    }

    class func unserialize(data: Int) -> AvailableTime {
        let at = AvailableTime()

        var d = data
        for i in 0 ..< at.times.count {
            at.times[i].0 = (d % key == 1)
            d = d / key

            at.times[i].1 = (d % key == 1)
            d = d / key

            at.times[i].2 = (d % key == 1)
            d = d / key
        }
        return at
    }
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

    // --------------------------------------------------------
    class func serialize(at: Price) -> [String: Any] {
        return [
            "title": at.title,
            "stu": at.atStuHome,
            "tch": at.atTchHome,
            "desc": at.desc
        ]
    }

    class func unserialize(data: [String: Any]) -> Price {
        let t = data["title"] as! String
        let stu = data["stu"] as! Int
        let tch = data["tch"] as! Int
        let desc = data["desc"] as! String
        let pr = Price(title: t, atStu: stu, atTch: tch, desc: desc)

        return pr
    }
}

class ShowImg: NSObject {
    var imgUrl: String = ""
    var txt: String = ""
}




