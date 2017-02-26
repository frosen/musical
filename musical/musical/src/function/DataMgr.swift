//
//  DataMgr.swift
//  Foosball
//
//  Created by 卢乐颜 on 2016/11/7.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

protocol DataOB {

}

class DataMgr: NSObject {

    // 逻辑数据 观察者 ----------------------------------------

    private static var obDict: [String: DataOB] = [:]

    class func register(observer ob: DataOB, key: String) {
        obDict[key] = ob
    }

    class func unregister(key: String) {
        obDict.removeValue(forKey: key)
    }

    class func hasOb(for key: String) -> Bool {
        return obDict[key] != nil
    }
}
