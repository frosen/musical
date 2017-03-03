//
//  DetailViewController.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class DetailViewController: BaseController, DataOB, UITableViewDelegate, UITableViewDataSource, StaticCellDelegate {

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

        UITools.createNavBackBtn(self, action: #selector(DetailViewController.onBack))

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
        tableView.bounces = false

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
        IndexPath(row: 0, section: 1),
        IndexPath(row: 1, section: 3),
        IndexPath(row: 1, section: 4)
    ] // 静态cell，但是又需要通过setData变化的

    func onFetchData(suc: Bool, data: Teacher?) {
        guard suc else {
            return
        }

        curTeacher = data
        sectionNum = 6

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
//        let rowNum: Int
//        switch section {
//        case 0:
//            rowNum = 5 //title + detail + promise + time + location
//        case 1:
//            //head 友 敌 ob. 如果是乱斗应该是不分敌友的所以是2行，但暂时不考虑；
//            rowNum = 4 //友一定有自己，敌和ob如果没有也有个标题表示没有的状态
//        case 2:
//            rowNum = 2 // head body 就算是没有图片时，也应该有个默认的图
//        case 3:
//            rowNum = 2 + tmpMsgList.list.count + (msgContainer?.msgList.count ?? 0) // head + tail + 临时对话(s) + 对话(s)
//        default:
//            rowNum = 0
//        }
////        print("TTT section\(section) has \(rowNum) rows")
//        return rowNum
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let s = indexPath.section
//        let r = indexPath.row
//        if let h = cellHeightDict[getCellHeightDictIndex(section: s, row: r)] {
////            print("TTT indexPath \(indexPath) height is \(h) (old)")
//            return h
//        }
//
//        var data: BaseData = curEvent
//        if s == msgSectionIndex { // msg的cell使用不同的数据源
//            if let msgStru = getMsgCellData(by: r) {
//                data = msgStru
//            }
//        }
//        let height: CGFloat = (getCInfo(indexPath).cls as! BaseCell.Type).getCellHeight(data, index: indexPath, otherData: self)
//
//        cellHeightDict[getCellHeightDictIndex(section: s, row: r)] = height
////        print("TTT indexPath \(indexPath) height is \(height)")
//        return height
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return StaticCell.create(indexPath, tableView: tableView, data: curTeacher, ctrlr: self, delegate: self)
    }

    // BaseCellDelegate --------------------------------------------------------------

    func getCInfo(_ indexPath: IndexPath) -> BaseCell.CInfo {
        return BaseCell.CInfo(id: "11", c: DetailViewController.self)
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






