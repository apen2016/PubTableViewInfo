//
//  PubSectionModel.swift
//  MainPart_IOS
//
//  Created by 林其鹏 on 2022/9/26.
//  Copyright © 2022 七十迈数字科技移动软件. All rights reserved.
//

import Foundation
import UIKit

public class PubSectionModel:NSObject {
    
    public var count:Int {
        rowList.count
    }
    
    public var headerView:UIView?
    public var footerView:UIView?
    public var headerHeight:CGFloat = 0.01
    public var footerHeight:CGFloat = 0.01
    
    //缺省
    public var type:Int?
    
    //section数据集合
    public lazy var sectionInfo:Dictionary<String,Any> = [:]
    
    //cellModel列表
    public lazy var rowList:[PubCellModel] = []
    
    //创建SectionModel
    public static func defaultSection () -> PubSectionModel {
        let section = PubSectionModel.init()
        return section
    }

    //cellModel --> Int
    public func getRowWithCellModel(_ cellModel:PubCellModel) -> Int? {
        for (index,model) in self.rowList.enumerated() {
            if model == cellModel { return index }
        }
        return nil
    }
    
    //Int --> CellModel
    public func getRow(_ row:Int)->PubCellModel {
        return rowList[row]
    }
    
    //添加CellModel
    public func addCell(_ cellModel:PubCellModel) {
        rowList.append(cellModel)
    }
    
    //添加CellModel数组
    public func addCells(_ cells:Array<PubCellModel>) {
        for cell in cells {
            rowList.append(cell)
        }
    }
     // MARK: - sectionInfo相关
    public func setModel(_ model:Any){
        sectionInfo["model"] = model
    }
    public func getModel()-> Any {
        return sectionInfo["model"]
    }
    
}
 

