//
//  RxSwiftTestViewController25.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/27.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController25: WQBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
        // Do any additional setup after loading the view.
    }
    

    func test2() {
        view.addSubview(mySwitch)
        mySwitch.rx.value
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
    }
    func test1() {
        view.addSubview(mySwitch)
        view.addSubview(activityIndicator)
        mySwitch.rx.value
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }

    lazy var mySwitch: UISwitch = {
        let btn: UISwitch = UISwitch(frame: CGRect(x: 100, y: 130, width: 50, height: 40))
        btn.frame = CGRect(x:120, y:130, width:60, height:30)
        return btn
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        view.frame = CGRect(x: 200, y: 130, width: 50, height: 40)
        return view
    }()
}
