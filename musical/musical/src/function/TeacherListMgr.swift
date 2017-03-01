//
//  TeacherListMgr.swift
//  musical
//
//  Created by 卢乐颜 on 2017/2/26.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class TeacherListMgr: DataMgr {
    func fetch(obKey: String, callback: ((Bool, [Teacher]) -> Void)) {
        callback(true, getTestData())
    }

    func getTestData() -> [Teacher] {
        var teachers: [Teacher] = []

        var teacher: Teacher

        teacher = Teacher(ID: "123")
        teachers.append(teacher)
        teacher.name = "大大"
        teacher.teachAge = 8
        teacher.selfDesc = "朗朗百名琴童总策划 专业钢琴教师 8年教龄 名校毕业"

        teacher = Teacher(ID: "123")
        teachers.append(teacher)
        teacher.name = "fengfeng"
        teacher.teachAge = 8
        teacher.selfDesc = "朗朗百名琴童总策划 专业钢琴教师 8年教龄 名校毕业"

        teacher = Teacher(ID: "123")
        teachers.append(teacher)
        teacher.name = "海海"
        teacher.teachAge = 8
        teacher.selfDesc = "朗朗百名琴童总策划 专业钢琴教师 8年教龄 名校毕业"

        return teachers
    }
}
