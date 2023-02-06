//
//  PubBaseCollectionView.swift
//  TableViewInfo
//
//  Created by 林其鹏 on 2022/10/24.
//  Copyright © 2022 linqipeng. All rights reserved.
//

import Foundation
import UIKit

open class PubBaseCollectionView:UICollectionView {
    
    lazy var registerClasses:[String:String] = [:]
    
    public override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        let clsName = registerClasses[identifier]
        if clsName == nil {
            self.register(NSClassFromString(identifier), forCellWithReuseIdentifier: identifier)
            registerClasses[identifier] = identifier
        }
        return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    public override func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
        let clsName = registerClasses[identifier]
        if clsName == nil {
            self.register(NSClassFromString(identifier), forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
            registerClasses[identifier] = identifier
        }
        return super.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: indexPath)
    }

    public override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false;
        if #available(iOS 11.0, *){
            self.contentInsetAdjustmentBehavior = .never;
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
