//
//  BaseTabController.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class BaseTabController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavBar()
    }

    //设置导航栏控件，如果检测未登陆则使用登陆注册，如果未调用此接口则不设置-----------------------------------------------------
    func initNavBar() {
        //左
        navigationItem.leftBarButtonItem = UITools.createBarBtnItem(self, action: #selector(BaseTabController.onClickScan), image: #imageLiteral(resourceName: "nav_scan"))

        //右
        navigationItem.rightBarButtonItem = UITools.createBarBtnItem(self, action: #selector(BaseTabController.onClickSearch), image: #imageLiteral(resourceName: "nav_search"))
    }

    //跳转到二维码扫描页面
    func onClickScan() {
        print("scan")
//        let vc = ScanViewController(rootVC: rootVC)
//        navigationController!.pushViewController(vc, animated: true)
    }

    //跳转到搜索页面
    func onClickSearch() {
        print("search")
//        let vc = SearchController(rootVC: rootVC)
//        navigationController!.pushViewController(vc, animated: true)
    }
}
