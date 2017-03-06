//
//  InfoBoard.swift
//  musical
//
//  Created by luleyan on 2017/3/1.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class InfoBoard: UIView {

    static let rate: CGFloat = UIScreen.main.bounds.width / 375
    static let w: CGFloat = UIScreen.main.bounds.width
    static let h: CGFloat = 250 * rate

    private let margin: CGFloat = 20
    private let lblH: CGFloat = 125 * rate

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

        backgroundColor = UIColor.white // 因为EventBoard会移动，在移动时候不显示下面的控件，所以不能透明

        // 背景icon
        icon = UIImageView(frame: frame)
        addSubview(icon)

        // 文本
        let lblBg = UIImageView(image: #imageLiteral(resourceName: "black"))
        addSubview(lblBg)
        lblBg.frame = CGRect(x: 0, y: InfoBoard.h - lblH, width: InfoBoard.w, height: lblH)

        let font = UIFont.systemFont(ofSize: 25.0 * InfoBoard.rate)
        nameLbl = UILabel(frame: CGRect(x: margin, y: InfoBoard.h - lblH, width: 300, height: font.lineHeight))
        addSubview(nameLbl)
        nameLbl.font = font
        nameLbl.textColor = UIColor.white
        nameLbl.textAlignment = .left

        let line = UIView(frame: CGRect(
            x: margin,
            y: nameLbl.frame.origin.y + nameLbl.frame.height + 12 * InfoBoard.rate,
            width: 40,
            height: 1
        ))
        addSubview(line)
        line.backgroundColor = BaseColor

        descLbl = UILabel(frame: CGRect(
            x: margin,
            y: nameLbl.frame.origin.y + nameLbl.frame.height + 24 * InfoBoard.rate,
            width: InfoBoard.w - margin * 2,
            height: 25
        ))
        addSubview(descLbl)

        descLbl.font = UIFont.systemFont(ofSize: 12.0 * InfoBoard.rate)
        descLbl.textColor = UIColor.white
        descLbl.textAlignment = .left

        descLbl.numberOfLines = 1
        descLbl.lineBreakMode = .byTruncatingTail

        locationLbl = UILabel()
        addSubview(locationLbl)

        locationLbl.font = UIFont.systemFont(ofSize: 12.0 * InfoBoard.rate)
        locationLbl.textColor = UIColor.white

        locationLbl.layer.cornerRadius = 3
        locationLbl.layer.borderWidth = 0.5
        locationLbl.layer.borderColor = UIColor.white.cgColor

        // 价格
        lPrice = PriceView(title: "学生家授课", rate: InfoBoard.rate)
        addSubview(lPrice)

        let priceY = (InfoBoard.h + descLbl.frame.origin.y + descLbl.frame.height - lPrice.frame.height) / 2
        let priceMargin: CGFloat = (InfoBoard.w - 2 * lPrice.frame.width) / 3
        lPrice.frame.origin = CGPoint(x: priceMargin, y: priceY)

        rPrice = PriceView(title: "教师家授课", rate: InfoBoard.rate)
        addSubview(rPrice)
        rPrice.frame.origin = CGPoint(x: InfoBoard.w / 2 + priceMargin / 2, y: priceY)
    }

    func set(data: Teacher) {
        icon.sd_setImage(with: URL(string: data.avatarUrl), placeholderImage: #imageLiteral(resourceName: "teacher_bg"))

        nameLbl.text = data.name
        descLbl.text = data.selfDesc

        locationLbl.text = " " + "朝阳 756米" + " "
        locationLbl.sizeToFit()

        locationLbl.frame.origin = CGPoint(
            x: InfoBoard.w - margin - locationLbl.frame.width,
            y: nameLbl.frame.origin.y + nameLbl.frame.height - locationLbl.frame.height
        )

        // 获取其中最低价
        let highPrice: Int = 99999
        var atTchLowPrice: Int = highPrice
        var atStuLowPrice: Int = highPrice
        for p in data.priceList {
            if p.atStuHome < atStuLowPrice {
                atStuLowPrice = p.atStuHome
            }
            if p.atTchHome < atTchLowPrice {
                atTchLowPrice = p.atTchHome
            }
        }
        if atStuLowPrice == highPrice {
            atStuLowPrice = 0
        }
        if atTchLowPrice == highPrice {
            atTchLowPrice = 0
        }

        // 设置价格
        lPrice.set(price: atStuLowPrice)
        rPrice.set(price: atTchLowPrice)
    }
}

class PriceView: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var titleLbl: UILabel! = nil
    var priceLbl: UILabel! = nil
    var lblEnd: UILabel! = nil

    init(title: String, rate: CGFloat) {

        let w: CGFloat = 137
        let h: CGFloat = 44
        super.init(frame: CGRect(x: 0, y: 0, width: w, height: h))

        titleLbl = UILabel()
        addSubview(titleLbl)
        titleLbl.font = UIFont.systemFont(ofSize: 12.0 * rate)
        titleLbl.textColor = UIColor.white
        titleLbl.text = title

        titleLbl.sizeToFit()
        titleLbl.frame.size.width = 65
        titleLbl.frame.origin.x = 0
        titleLbl.center.y = h / 2

        priceLbl = UILabel()
        addSubview(priceLbl)
        priceLbl.font = UIFont.boldSystemFont(ofSize: 20.0 * rate)

        lblEnd = UILabel()
        addSubview(lblEnd)
        lblEnd.font = UIFont.systemFont(ofSize: 12.0 * rate)
        lblEnd.textColor = BaseColor
        lblEnd.text = "起"
        lblEnd.sizeToFit()
    }

    func set(price: Int) {
        priceLbl.text = "￥" + String(price)
        priceLbl.textColor = price > 0 ? BaseColor : UIColor.lightGray

        priceLbl.sizeToFit()
        priceLbl.frame.origin = CGPoint(
            x: titleLbl.frame.origin.x + titleLbl.frame.width,
            y: titleLbl.frame.origin.y + titleLbl.frame.height - priceLbl.frame.height + 3
        )

        lblEnd.frame.origin = CGPoint(
            x: priceLbl.frame.origin.x + priceLbl.frame.width,
            y: titleLbl.frame.origin.y + titleLbl.frame.height - lblEnd.frame.height
        )
    }
}











