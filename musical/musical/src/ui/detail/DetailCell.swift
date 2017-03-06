//
//  DetailCell.swift
//  musical
//
//  Created by 卢乐颜 on 2017/3/5.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class DetailHeadCell: StaticCell {

    private var infoBoard: InfoBoard! = nil
    
    override class func getCellHeight(_ d: BaseData? = nil, index: IndexPath? = nil, otherData: Any? = nil) -> CGFloat {
        return InfoBoard.h
    }

    override func initData(_ d: BaseData?, index: IndexPath?) {
        selectionStyle = .none //使选中后没有反应

        infoBoard = InfoBoard()
        contentView.addSubview(infoBoard)
    }

    override func setData(_ d: BaseData?, index: IndexPath?) {
        let teacher = d as! Teacher
        infoBoard.set(data: teacher)
    }
}

class DetailStateCell: StaticCell {

}

let cellMargin: CGFloat = 20

class DetailTitleCell: StaticCell {
    class func createHead(_ v: UIView, s: String, h: CGFloat) {
        let vw: CGFloat = 5
        let vh: CGFloat = 18

        let icon = UIView(frame: CGRect(x: cellMargin, y: v.frame.height / 2 - vh / 2, width: vw, height: vh))
        v.addSubview(icon)
        icon.backgroundColor = BaseColor

        let lbl = UILabel(frame: CGRect(
            x: icon.frame.width + icon.frame.origin.x + 7,
            y: 0, width: 300, height: h))
        v.addSubview(lbl)

        lbl.text = s

        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 18, weight: -1.0)
        lbl.textColor = TitleColor

        let line = UIView(frame: CGRect(x: cellMargin, y: h - 0.5, width: v.frame.width - 2 * cellMargin, height: 0.5))
        v.addSubview(line)
        line.backgroundColor = UIColor.lightGray
    }
}

class DetailTimeTitleCell: DetailTitleCell {
    override func initData(_ d: BaseData?, index: IndexPath?) {
        selectionStyle = .none //使选中后没有反应
        DetailTitleCell.createHead(contentView, s: "可上课时间", h: h)
    }
}

class DetailTimeCell: StaticCell {

}

class DetailMapTitleCell: DetailTitleCell {
    override func initData(_ d: BaseData?, index: IndexPath?) {
        selectionStyle = .none //使选中后没有反应
        DetailTitleCell.createHead(contentView, s: "教师地址", h: h)
    }
}

class DetailMapCell: StaticCell {

}

class DetailImgTitleCell: DetailTitleCell {
    override func initData(_ d: BaseData?, index: IndexPath?) {
        selectionStyle = .none //使选中后没有反应
        DetailTitleCell.createHead(contentView, s: "教师风采", h: h)
    }
}

class DetailImgCell: BaseCell {
    
}







