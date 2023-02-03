//
//  ViewController.swift
//  PubTableViewInfo
//
//  Created by linqipeng on 02/03/2023.
//  Copyright (c) 2023 linqipeng. All rights reserved.
//

import UIKit
import PubTableViewInfo

class ViewController: UIViewController {
    
    lazy var tableViewInfo:PubTableViewInfo = {
        let info = PubTableViewInfo()
        self.view.addSubview(info.tableView)
        info.tableView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(88)
        }
        return info
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCell()
    }
    
    func setupCell(){
        
        let section = PubSectionModel.defaultSection()
        
        // 画一个view 当做一个cell
        section.addCell(PubCellModel.createWithViewCell(color: .red, height: 100, viewDefine: { view in
            let label  = UILabel.init()
            label.backgroundColor = .gray
            label.text = "hello swift"
            view.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }))
        
        // 添加一个自定义view 当做一个cell
        section.addCell(PubCellModel.createWithViewCell(cView, color: .green, height: 40))
        
        // 添加多个规则 cell
        section.addCells(Array<Any>.arrayWithClassName(NSStringFromClass(CustomCell.self), height: 0, models: getModels()))
        
        tableViewInfo.resetDataList([section])
    }
    
    func getModels()->[CustomModel] {
        var list:[CustomModel] = [CustomModel]()
        
        let m1 = CustomModel()
        m1.name = "m1"
        list.append(m1)
        
        let m2 = CustomModel()
        m2.name = "m2"
        list.append(m1)
        
        let m3 = CustomModel()
        m3.name = "m3"
        list.append(m1)
        
        return list
    }
    
    lazy var cView:UIView = {
        let v = UIView.init()
        return v
    }()

    
}

class CustomModel:PubBaseModel {
    var name:String?
}

class CustomCell:PubBaseTableViewCell {
    lazy var titleLabel:UILabel = {
        let v = UILabel()
        v.backgroundColor = .red
        mainView.addSubview(v)
        return v
    }()
    
    override func updateConstraintsWithSnp() {
        super.updateConstraintsWithSnp()
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
    }
    override func setModel(_ model: PubCellModel) {
        super.setModel(model)
        let cModel = model.getModel() as? CustomModel
        titleLabel.text = cModel?.name
    }
}
