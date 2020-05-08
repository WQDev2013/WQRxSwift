//
//  RxSwiftTestViewController43.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/10.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController43: WQBaseViewController {

    var startBtn: UIBarButtonItem!
    var cancelBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
//        test2()
//        test3()
        test4()
        // Do any additional setup after loading the view.
    }
    
    //请求与取消
    func test4() {
        startBtn = UIBarButtonItem.init(title: "开始", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        cancelBtn = UIBarButtonItem.init(title: "取消", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItems = [startBtn,cancelBtn]
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //发起请求按钮点击
        startBtn.rx.tap.asObservable()
            .flatMap {
                URLSession.shared.rx.data(request: request)
                    .takeUntil(self.cancelBtn.rx.tap) //如果“取消按钮”点击则停止请求
            }
            .subscribe(onNext: {
                data in
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：", str ?? "")
            }, onError: { error in
                print("请求失败！错误原因：", error)
            }).disposed(by: disposeBag)
        
    }
    //通过 rx.data 请求数据
    func test3() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("请求成功！返回的数据是：", str ?? "")
        }).disposed(by: disposeBag)
    }
    //返回失败404
    func test2() {
        //创建URL对象
        let urlString = "https://www.douban.com/xxxxxxxxxx/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.response(request: request).subscribe(onNext: {
            (response, data) in
            //判断响应结果状态码
            if 200 ..< 300 ~= response.statusCode {
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：", str ?? "")
            }else{
                print("请求失败！")
            }
        }).disposed(by: disposeBag)
    }

    //通过 rx.response 请求数据
    func test1() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.response(request: request).subscribe(onNext: {
            (response, data) in
            //数据处理
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("返回的数据是：", str ?? "")
        }).disposed(by: disposeBag)
    }
}
