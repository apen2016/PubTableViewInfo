//
//  PubCellModel.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/9/26.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import UIKit

//cell 点击事件
public typealias ClickCell = (PubCellModel)->Void
//cell 点击事件返回 CellModel IndexPath
public typealias ClickEventAction = (PubCellModel,IndexPath)->Void
//cell 侧滑删除事件
public typealias DeleteEventAction = (PubCellModel,IndexPath)->Void

public let clickCellAction:String = "clickCell"
public let clickEventAction:String = "clickEvent"
public let deleteAction:String = "deleteCell"

public class PubCellModel:NSObject {
    //cell类名
    public var className:String = ""
    //CollectionViewCell ItemSize
    public var size:CGSize = CGSize.zero
    
    //行高
    var height:CGFloat = 0.0

    //背景颜色
    var backColor:UIColor?

    //选中Cell
    public var isSelectd:Bool = false
    
    //最后一个Cell
    public var isLastCell:Bool = false
    
    //缺省
    public var type:Int?
    
    //数据集合
    public lazy var data:Dictionary<String,Any> = [:]
    
    //点击事件集合
    public lazy var clickEvents:Dictionary<String,Any> = [:]
    
    
    /// 初始化cellModel
    /// - Parameters:
    ///   - className: 类名称
    ///   - height: 高度 自适应模式 高度无效
    ///   - model: 数据源
    public static func initCellModel(className:String,height:CGFloat,model:Any)->PubCellModel {
        let data:Dictionary<String,Any> = ["model":model]
        let cellModel = self.init(className: className, height: height, data: data)
        return cellModel
    }
    
    /// 初始化cellModel  用于创建一些简单样式的cell
    /// - Parameters:
    ///   - className: 类名称
    ///   - height: 高度
    ///   - data: 数据
    ///   - clickEvents:点击事件集合
   convenience required init(className:String,height:CGFloat,data:Dictionary<String,Any>) {
        self.init()
        self.className = className
        self.height = height
        self.data = data
    }
    
    
    /// 初始化cellModel（用于UICollectionViewCell）
    /// - Parameters:
    ///   - className: cell类名
    ///   - size: cell大小
    ///   - model: 数据源
    public static func initCellModel(className:String,size:CGSize,model:Any)->PubCellModel {
        let data:Dictionary<String,Any> = ["model":model]
        let cellModel = self.init(className: className, height: 0, data: data)
        cellModel.size = size
        return cellModel
    }
    
    //添加cell点击事件
    @discardableResult
    public func defaultClickCell(_ clickCell:ClickCell?) -> PubCellModel{
        var action = clickCell
        if action == nil {
            action = { cellModel in
                print("默认点击Cell未实现～～")
            }
        }
        return addDictWithClickEvents([clickCellAction:action! as Any])
    }
    
    //添加cell上的其他点击事件
    @discardableResult
    public func addDictWithClickEvents(_ dict:[String:Any]) -> PubCellModel{
        for (key,value) in dict {
            self.clickEvents[key] = value
        }
        return self
    }
    

    public func getModel()->AnyObject? {
        return data["model"] as AnyObject?
    }
    
    //链式调用
    public func changeSelf(_ changeSelf:(PubCellModel)->Void)-> PubCellModel {
        changeSelf(self)
        return self
    }
    
    //创建一个CellModel  传入一个view 生成特定的PubCreateViewCell
    public static func createWithViewCell(_ view:UIView,color:UIColor?,height:CGFloat) -> PubCellModel {
        let data:Dictionary<String,Any> = ["view":view]
        let cellModel = PubCellModel.init(className:NSStringFromClass(PubCreateViewCell.self), height: height, data: data)
        cellModel.backColor = color
        return cellModel
    }
    //创建一个CellModel 免写View 生成特定的PubCreateViewCell
    public static func createWithViewCell(color:UIColor?,height:CGFloat,viewDefine:(UIView)->Void)->PubCellModel {
        let view = UIView.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        viewDefine(view)
        let cellModel = self.createWithViewCell(view, color: color, height: height)
        return cellModel
    }
}

public extension Array{
    
    ///model数组 --> CellModel 数组
    static func arrayWithClassName(_ className:String,height:CGFloat,models:Array<Any>) -> Array<PubCellModel> {
        
        var list:Array<PubCellModel> = []
        for item in models {
            let cellModel = PubCellModel.initCellModel(className: className, height: height, model: item)
            list.append(cellModel)
        }
        return list
    }
    ///model数组 --> CellModel 数组(用于collectionViewCell)
    static func arrayWithClassName(_ className:String,size:CGSize,models:Array<Any>) -> Array<PubCellModel> {
        
        var list:Array<PubCellModel> = []
        for item in models {
            let cellModel = PubCellModel.initCellModel(className: className, size: size, model: item)
            list.append(cellModel)
        }
        return list
    }
    
    ///给每个CellModel 添加cell点击事件
    @discardableResult
    func arrayAddDefaultClickCell(_ clickCell:ClickCell?) -> Array<PubCellModel> {

        return arrayModifyWith { cellModel in
            cellModel.defaultClickCell(clickCell)
        }
    }
    
    ///给每个CellModel 添加其他点击事件
    @discardableResult
    func arrayAddDictWithClickEvents(_ dict:[String:Any]) -> Array<PubCellModel> {
        return arrayModifyWith { cellModel in
            cellModel.addDictWithClickEvents(dict)
        }
    }

    ///修改CellModel
    func arrayModifyWith(_ modify:(PubCellModel)->Void) ->  Array<PubCellModel> {

        for cellModel in self {
            modify(cellModel as! PubCellModel)
        }
        return self as! Array<PubCellModel>
    }
}
