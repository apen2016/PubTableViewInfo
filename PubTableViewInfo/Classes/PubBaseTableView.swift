//
//  PubBaseTableView.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/9/26.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import UIKit

open class PubBaseTableView:UITableView {
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
        self.backgroundColor = UIColor.clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false;
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0;
        }
        if #available(iOS 11.0, *){
            self.contentInsetAdjustmentBehavior = .never;
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
