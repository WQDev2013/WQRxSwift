//
//  RxSwiftTestViewController27.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/27.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController27: WQBaseViewController {

    var userVM = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        test1()
        test2()
        // Do any additional setup after loading the view.
    }
    func test2() {
        //输入内容是hangge，label内容改变
        view.addSubview(textField)
        view.addSubview(label)
        
        //将用户名与textField做双向绑定
        _ =  self.textField.rx.textInput <->  self.userVM.username
        
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
    }
    func test1() {
        view.addSubview(textField)
        view.addSubview(label)
        //将用户名与textField做双向绑定
        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
        
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
    }

    lazy var textField: UITextField = {
        let text = UITextField(frame: CGRect(x:10, y:180, width:200, height:30))
        text.borderStyle = UITextField.BorderStyle.roundedRect
        return text
    }()

    lazy var label: UILabel = {
        let lab = UILabel(frame: CGRect(x:10, y:280, width:200, height:30))
        return lab
    }()
}
