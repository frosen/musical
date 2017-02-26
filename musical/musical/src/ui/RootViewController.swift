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

    // 自己生成变色的UIImage
    // 可以参考 http://www.genshuixue.com/i-cxy/p/15153808
    // 也可以用 CAGradientLayer 但是这个会左右nav对整体size的改变，所以选择直接生成一个UIImage
    private var navBGImg: UIImage {
        let gSize: CGSize = CGSize(width: 3, height: 64)

        //创建CGContextRef
        UIGraphicsBeginImageContext(gSize)
        let context = UIGraphicsGetCurrentContext()!

        //创建CGMutablePathRef
        let path = CGMutablePath()

        // 绘制Path
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: gSize.width, y: 0))
        path.addLine(to: CGPoint(x: gSize.width, y: gSize.height))
        path.addLine(to: CGPoint(x: 0, y: gSize.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()

        // 颜色和方向
        let colors: NSArray = [DarkColor.cgColor, LightColor.cgColor]
        let colorArray: CFArray = colors as CFArray
        let location: UnsafePointer<CGFloat> = UnsafePointer<CGFloat>([0.0, 1.0])

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colorArray, locations: location)!

        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 0, y: gSize.height)
        context.saveGState()
        context.addPath(path)
        context.clip()
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context.restoreGState()

        // 获取图像
        let img = UIGraphicsGetImageFromCurrentImageContext()!

        // 结束
        UIGraphicsEndImageContext()

        return img
    }

    private func initNav() {
        let navBar = UINavigationBar.appearance()
        navBar.setBackgroundImage(navBGImg, for: .default)
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








