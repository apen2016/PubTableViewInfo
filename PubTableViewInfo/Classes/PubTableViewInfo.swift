//
//  PubTableViewInfo.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/9/26.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import SwiftUI
import MachO

public class PubTableViewInfo:NSObject,PubCellDataListProtocol {
    public var scrollNeedEndEdit: Bool = false
    public var tableView:PubBaseTableView
    public var dataList:[PubSectionModel] = []
    public var tableViewStyle:UITableView.Style {
        didSet {
            self.tableView.removeFromSuperview()
            self.tableView = PubBaseTableView.init(frame: CGRect.zero, style: tableViewStyle)
            self.setupDelegate()
        }
    }
    //UITableViewDelegate 避免循环引用
   public weak var tableViewDelegate:UITableViewDelegate? {
        didSet {
            self.tableView.delegate = tableViewDelegate
        }
    }
    //UITableViewDataSource 避免循环引用
    public weak var tableViewDataSource:UITableViewDataSource?{
        didSet {
            self.tableView.dataSource = tableViewDataSource
        }
    }
    //真实的 UITableViewDelegate
    public var delegate:UITableViewDelegate? {
        didSet {
            tableView.delegate = delegate
        }
    }
    
   public override init() {
        self.tableViewStyle = .grouped
        self.tableView = PubBaseTableView.init(frame: CGRect.zero, style: tableViewStyle)
        super.init()
        setupDelegate()
    }
    
    public func setupDelegate(){
       //默认自适应高度
       self.delegate = PubBaseTableViewEstimatedDelegate.init(self)
       self.tableViewDelegate = self.delegate
       self.tableViewDataSource = self
       
    }
    
    //侧滑删除
    public func setupEditDelegate(_ delegate:PubBaseTabelViewEditDelegate){
        self.delegate = delegate
        self.tableViewDataSource = delegate
    }

    //刷新数据
    public func resetDataList(_ dataList:[PubSectionModel]){
        self.dataList = dataList
        reloadData()
    }
    
    //IndexPath --> PubCellModel
    public func getCellModelWithIndexPath(_ indexPath:IndexPath) -> PubCellModel{
        let section = dataList[indexPath.section]
        let model = section.rowList[indexPath.row]
        return model
    }

    //PubCellModel --> IndexPath
    public func getIndexPathWithCellModel(_ cellModel:PubCellModel) -> NSIndexPath? {
        for (index,sectionModel) in dataList.enumerated() {
            let row = sectionModel.getRowWithCellModel(cellModel)
            if let foundRow = row {
                return NSIndexPath.init(row: foundRow, section: index)
            }
        }
        return nil
    }
     // MARK: -映射tableView
    public func reloadData() {
        tableView.reloadData()
    }

}

 // MARK: -UITableViewDataSource
extension PubTableViewInfo:UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = dataList[section]
        return sectionModel.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = getCellModelWithIndexPath(indexPath)
        let cls = NSClassFromString(model.className) as? PubBaseTableViewCell.Type
        if cls != nil {
            let cell =  cls!.initCell(model: model, tableView: tableView)
            return cell
        }
        return UITableViewCell()
        
    }
}
