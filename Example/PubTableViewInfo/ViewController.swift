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
        
        // 1.创建一个 sectionModel
        let section1 = PubSectionModel.defaultSection()
        
        // 画一个view 当做一个cell
        section1.addCell(PubCellModel.createWithViewCell(color: .red, height: 100, viewDefine: { view in
            let label  = UILabel.init()
            label.backgroundColor = .green
            label.text = "hello swift"
            view.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }))
        
        // 添加一个自定义view 当做一个cell
        section1.addCell(PubCellModel.createWithViewCell(cView, color: .blue, height: 40))
        
        // 添加多个规则 cell
        section1.addCells(Array<Any>.arrayWithClassName(NSStringFromClass(CustomCell.self), height: 0, models: getModels()))
        
        
        
        // 2.再创建一个 sectionModel （带有点击事件）
        let section2 = PubSectionModel.defaultSection()
        section2.headerView = headerView
        section2.headerHeight = 50
        
        
        //添加一个cell 并且添加cell点击事件
        let cell = PubCellModel.initCellModel(className: NSStringFromClass(CustomCell.self), height: 0, model: CustomModel()).defaultClickCell({ cellModel in
            let cModel = cellModel.getModel() as? CustomModel
            print("---- \(cModel?.name ?? "")")
        })
        section2.addCell(cell)
        
        
        //添加多个数组
        let cells = Array<Any>.arrayWithClassName(NSStringFromClass(CustomCell.self), height: 0, models: getModels())
        
        // 给所有cell 添加cell点击事件
        let cellClick:ClickCell = {cellModel in
            let cModel = cellModel.getModel() as? CustomModel
            print("---- \(cModel?.name ?? "")")
        }
        cells.arrayAddDefaultClickCell(cellClick)
        
        //给所有cell 添加按钮添加点击事件
        let click:ClickCell = {cellModel in
            let cModel = cellModel.getModel() as? CustomModel
            print("----点击按钮 \(cModel?.name ?? "")")
        }
        cells.arrayAddDictWithClickEvents(["click":click])
    
        section2.addCells(cells)
        
        

        // 3.刷新列表
        tableViewInfo.resetDataList([section1,section2])
    }
    
    func getModels()->[CustomModel] {
        var list:[CustomModel] = [CustomModel]()
        
        let m1 = CustomModel()
        m1.name = "m1"
        list.append(m1)
        
        let m2 = CustomModel()
        m2.name = "m2"
        list.append(m2)
        
        let m3 = CustomModel()
        m3.name = "m3"
        list.append(m3)
        
        return list
    }
    
    lazy var cView:UIView = {
        let v = UIView.init()
        return v
    }()

    lazy var headerView:UIView = {
        let v = UIView.init()
        v.backgroundColor = .gray
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
    lazy var rightButton:UIButton = {
        let btn = UIButton()
        mainView.addSubview(btn)
        btn.backgroundColor = .brown
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return btn
    }()
    
    @objc func buttonClick() {
        if let model = self.model,let clickEvent = model.clickEvents["click"] as? ClickCell{
            clickEvent(model)
        }

    }
    
    override func updateConstraintsWithSnp() {
        super.updateConstraintsWithSnp()
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.height.equalTo(35)
            make.width.equalTo(60)
        }
    }
    override func setModel(_ model: PubCellModel) {
        super.setModel(model)
        let cModel = model.getModel() as? CustomModel
        titleLabel.text = cModel?.name ?? "defautName"
    }
}
