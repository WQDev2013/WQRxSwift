//
//  UserViewModel.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/29.
//  Copyright © 2019 cwq. All rights reserved.
//

struct UserViewModel {
    //用户名
    let username = BehaviorRelay(value: "guest")
    
    //用户信息
    lazy var userinfo = {
        return self.username.asObservable()
            .map{ $0 == "hangge" ? "您是管理员" : "您是普通访客" }
            .share(replay: 1)
    }()
}
