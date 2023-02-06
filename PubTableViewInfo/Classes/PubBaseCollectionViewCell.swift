//
//  PubBaseCollectionViewCell.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/10/24.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import SnapKit

open class PubBaseCollectionViewCell:UICollectionViewCell {
    
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        updateConstraintsWithSnp()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        updateConstraintsWithSnp()
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
