//
//  RxSwiftTestViewController44.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/10.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController44: WQBaseViewController {

    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        test1()
//        test2()
//        test3()
        test4()
        // Do any additional setup after loading the view.
    }
    //将获取到的豆瓣频道列表数据转换成 JSON 对象，并绑定到表格上显示。
    func test4() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //获取列表数据
        let data = URLSession.shared.rx.json(request: request)
            .map{ result -> [[String: Any]] in
                if let data = result as? [String: Any],
                    let channels = data["channels"] as? [[String: Any]] {
                    return channels
                }else{
                    return []
                }
        }
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element["name"]!)"
            return cell
            }.disposed(by: disposeBag)
    }
    //直接使用 RxSwift 提供的 rx.json 方法去获取数据，它会直接将结果转成 JSON 对象
    func test3() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.json(request: request).subscribe(onNext: {
            data in
            let json = data as! [String: Any]
            print("--- 请求成功！返回的如下数据 ---")
            print(json )
        }).disposed(by: disposeBag)
        
    }
    //在订阅前就进行转换
    func test2() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request)
            .map {
                try JSONSerialization.jsonObject(with: $0, options: .allowFragments)
                    as! [String: Any]
            }
            .subscribe(onNext: {
                data in
                print("--- 请求成功！返回的如下数据 ---")
                print(data)
            }).disposed(by: disposeBag)
    }
    
    func test1() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let json = try? (JSONSerialization.jsonObject(with: data, options: .allowFragments)
                as! [String: Any])
            print("--- 请求成功！返回的如下数据 ---")
            print(json!)
        }).disposed(by: disposeBag)
    }
    
}
