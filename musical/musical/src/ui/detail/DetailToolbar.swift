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
    static let h: CGFloat = 48

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: DetailToolbar.w, height: DetailToolbar.h))

        backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3

        let sBtnW: CGFloat = DetailToolbar.h + 2

        var line: UIView
        line = UIView(frame: CGRect(x: sBtnW, y: 0, width: 0.5, height: 48))
        addSubview(line)
        line.backgroundColor = UIColor.lightGray

        line = UIView(frame: CGRect(x: sBtnW * 2, y: 0, width: 0.5, height: 48))
        addSubview(line)
        line.backgroundColor = UIColor.lightGray

        let btnW: CGFloat = (DetailToolbar.w - sBtnW * 3) / 2

        let btn1 = UIButton(type: .custom)
        addSubview(btn1)
        btn1.frame = CGRect(x: sBtnW * 3, y: 0, width: btnW, height: 48)
        btn1.backgroundColor = BaseColor
        btn1.setTitle("试约课", for: .normal)

        let btn2 = UIButton(type: .custom)
        addSubview(btn2)
        btn2.frame = CGRect(x: sBtnW * 3 + btnW, y: 0, width: btnW, height: 48)
        btn2.backgroundColor = DarkColor
    }
}








