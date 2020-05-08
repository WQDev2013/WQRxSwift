//
//  RxSwiftTestViewController32.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/29.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController32: WQBaseViewController {

    var tableView:UITableView!
    var refreshButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        test1()
        test2()
        // Do any additional setup after loading the view.
    }

    func test2() {
        refreshButton = UIBarButtonItem.init(title: "刷新", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        cancelButton = UIBarButtonItem.init(title: "停止", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItems = [cancelButton,refreshButton]
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest{
                self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
            }
            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, Int>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
            })
        
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    func test1() {
        refreshButton = UIBarButtonItem.init(title: "刷新", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = refreshButton
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .throttle(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)//通过 throttle 设置个阀值（比如 1 秒），如果在1秒内有多次点击则只取最后一次，那么自然也就只发送一次数据请求
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult)
            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, Int>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
            })
        
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(DispatchTimeInterval.seconds(2), scheduler: MainScheduler.instance)
    }
}
