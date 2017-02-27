//
//  UIBase.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

let hue: CGFloat = 35
let saturation: CGFloat = 0.98
let brightness: CGFloat = 0.97

let BaseColor: UIColor = UIColor(
    hue: hue / 360,
    saturation: saturation,
    brightness: brightness,
    alpha: 1.0
)

let DarkColor: UIColor = UIColor(
    hue: (hue + 360 - 16).truncatingRemainder(dividingBy: 360.0) / 360,
    saturation: saturation,
    brightness: brightness,
    alpha: 1.0
)

let TitleColor: UIColor = UIColor.black
let SubTitleColor: UIColor = UIColor(white: 0.5, alpha: 1)
let TextColor: UIColor = UIColor(white: 0.25, alpha: 1)

class UITools {
    class func createBarBtnItem(_ target: AnyObject, action: Selector, image img: UIImage) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setBackgroundImage(img, for: UIControlState())
        let bSize = btn.currentBackgroundImage!.size
        btn.bounds = CGRect(x: 0, y: 0, width: bSize.width, height: bSize.height)
        return UIBarButtonItem(customView: btn)
    }

    class func createNavBackBtn(_ vc: UIViewController, action: Selector) {
        vc.navigationItem.leftBarButtonItem = UITools.createBarBtnItem(vc, action: action, image: #imageLiteral(resourceName: "nav_back"))
    }

    class func showAlert(_ target: UIViewController, title: String?, msg: String?, type: Int, callback: ((UIAlertAction) -> Void)?, cancelCallback: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if type == 1 {
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: callback))
        } else {
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: cancelCallback))
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: callback))
        }
        target.present(alert, animated: true, completion: nil)
    }

    class func turnViewToImage(_ v: UIView) -> UIImage {
        // http://www.cocoachina.com/bbs/read.php?tid=144770
        let s = v.frame.size
        UIGraphicsBeginImageContextWithOptions(s, false, UIScreen.main.scale)
        v.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// iphone 6 宽高 375x667 2@

