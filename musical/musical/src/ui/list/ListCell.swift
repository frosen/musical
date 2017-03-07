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
        return InfoBoard.h
    }

    override func initData(_ d: BaseData?, index: IndexPath?) {
        bounds = CGRect(x: 0, y: 0, width: w, height: h)

        infoBoard = InfoBoard()
        contentView.addSubview(infoBoard)
    }

    override func setData(_ d: BaseData?, index: IndexPath?) {
        let teacher = d as! Teacher
        infoBoard.set(data: teacher)
    }
}






