//
//  PubCreateViewCell.swift
//  MainPart_IOS
//
//  Created by 林其鹏 on 2022/9/26.
//  Copyright © 2022 七十迈数字科技移动软件. All rights reserved.
//

import Foundation
import UIKit


open class PubCreateViewCell:PubBaseTableViewCell {
    
    override class func initCell(model:PubCellModel,tableView:UITableView) -> PubBaseTableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: Self.getIdentifier()) as? PubBaseTableViewCell
        if cell == nil {
            cell = Self.init(style: .default, reuseIdentifier: Self.getIdentifier())
        }
        cell?.setModel(model)
        return cell!
    }
    
    open override func setModel(_ model: PubCellModel) {
        super.setModel(model)
        for subView in self.mainView.subviews {
            subView.removeFromSuperview()
        }
        let tempV = model.data["view"] as? UIView
        if let view = tempV {
            self.mainView.addSubview(view)
            if let bgColor = model.backColor {
                view.backgroundColor = bgColor
            }
            view.snp.makeConstraints { make in
                make.edges.equalTo(0)
            }
            if model.height > 0 {
                self.mainView.snp.updateConstraints{ make in
                    make.edges.equalTo(0)
                    make.height.equalTo(model.height).priority(.low)
                }
            }else {
                self.mainView.snp.updateConstraints { make in
                    make.edges.equalTo(0)
                }
            }
            view.setNeedsUpdateConstraints()
        }
    }
}

 
