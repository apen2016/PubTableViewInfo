//
//  PubCollectionViewInfo.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/10/24.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import UIKit

public class PubCollectionViewInfo:NSObject,PubCellDataListProtocol {
    
    public var scrollNeedEndEdit: Bool = false
    //CollectionViewCell Size
    public var itemSize:CGSize = CGSize.zero
    
    public var dataList:[PubSectionModel] = []
    
    public var dataSourceDelegate:UICollectionViewDataSource? {
        didSet {
            self.collectionView.dataSource = dataSourceDelegate
        }
    }
    public weak var collectionViewDelegate:UICollectionViewDelegate? {
        didSet {
            self.collectionView.delegate = collectionViewDelegate
        }
    }
    
    public lazy var collectionViewLayout:UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        return layout
    }()
    public lazy var collectionView:PubBaseCollectionView = {
        let v = PubBaseCollectionView.init(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout)
        return v
    }()
    
    public override init() {
        super.init()
        initCollectionView()
    }
    
    func initCollectionView() {
        collectionView.backgroundColor = .clear
        dataSourceDelegate = PubBaseCollectionViewDataDelegate.init(self)
        collectionViewDelegate = self
    }
    
   public func addSubViewInView(_ view:UIView) {
       view.addSubview(collectionView)
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
    //删除cellModel
    public func deleteCellModel(_ seciton:Int,row:Int) {
        for (index,sectionModel) in dataList.enumerated() {
            if index == seciton {
                sectionModel.rowList.remove(at: row)
            }
            if sectionModel.count == 0{
                dataList.remove(at: index)
            }
        }
    }
    
    // MARK: -映射collectionView
   public func reloadData() {
        self.collectionView.reloadData()
    }


}

extension PubCollectionViewInfo:UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellModel = self.getCellModelWithIndexPath(indexPath)
        if __CGSizeEqualToSize(cellModel.size, CGSize.zero){
            return self.itemSize
        }
        return cellModel.size
    }
}
extension PubCollectionViewInfo:UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
}
