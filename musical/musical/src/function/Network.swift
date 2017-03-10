//
//  Network.swift
//  musical
//
//  Created by luleyan on 2017/3/8.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit
import AVOSCloud

class Network: NSObject {

    //单例
    static let shareInstance = Network()
    private override init() {
        //        AVOSCloud.setAllLogsEnabled(false)
        AVOSCloud.setApplicationId("RaaHjayXJjkGfrWEheFdFEpW-gzGzoHsz", clientKey: "wrsl1KaMfCJUf1AjGRfxXoug")
    }

    // 获取 orderType: 0无顺序，1时间从早到晚，2时间从晚到早
    func fetchObjs(from: String, ids: [String], with lists: [String], order: (Int, Any)?, skip: Int?, callback: @escaping (([Any]?, Error?) -> Void)) {
        let query = AVQuery(className: from)

        if ids.count > 0 {
            query.whereKey("objectId", containedIn: ids)
        }

        if lists.count > 0 {
            query.selectKeys(lists)
        }

        if skip != nil {
            query.skip = skip!
        }
        query.limit = 20

        if order != nil {
            if order!.0 == 1 {
                query.order(byAscending: order!.1 as! String) // 早的在前
            } else if order!.0 == 2 {
                query.order(byDescending: order!.1 as! String) // 早的在后
            } else if order!.0 == 3 {
                let data = order!.1 as! (String, CLLocation)
                let point = AVGeoPoint(latitude: data.1.coordinate.latitude, longitude: data.1.coordinate.longitude)
                query.whereKey(data.0, nearGeoPoint: point)
            }
        }

        query.findObjectsInBackground { objs, error in
            callback(objs, error)
        }
    }

    // 解析 -------------------------------------------------------------------

    // 参数必须是AVObject，为了不对外开放，所以对外为NSObject
    // inout: 参考 http://blog.csdn.net/chenyufeng1991/article/details/48495367
    func parse(obj: Any, by attris: inout [String: Any], callback: ((String?, [String: Any]) -> Void)) {
        if let avobjList = obj as? [AVObject] {
            for avobj in avobjList {
                parse(avobj: avobj, by: &attris, callback: callback, key: "")
            }
        } else if let avobj = obj as? AVObject {
            parse(avobj: avobj, by: &attris, callback: callback, key: "")
        } else {
            callback(nil, [:])
        }
    }

    private func parse(avobj: AVObject, by attris: inout [String: Any], callback: ((String?, [String: Any]) -> Void), key: String) {
        for attri in attris {
            let name = attri.key

            guard let value = avobj[name] else {
                if name == "id" { // 特殊字段
                    attris[name] = avobj.objectId
                } else {
                    print("ERROR: no name \(name) in obj [\(key)]")
                }
                continue
            }

            if value is AVGeoPoint {
                let geo = value as! AVGeoPoint
                attris[name] = CLLocation(latitude: geo.latitude, longitude: geo.longitude)

            } else if value is AVObject && attri.value is [String: Any] {
                var subAttri: [String: Any] = attri.value as! [String : Any]
                parse(avobj: value as! AVObject, by: &subAttri, callback: callback, key: name)

            } else if value is [AVObject] && (value as! [AVObject]).count > 0 && attri.value is [[String: Any]] {
                let valueList = value as! [AVObject]
                var attriDict = attri.value as! [[String: Any]]
                var subAttri: [String: Any] = attriDict[0]
                for v in valueList {
                    parse(avobj: v, by: &subAttri, callback: callback, key: name)
                    attriDict.append(subAttri)
                }
            } else {
                attris[name] = value
            }
        }

        callback(key, attris)
    }

    private func checkValue(_ v: Any) -> Any {
        switch v {
        case is CLLocation:
            return AVGeoPoint(location: v as! CLLocation)
        case is [BaseData]:
            var arRes = [Any]()
            let arv = v as! [BaseData]
            if arv.count == 0 {
                return []
            } else {
                for vInAr in arv {
                    arRes.append(checkValue(vInAr))
                }
                return arRes
            }
        default:
            return v
        }
    }


}




