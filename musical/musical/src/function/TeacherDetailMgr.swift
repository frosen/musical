//
//  TeacherDetailMgr.swift
//  musical
//
//  Created by luleyan on 2017/3/3.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class TeacherDetailMgr: DataMgr {

    func fetch(id: DataID, obKey: String, callback: ((Bool, Teacher?) -> Void)) {
        callback(true, getTestData())
    }

    private func getTestData() -> Teacher {
        var teacher: Teacher

        teacher = Teacher(ID: "123")
        teacher.name = "多多老师"
        teacher.teachAge = 8
        teacher.sign = "专业钢琴教师 8年教龄 名校毕业"
        teacher.priceList = [
            Price(title: "钢琴", atStu: 3200, atTch: 1200, desc: "专业一对一教学"),
            Price(title: "钢琴乐理", atStu: 320, atTch: 120, desc: "专业一对一教学 哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈")
        ]
        
        return teacher
    }
}
