//
//  CustomSection.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/30.
//  Copyright © 2019 cwq. All rights reserved.
//

//自定义Section
struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

