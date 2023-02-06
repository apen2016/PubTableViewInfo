//
//  PubSectionModel+Extension.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/10/24.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation

public let SectionModelHeader = "SectionModelHeader"
public let SectionModelFooter = "SectionModelFooter"

extension PubSectionModel {
    
    /// seticonHeader
    /// - Parameter headerClass: 必须继承UICollectionReusableView
    public func setCollectionHeader(_ headerClass:String) {
        sectionInfo[SectionModelHeader] = headerClass
    }
    
    /// sectionFooter
    /// - Parameter footerClass: 必须继承于UICollectionReusableView
    public func setCollectionFooter(_ footerClass:String) {
        sectionInfo[SectionModelFooter] = footerClass
    }
}
