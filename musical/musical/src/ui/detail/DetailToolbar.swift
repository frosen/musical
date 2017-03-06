//
//  DetailToolbar.swift
//  musical
//
//  Created by luleyan on 2017/3/6.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class DetailToolbar: UIView {

    static let w: CGFloat = UIScreen.main.bounds.width
    static let h: CGFloat = 44

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: DetailToolbar.w, height: DetailToolbar.h))

        backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3

        
    }
}
