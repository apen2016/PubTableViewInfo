//
//  PubBaseCollectionViewDataDelegate.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/10/24.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import UIKit

open class PubBaseCollectionViewDataDelegate:PubBaseDataListDelegate {}

extension PubBaseCollectionViewDataDelegate:UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let seticonModel = self.dataList[section]
        return seticonModel.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = getCellModelWithIndexPath(indexPath)
        let cls = NSClassFromString(cellModel.className) as? PubBaseCollectionViewCell.Type
        if cls != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cls!.getIdentifier(), for: indexPath) as! PubBaseCollectionViewCell
            cell.setModel(cellModel)
            return cell
        }else{
            assert((cls != nil), String(format: "引入无效的cellClass",cellModel.className))
            return UICollectionViewCell.init()
        }
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let seticonModel = dataList[indexPath.section]
        var reusablebview:PubBaseCollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            let header = seticonModel.sectionInfo[SectionModelHeader] as? String
            if let identifier = header {
                reusablebview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? PubBaseCollectionReusableView
                reusablebview?.setSection(seticonModel)
            }
        }
        if kind == UICollectionElementKindSectionFooter {
            let footer = seticonModel.sectionInfo[SectionModelFooter] as? String
            if let identifier = footer {
                reusablebview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? PubBaseCollectionReusableView
                reusablebview?.setSection(seticonModel)
            }
        }
        return reusablebview ?? UICollectionReusableView()
    }
}
