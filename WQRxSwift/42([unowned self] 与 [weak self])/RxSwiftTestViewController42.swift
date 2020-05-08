//
//  RxSwiftTestViewController42.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/10.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController42: WQBaseViewController {

    deinit {
        print(#file, #function)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textField)
        view.addSubview(label)
        test1()
//        test2()
        // Do any additional setup after loading the view.
    }
    //输入后立即返回，会崩溃
    func test3() {
        textField.rx.text.orEmpty.asDriver().drive(onNext: {
            [unowned self] text in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                print("当前输入内容：\(String(describing: text))")
                self.label.text = text
            }
            
        }).disposed(by: disposeBag)
    }
    //正常释放
    func test2() {
        textField.rx.text.orEmpty.asDriver().drive(onNext: {
            [weak self] text in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                print("当前输入内容：\(String(describing: text))")
                self?.label.text = text
            }
            
        }).disposed(by: disposeBag)
    }
    //页面不释放
    func test1() {
        textField.rx.text.orEmpty.asDriver().drive(onNext: {
            text in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                print("当前输入内容：\(String(describing: text))")
                self.label.text = text
            }
        }).disposed(by: disposeBag)
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
