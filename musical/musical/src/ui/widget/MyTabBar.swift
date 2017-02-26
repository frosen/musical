//
//  MyTabBar.swift
//  TheOneFoosball2
//
//  Created by 卢乐颜 on 16/7/4.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

protocol MyTabBarDelegate {
    func tabBar(_ tabBar: MyTabBar, didClickItem item: UIButton)
}

class MyTabBar: UIView {

    private var ctrller: UITabBarController
    private var myTabBarDelegate: MyTabBarDelegate

    private var buttons: [MyTabBarItem] = []
    private weak var selectedButton: UIButton?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(vc: UITabBarController, delegate: MyTabBarDelegate) {
        ctrller = vc
        myTabBarDelegate = delegate

        super.init(frame: vc.tabBar.frame)

        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
    }

    class func replaceOldTabBar(_ tabVc: UITabBarController, delegate: MyTabBarDelegate, btnItems items: [UITabBarItem]) -> MyTabBar {
        let tab = MyTabBar(vc: tabVc, delegate: delegate)

        tabVc.view.insertSubview(tab, aboveSubview: tabVc.tabBar)
        tabVc.tabBar.removeFromSuperview()

        tab.setBarItems(items)

        return tab
    }

    private func setBarItems(_ items: [UITabBarItem]) {

        for item in items {
            let btn = MyTabBarItem(type: .custom)

            btn.setItem(item)

            btn.tag = buttons.count

            btn.addTarget(self, action: #selector(MyTabBar.onClickItem(_:)), for: .touchDown)

            addSubview(btn)
            buttons.append(btn)

            if btn.tag == 0 {
                onClickItem(btn)
            }
        }
        layoutBarItems()
    }

    private func layoutBarItems() {

        let vw = bounds.size.width
        let vh = bounds.size.height

        var x: CGFloat = 0
        let y: CGFloat = 0
        let w = vw / CGFloat(buttons.count)
        let h = vh

        var i = 0
        for btn in buttons {
            x = CGFloat(i) * w
            btn.frame = CGRect(x: x, y: y, width: w, height: h)

            i += 1
        }
    }

    func onClickItem(_ btn: UIButton) {
        if btn.isSelected == true {
            return
        }

        selectedButton?.isSelected = false
        selectedButton = btn
        selectedButton!.isSelected = true

        ctrller.selectedIndex = btn.tag

        myTabBarDelegate.tabBar(self, didClickItem: btn)
    }
}








