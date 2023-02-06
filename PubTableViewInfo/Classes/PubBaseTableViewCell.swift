//
//  PubBaseTableViewCell.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/9/26.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import UIKit

open class PubBaseTableViewCell:UITableViewCell {
    
    static var cellHeight:CGFloat = 0.0
    
    public static func getIdentifier() -> String {
        let identifier = NSStringFromClass(self)
        return identifier
    }
    
    ///cell 主视图
    public lazy var mainView:UIView = {
        let v = UIView()
        self.contentView.addSubview(v)
        return v
    }()
    
    open override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    public var model:PubCellModel?
    
    public required override init(style:UITableViewCell.CellStyle,reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    class func initCell(model:PubCellModel,tableView:UITableView) -> PubBaseTableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: Self.getIdentifier()) as? PubBaseTableViewCell
        if cell == nil {
            cell = Self.init(style: .default, reuseIdentifier: Self.getIdentifier())
            cell?.setupViews()
            cell?.updateConstraintsWithSnp()
        }
        cell?.setModel(model)
        return cell!
    }
    //子类重写，控件添加到mainView
    open func setupViews(){
        
    }
    
   open func updateConstraintsWithSnp(){
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
   open func setModel(_ model:PubCellModel){
        self.model = model
    }
    
    
}
