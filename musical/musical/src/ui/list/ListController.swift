//
//  ListController.swift
//  musical
//
//  Created by luleyan on 2017/2/23.
//  Copyright © 2017年 fffff. All rights reserved.
//

import UIKit

class ListController: BaseTabController, DataOB, UITableViewDelegate, UITableViewDataSource, BaseCellDelegate {
    private var dataPage: Int = 1
    private var tableView: UITableView! = nil

    private var curTeachers: [Teacher] = []

    override func viewDidLoad() {
        initDataOnViewAppear = true
        super.viewDidLoad()
        print("教师列表页面")
        
        //创建tableView
        tableView = UITableView(frame: baseView.bounds, style: .grouped)
        baseView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none //极简风
        tableView.backgroundColor = UIColor.white

        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -3) //否则滚动条和屏幕边会有一段间隔
    }

    let DataObKey = "ChallengeController"
    override func initData() {
        DataMgr.register(observer: self, key: DataObKey)
        APP.teacherListMgr.fetch(obKey: DataObKey) { suc, teachers in
            onFetchData(suc: suc, data: teachers)
        }
    }

    func onFetchData(suc: Bool, data: [Teacher]) {
        if suc {
            curTeachers = data
            tableView.reloadData()
        } else {

        }
    }

    //table view =============================================================================================

    func numberOfSections(in tableView: UITableView) -> Int {
        return curTeachers.count //因为要利用section的head作为留白，所以每个section就是一行数据
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //section用于记录数据了，所以其中的row数量就是1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20 //数据行之间的留白
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListCell.getCellHeight()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return BaseCell.create(indexPath, tableView: tableView, data: curTeachers[indexPath.section], ctrlr: self, delegate: self)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let t: Teacher = curTeachers[indexPath.section]
        enterDetail(id: t.ID)
    }

    // BaseCellDelegate --------------------------------------------------------------

    func getCInfo(_ indexPath: IndexPath) -> BaseCell.CInfo {
        return BaseCell.CInfo(id: "LCId", c: ListCell.self)
    }

    // function --------------------------------------------------------------

    func enterDetail(id: DataID) {

    }
}
