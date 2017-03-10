//
//  TeacherListMgr.swift
//  musical
//
//  Created by 卢乐颜 on 2017/2/26.
//  Copyright © 2017年 fffff. All rights reserved.
//  name, url, sign, time, loc, price

import UIKit

class TeacherListMgr: DataMgr {
    var attrisKeeper: [String: Any] = [
        "id": "id",
        "name": "str",
        "url": "str",
        "sign": "str",
        "time": 1,
        "loc": "Location",
        "price": ["price"],
    ]

    func fetch(obKey: String, loc: CLLocation, callback: @escaping ((Bool, [Teacher]) -> Void)) {
        Network.shareInstance.fetchObjs(from: Teacher.classname, ids: [], with: [
            "name", "url", "sign", "time", "loc", "price"
        ], order: (3, ("loc", loc)), skip: 0) { objs, error in
            guard error == nil else {
                print("ERROR: TeacherListMgr fetch", error!)
                if DataMgr.hasOb(for: obKey) {
                    callback(true, [])
                }
                return
            }

            DispatchQueue(label: self.parseThreadName).async {

                var teachers: [Teacher] = []
                Network.shareInstance.parse(obj: objs!, by: &self.attrisKeeper) { key, attris in
                    if key == "" {
                        let teacher = Teacher(ID: attris["id"] as! DataID)
                        teacher.name = attris["name"] as! String
                        teacher.avatarUrl = attris["url"] as! String
                        teacher.sign = attris["sign"] as! String
                        teacher.availableTime = AvailableTime.unserialize(data: attris["time"] as! Int)
                        teacher.location.set(loc: attris["loc"] as! CLLocation)
                        let priceAttris = attris["price"] as! [[String: Any]]
                        for pAttri in priceAttris {
                            teacher.priceList.append(Price.unserialize(data: pAttri))
                        }

                        teachers.append(teacher)
                    }
                }

                DispatchQueue.main.async {
                    if DataMgr.hasOb(for: obKey) {
                        callback(true, teachers)
                    }
                }
            }
        }
    }

    private func getTestData() -> [Teacher] {
        var teachers: [Teacher] = []

        var teacher: Teacher

        teacher = Teacher(ID: "123")
        teachers.append(teacher)
        teacher.name = "多多老师"
        teacher.teachAge = 8
        teacher.sign = "专业钢琴教师 8年教龄 名校毕业"

        teacher.priceList = [Price(title: "钢琴", atStu: 300, atTch: 200)]

        teacher = Teacher(ID: "123")
        teachers.append(teacher)
        teacher.name = "fengfeng"
        teacher.teachAge = 8
        teacher.sign = "专业钢琴教师 8年教龄 名校毕业 哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"
        teacher.priceList = [Price(title: "钢琴", atStu: 3200, atTch: 1200), Price(title: "钢琴乐理", atStu: 320, atTch: 120)]

        teacher = Teacher(ID: "123")
        teachers.append(teacher)
        teacher.name = "海海"
        teacher.teachAge = 8
        teacher.sign = "朗朗百名琴童总策划 专业钢琴教师 8年教龄 名校毕业"
        teacher.priceList = [Price(title: "钢琴", atStu: 3, atTch: 20)]

        return teachers
    }
}
