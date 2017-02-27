//
//  RootViewController.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit
import SDWebImage

class RootViewController: UITabBarController, MyTabBarDelegate {
    private var items: [UITabBarItem] = []
    
    var myTabBar: MyTabBar! = nil
    var currentCtrlr: BaseController! = nil

    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        initNav()
        initSubVc()
        initTabBar() 
    }

    private func initNav() {
        let navBar = UINavigationBar.appearance()
        navBar.setBackgroundImage(#imageLiteral(resourceName: "nav_bg"), for: .default)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    private func initSubVc() {
        // 学习管理

        // 教师列表
        let listVc = ListController(rootVC: self)
        addVc(listVc, title: "找教师", image: #imageLiteral(resourceName: "tab_home"))

        // 圈子

        // 个人
        let ownVc = OwnController(rootVC: self)
        addVc(ownVc, title: "个人", image: #imageLiteral(resourceName: "tab_my"))
    }

    private func addVc(_ vc: BaseTabController, title t: String, image img: UIImage) {
        vc.tabBarItem.title = t

        // 设置子控制器的图片
        vc.tabBarItem.image = img

        // 先给外面传进来的小控制器 包装 一个导航控制器
        let nav = UINavigationController(rootViewController: vc)

        // 添加为子控制器
        addChildViewController(nav)

        //收集bar item 用于自定义的Tabbar
        items.append(vc.tabBarItem)
    }

    private func initTabBar() {
        myTabBar = MyTabBar.replaceOldTabBar(self, delegate: self, btnItems: items)
        myTabBar.tintColor = BaseColor
    }

    // MyTabBarDelegate
    func tabBar(_ tabBar: MyTabBar, didClickItem item: UIButton) {
        print("press tabBar item", item.tag)
    }
}








