//
//  InfoBoard.swift
//  musical
//
//  Created by luleyan on 2017/3/1.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class InfoBoard: UIView {

    private static let w: CGFloat = UIScreen.main.bounds.width
    private static let h: CGFloat = 115

    private static let upH: CGFloat = 80

    private static let margin: CGFloat = 6
    private static let iconWidth: CGFloat = upH - margin - margin

    private static let btnMargin: CGFloat = 12

    // ----------------------------------------------

    private var icon: UIImageView! = nil
    private var nameLbl: UILabel! = nil
    private var descLbl: UILabel! = nil
    private var courseNumLbl: UILabel! = nil
    private var locationLbl: UILabel! = nil

    private var lBtn: UIButton! = nil
    private var rBtn: UIButton! = nil

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: InfoBoard.w, height: InfoBoard.h))

        backgroundColor = UIColor.white // 因为EventBoard会移动，在移动时候不显示下面的控件，所以不能透明

        icon = UIImageView(frame: CGRect(
            x: InfoBoard.margin,
            y: InfoBoard.margin,
            width: InfoBoard.iconWidth,
            height: InfoBoard.iconWidth
        ))
        addSubview(icon)

        let lblX = icon.frame.origin.x + icon.frame.width + 15
        let lblWidth = InfoBoard.w - InfoBoard.margin - lblX

        nameLbl = UILabel()
        addSubview(nameLbl)
        nameLbl.frame = CGRect(x: lblX, y: InfoBoard.margin, width: lblWidth, height: 26)
        nameLbl.font = UIFont.boldSystemFont(ofSize: 18)
        nameLbl.textColor = TitleColor
        nameLbl.textAlignment = .left

        descLbl = UILabel()
        addSubview(descLbl)
        descLbl.frame = CGRect(x: lblX, y: nameLbl.frame.origin.y + nameLbl.frame.height, width: lblWidth, height: 21)
        descLbl.font = UIFont.systemFont(ofSize: 13)
        descLbl.textColor = TextColor
        descLbl.textAlignment = .left

        descLbl.numberOfLines = 1
        descLbl.lineBreakMode = .byTruncatingTail

        courseNumLbl = UILabel()
        addSubview(courseNumLbl)
        courseNumLbl.frame = CGRect(x: lblX, y: descLbl.frame.origin.y + descLbl.frame.height, width: lblWidth, height: 21)
        courseNumLbl.font = UIFont.systemFont(ofSize: 13)
        courseNumLbl.textColor = BaseColor
        courseNumLbl.textAlignment = .left

        locationLbl = UILabel()
        addSubview(locationLbl)

        locationLbl.frame = courseNumLbl.frame
        locationLbl.frame.size.width -= 15

        locationLbl.font = UIFont.systemFont(ofSize: 13)
        locationLbl.textColor = DarkColor
        locationLbl.textAlignment = .right

        // 按钮
        let btnMid = InfoBoard.upH + (InfoBoard.h - InfoBoard.upH) / 2

        lBtn = createPriceBtn(title: "学生家授课", action: #selector(InfoBoard.onClickLeftBtn))
        addSubview(lBtn)
        lBtn.frame.origin.x = InfoBoard.btnMargin
        lBtn.center.y = btnMid

        rBtn = createPriceBtn(title: "教师家授课", action: #selector(InfoBoard.onClickRightBtn))
        addSubview(rBtn)
        rBtn.frame.origin.x = InfoBoard.w / 2 + InfoBoard.btnMargin / 2
        rBtn.center.y = btnMid
    }

    func createPriceBtn(title: String, action: Selector) -> UIButton {
        let btnH: CGFloat = 25

        let btn = UIButton(type: .custom)

        btn.frame.size = CGSize(width: InfoBoard.w / 2 - InfoBoard.btnMargin * 1.5, height: btnH)

        btn.addTarget(self, action: action, for: .touchUpInside)

        btn.layer.cornerRadius = 7
        btn.layer.borderColor = BaseColor.cgColor
        btn.layer.borderWidth = 0.5

        let titleLbl = UILabel()
        btn.addSubview(titleLbl)

        titleLbl.text = title
        titleLbl.frame.size = CGSize(width: 60, height: btnH)
        titleLbl.frame.origin.x = 5
        titleLbl.center.y = btnH / 2
        titleLbl.tag = 1

        titleLbl.font = UIFont.systemFont(ofSize: 11)
        titleLbl.textColor = TextColor

        let priceLbl = UILabel()
        btn.addSubview(priceLbl)

        priceLbl.font = UIFont.systemFont(ofSize: 14)
        priceLbl.textColor = BaseColor
        priceLbl.tag = 2

        priceLbl.text = "￥150.00"
        priceLbl.sizeToFit()
        priceLbl.frame.origin.x = titleLbl.frame.origin.x + titleLbl.frame.width
        priceLbl.center.y = titleLbl.center.y

        return btn
    }

    func set(data: Teacher) {
        icon.sd_setImage(with: URL(string: data.avatarUrl), placeholderImage: #imageLiteral(resourceName: "img_default"))

        nameLbl.text = data.name
        descLbl.text = data.selfDesc
        courseNumLbl.text = String(format: "正在授课: %d时/周", data.courseNum)
        locationLbl.text = "朝阳"


    }

    func onClickLeftBtn() {

    }

    func onClickRightBtn() {

    }
}













