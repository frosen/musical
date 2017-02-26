//
//  ChallengeCell.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class ListCell: BaseCell {

    override class func getCellHeight(_ d: BaseData? = nil, index: IndexPath? = nil, otherData: Any? = nil) -> CGFloat {
        return 72
    }

    override func initData(_ d: BaseData?, index: IndexPath?) {

    }

    override func setData(_ d: BaseData?, index: IndexPath?) {

    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted == true {
            backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        } else {
            backgroundColor = UIColor.white
        }
    }
}
