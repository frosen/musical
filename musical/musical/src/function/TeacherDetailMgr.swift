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
        teacher.selfDesc = "专业钢琴教师 8年教龄 名校毕业"
        teacher.priceList = [200, 300]
        
        return teacher
    }
}
