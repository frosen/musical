//
//  ChallengeCell.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class ListCell: BaseCell {

    private var infoBoard: InfoBoard! = nil

    override class func getCellHeight(_ d: BaseData? = nil, index: IndexPath? = nil, otherData: Any? = nil) -> CGFloat {
        return 108
    }

    override func initData(_ d: BaseData?, index: IndexPath?) {
        bounds = CGRect(x: 0, y: 0, width: w, height: h)

        // 因为原来自动的selectionStyle会让subview的backgroundcolor变成透明，所以把自动的关闭，自己写一个
        selectionStyle = .none

        infoBoard = InfoBoard()
        contentView.addSubview(infoBoard)
    }

    override func setData(_ d: BaseData?, index: IndexPath?) {
        let teacher = d as! Teacher
        infoBoard.set(data: teacher)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted == true {
            infoBoard.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        } else {
            infoBoard.backgroundColor = UIColor.white
        }
    }
}
