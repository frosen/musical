//
//  DetailViewController.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class DetailController: BaseController, DataOB, UITableViewDelegate, UITableViewDataSource, StaticCellDelegate {

    private var sectionNum: Int = 0

    private(set) var curTeacherId: DataID! = nil
    private var curTeacher: Teacher! = nil

    var tableView: UITableView! = nil
//    private var toolbar: BaseToolbar! = nil

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(rootVC: RootViewController, id: DataID) {
        super.init(rootVC: rootVC)
        self.curTeacherId = id
    }
    
    override func viewDidLoad() {
        initDataOnViewAppear = true
        navTabType = [.TransparentNav, .HideTab]
        super.viewDidLoad()
        print("详情页面")

        UITools.createNavBackBtn(self, action: #selector(DetailController.onBack), isDark: true)

//        baseView.isUserInteractionEnabled = false
//        callbackOnFinishInit = { _ in
//            self.baseView.isUserInteractionEnabled = true
//            KeynotelikeTransitioning.hideSnapshot() //这里编码耦合度高，要注意
//        }

        //创建tableView
        tableView = UITableView(frame: baseView.bounds, style: .grouped)
        baseView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false //隐藏滑动条
        tableView.backgroundColor = UIColor.white
//        tableView.bounces = false

        //按钮栏
//        toolbar = BaseToolbar()
//        baseView.addSubview(toolbar)
//        toolbar.frame.origin.y = baseView.frame.height - toolbar.frame.height
//
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: toolbar.frame.height, right: 0)
    }

    let DataObKey = "DetailViewController"
    override func initData() {
        DataMgr.register(observer: self, key: DataObKey)
        APP.teacherDetailMgr.fetch(id: curTeacherId, obKey: DataObKey) { suc, teacher in
            onFetchData(suc: suc, data: teacher)
        }
    }

    private let staticVarCellIndexList = [
        IndexPath(row: 0, section: 0),
        IndexPath(row: 1, section: 0),
        IndexPath(row: 1, section: 2),
        IndexPath(row: 1, section: 3)
    ] // 静态cell，但是又需要通过setData变化的

    func onFetchData(suc: Bool, data: Teacher?) {
        guard suc else {
            return
        }

        curTeacher = data
        sectionNum = 5

        // 预生成这些static cell，避免第一次滑动造成的卡顿
        for indexPath in staticVarCellIndexList {
            let _ = StaticCell.create(indexPath, tableView: tableView, data: curTeacher, ctrlr: self, delegate: self)
        }

        tableView.reloadData()
    }

    // table view delegate ==========================================================================================

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNum
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowNum: Int
        switch section {
        case 0:
            rowNum = 2 // head state
        case 1:
            rowNum = 1 + curTeacher.priceList.count // price
        case 2:
            rowNum = 2 // map
        case 3:
            rowNum = 2 // time
        default:
            rowNum = 1 + curTeacher.imgList.count
        }
        return rowNum
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h = (getCInfo(indexPath).cls as! BaseCell.Type).getCellHeight(curTeacher, index: indexPath, otherData: self)
        return h
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return StaticCell.create(indexPath, tableView: tableView, data: curTeacher, ctrlr: self, delegate: self)
    }

    // BaseCellDelegate --------------------------------------------------------------

    func getCInfo(_ indexPath: IndexPath) -> BaseCell.CInfo {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return BaseCell.CInfo(id: "head", c: DetailHeadCell.self)
            default:
                return BaseCell.CInfo(id: "state", c: DetailStateCell.self)
            }
        case 1:
            switch indexPath.row {
            case 0:
                return BaseCell.CInfo(id: "priceT", c: DetailPriceTitleCell.self)
            default:
                return BaseCell.CInfo(id: "price", c: DetailPriceCell.self)
            }
        case 2:
            switch indexPath.row {
            case 0:
                return BaseCell.CInfo(id: "timeT", c: DetailTimeTitleCell.self)
            default:
                return BaseCell.CInfo(id: "time", c: DetailTimeCell.self)
            }
        case 3:
            switch indexPath.row {
            case 0:
                return BaseCell.CInfo(id: "mapT", c: DetailMapTitleCell.self)
            default:
                return BaseCell.CInfo(id: "map", c: DetailMapCell.self)
            }
        default:
            switch indexPath.row {
            case 0:
                return BaseCell.CInfo(id: "imgT", c: DetailImgTitleCell.self)
            default:
                return BaseCell.CInfo(id: "img", c: DetailImgCell.self)
            }
        }
    }

    func getIfUpdate(_ indexPath: IndexPath) -> Bool {
        return false
    }

    var staticCellDict: [String: StaticCell] = [:]
    func saveStaticCell(_ cell: StaticCell, by identifier: String) {
        staticCellDict[identifier] = cell
    }

    func getStaticCell(by identifier: String) -> StaticCell? {
        return staticCellDict[identifier]
    }

    // 回调 ==================================================================================================================

    func onBack() {
        DataMgr.unregister(key: DataObKey)
        let _ = navigationController?.popViewController(animated: true)
    }
}






