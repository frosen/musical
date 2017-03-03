//
//  InfoBoard.swift
//  musical
//
//  Created by luleyan on 2017/3/1.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class InfoBoard: UIView {

    static let w: CGFloat = UIScreen.main.bounds.width
    static let h: CGFloat = UIScreen.main.bounds.width / 375 * 260

    private let margin: CGFloat = 20
    private let lblH: CGFloat = 125

    // ----------------------------------------------

    private var icon: UIImageView! = nil
    private var nameLbl: UILabel! = nil
    private var descLbl: UILabel! = nil
    private var locationLbl: UILabel! = nil

    private var lPrice: PriceView! = nil
    private var rPrice: PriceView! = nil

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: InfoBoard.w, height: InfoBoard.h))
        print(frame, UIScreen.main.bounds)

        backgroundColor = UIColor.white // 因为EventBoard会移动，在移动时候不显示下面的控件，所以不能透明

        // 背景icon
        icon = UIImageView(frame: frame)
        addSubview(icon)

        // 文本
        let lblBg = UIImageView(image: InfoBoard.createLblBgImg())
        addSubview(lblBg)
        lblBg.frame = CGRect(x: 0, y: InfoBoard.h - lblH, width: InfoBoard.w, height: lblH)

        nameLbl = UILabel(frame: CGRect(x: margin, y: InfoBoard.h - lblH, width: 300, height: 44))
        addSubview(nameLbl)
        nameLbl.font = UIFont.systemFont(ofSize: 30)
        nameLbl.textColor = UIColor.white
        nameLbl.textAlignment = .left

        let line = UIView(frame: CGRect(
            x: margin,
            y: nameLbl.frame.origin.y + nameLbl.frame.height + 5,
            width: 40,
            height: 1
        ))
        addSubview(line)
        line.backgroundColor = BaseColor

        descLbl = UILabel(frame: CGRect(
            x: margin,
            y: nameLbl.frame.origin.y + nameLbl.frame.height + 10,
            width: InfoBoard.w - margin * 2,
            height: 25
        ))
        addSubview(descLbl)

        descLbl.font = UIFont.systemFont(ofSize: 12)
        descLbl.textColor = UIColor.white
        descLbl.textAlignment = .left

        descLbl.numberOfLines = 1
        descLbl.lineBreakMode = .byTruncatingTail

        locationLbl = UILabel()
        addSubview(locationLbl)

        locationLbl.font = UIFont.systemFont(ofSize: 12)
        locationLbl.textColor = UIColor.white

        locationLbl.layer.cornerRadius = 3
        locationLbl.layer.borderWidth = 0.5
        locationLbl.layer.borderColor = UIColor.white.cgColor

        // 价格
        lPrice = PriceView(title: "学生家授课")
        addSubview(lPrice)

        let priceMargin: CGFloat = (InfoBoard.w - 2 * lPrice.frame.width) / 3
        lPrice.frame.origin = CGPoint(x: priceMargin, y: descLbl.frame.origin.y + descLbl.frame.height)

        rPrice = PriceView(title: "教师家授课")
        addSubview(rPrice)
        rPrice.frame.origin = CGPoint(x: InfoBoard.w / 2 + priceMargin / 2, y: descLbl.frame.origin.y + descLbl.frame.height)
    }

    func set(data: Teacher) {
        icon.sd_setImage(with: URL(string: data.avatarUrl), placeholderImage: #imageLiteral(resourceName: "teacher_bg"))

        nameLbl.text = data.name
        descLbl.text = data.selfDesc

        locationLbl.text = " " + "朝阳 756米" + " "
        locationLbl.sizeToFit()
        locationLbl.frame.origin = CGPoint(
            x: InfoBoard.w - margin - locationLbl.frame.width,
            y: nameLbl.frame.origin.y + nameLbl.frame.height - 15
        )

        lPrice.set(price: data.priceList[0])
        rPrice.set(price: data.priceList[1])
    }

    private static var lblBgImg: UIImage? = nil
    private static func createLblBgImg() -> UIImage {
        if lblBgImg != nil {
            return lblBgImg!
        }

        let gSize: CGSize = CGSize(width: w, height: h)

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
        let colors: NSArray = [UIColor.clear.cgColor, UIColor(white: 0.0, alpha: 0.5).cgColor]
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
        lblBgImg = UIGraphicsGetImageFromCurrentImageContext()!

        // 结束
        UIGraphicsEndImageContext()
        
        return lblBgImg!
    }
}

class PriceView: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var priceLbl: UILabel! = nil

    init(title: String) {

        let w: CGFloat = 137
        let h: CGFloat = 44
        super.init(frame: CGRect(x: 0, y: 0, width: w, height: h))

        let titleLbl = UILabel(frame: CGRect(x: 0, y: 1, width: 65, height: h))
        addSubview(titleLbl)
        titleLbl.font = UIFont.systemFont(ofSize: 12)
        titleLbl.textColor = UIColor.white
        titleLbl.text = title

        priceLbl = UILabel(frame: CGRect(x: 65, y: 0, width: 72, height: h))
        addSubview(priceLbl)
        priceLbl.font = UIFont.boldSystemFont(ofSize: 20)

        set(price: 0)
    }

    func set(price: Int) {
        priceLbl.text = "￥" + String(price)
        priceLbl.textColor = price > 0 ? BaseColor : UIColor.lightGray
    }
}











