//
//  RxSwiftTestViewController22.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/26.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController22: WQBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        test1()
//        test2()
//        test3()
//        test4()
        test5()
        
    }
    ///MARK--UITextView独有的方法
    func test5() {
        let textView = UITextView(frame: CGRect(x:10, y:180, width:200, height:30))
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        self.view.addSubview(textView)
        //开始编辑响应
        textView.rx.didBeginEditing
            .subscribe(onNext: {
                print("开始编辑")
            })
            .disposed(by: disposeBag)
        
        //结束编辑响应
        textView.rx.didEndEditing
            .subscribe(onNext: {
                print("结束编辑")
            })
            .disposed(by: disposeBag)
        
        //内容发生变化响应
        textView.rx.didChange
            .subscribe(onNext: {
                print("内容发生改变")
            })
            .disposed(by: disposeBag)
        
        //选中部分变化响应
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)
    }
    func test4() {
        //区号输入
        let username = UITextField(frame: CGRect(x:10, y:180, width:200, height:30))
        username.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(username)
        
        //电话输入
        let password = UITextField(frame: CGRect(x:10, y:250, width:200, height:30))
        password.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(password)
        //在用户名输入框中按下 return 键
        username.rx.controlEvent(.editingDidEndOnExit).subscribe({
            [weak self] (_) in
            password.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        //在密码输入框中按下 return 键
        password.rx.controlEvent(.editingDidEndOnExit).subscribe({
            [weak self] (_) in
            password.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    func test3() {
        //区号输入
        let textField1 = UITextField(frame: CGRect(x:10, y:180, width:200, height:30))
        textField1.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField1)
        
        //电话输入
        let textField2 = UITextField(frame: CGRect(x:10, y:250, width:200, height:30))
        textField2.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField2)
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:290, width:300, height:30))
        self.view.addSubview(label)
        
        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty) {
            textValue1, textValue2 -> String in
            return "你输入的号码是：\(textValue1)-\(textValue2)"
            }
            .map { $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
    func test2() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:180, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:250, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:290, width:300, height:30))
        self.view.addSubview(label)
        
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:330, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        
        //当文本框内容改变
        let input = inputField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
            .throttle(DispatchTimeInterval.milliseconds(900)) //在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框中
        input.drive(outputField.rx.text)
            .disposed(by: disposeBag)
        
        //内容绑定到文本标签中
        input.map{ "当前字数：\($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    func test1(){
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:180, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField)
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                //未获得焦点就执行一次
                print("1您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.changed
            .subscribe(onNext: {
                print("2您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
    }

    
}
