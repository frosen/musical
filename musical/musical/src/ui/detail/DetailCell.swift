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
    class func createHead(_ v: UIView, s: String, w: CGFloat, h: CGFloat) {
        let line = UIView(frame: CGRect(x: cellMargin, y: h / 2, width: w - 2 * cellMargin, height: 0.5))
        v.addSubview(line)
        line.backgroundColor = UIColor.lightGray

        let lbl = UILabel(frame: CGRect())
        v.addSubview(lbl)

        lbl.backgroundColor = UIColor.white
        lbl.text = "  " + s + "  "

        lbl.sizeToFit()
        lbl.center = CGPoint(x: w / 2, y: h / 2)

        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = TitleColor

    }
}

class DetailTimeTitleCell: DetailTitleCell {
    override func initData(_ d: BaseData?, index: IndexPath?) {
        selectionStyle = .none //使选中后没有反应
        DetailTitleCell.createHead(contentView, s: "可上课时间", w: w, h: h)
    }
}

class DetailTimeCell: StaticCell {

}

class DetailMapTitleCell: DetailTitleCell {
    override func initData(_ d: BaseData?, index: IndexPath?) {
        selectionStyle = .none //使选中后没有反应
        DetailTitleCell.createHead(contentView, s: "教师地址", w: w, h: h)
    }
}

class DetailMapCell: StaticCell {

}

class DetailImgTitleCell: DetailTitleCell {
    override func initData(_ d: BaseData?, index: IndexPath?) {
        selectionStyle = .none //使选中后没有反应
        DetailTitleCell.createHead(contentView, s: "教师风采", w: w, h: h)
    }
}

class DetailImgCell: BaseCell {
    
}







