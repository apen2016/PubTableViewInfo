//
//  PubCellDataListDelegate.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/9/27.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import UIKit


 // MARK: -协议
public protocol PubCellDataListProtocol: NSObject {
    var dataList:Array<PubSectionModel> { get set }
    var scrollNeedEndEdit:Bool { get set }
}

 // MARK: - 滑动相关
open class PubBaseDataListDelegate:NSObject,UIScrollViewDelegate {
    
   public weak var dataListDelegate:PubCellDataListProtocol?
    
    public var dataList:Array<PubSectionModel>{
        dataListDelegate!.dataList
    }
    public func getCellModelWithIndexPath(_ indexPath:IndexPath) -> PubCellModel{
        let section = dataList[indexPath.section]
        let model = section.rowList[indexPath.row]
        return model
    }
    
    public init(_ dataListDelegate:PubCellDataListProtocol) {
        self.dataListDelegate = dataListDelegate
    }
    
    ///ScrollView代理方法
    open func scrollViewDidScroll(_ scrollView: UIScrollView) { }
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {}
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}
}

 // MARK: -自适应代理
open class PubBaseTableViewEstimatedDelegate:PubBaseDataListDelegate,UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = getCellModelWithIndexPath(indexPath)
        
        let clickCell = model.clickEvents[clickCellAction] as? ClickCell
        if let click = clickCell {
            click(model)
            return
        }
        
        let clickEvent = model.clickEvents[clickEventAction] as? ClickEventAction
        if let click = clickEvent {
            click(model,indexPath)
        }
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = dataList[section]
        if let view = sectionModel.headerView {
            return view
        }
        return UIView.init()
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionModel = dataList[section]
        if let view = sectionModel.footerView {
            return view
        }
        return UIView.init()
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = dataList[section]
        return sectionModel.headerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionModel = dataList[section]
        return sectionModel.footerHeight
    }
    
    public override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let delegate = dataListDelegate,delegate.scrollNeedEndEdit {
            scrollView.superview?.endEditing(true)
        }
    }
}

 // MARK: -固定高度代理
open class PubBaseTableViewNormalDelegate:PubBaseTableViewEstimatedDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = dataList[indexPath.section]
        let cellModel = sectionModel.rowList[indexPath.row]
        return cellModel.height
    }
    
}

 // MARK: -侧滑删除代理
open class PubBaseTabelViewEditDelegate:PubBaseTableViewEstimatedDelegate,UITableViewDataSource {
    
    open func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
       return "default"
   }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       let model = getCellModelWithIndexPath(indexPath)
       let action = model.clickEvents[deleteAction] as? DeleteEventAction
       action?(model,indexPath)
   }
   
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       return .delete
   }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
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

