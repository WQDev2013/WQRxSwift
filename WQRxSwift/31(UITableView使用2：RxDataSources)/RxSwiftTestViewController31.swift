//
//  RxSwiftTestViewController31.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/29.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController31: WQBaseViewController {

    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
//            test2()
//        test3()
        test4()
        // Do any additional setup after loading the view.
    }
    //4，多分区的 UITableView
    //MARK:方式二：使用自带的Section
    func test4() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let sections = Observable.just([
            MySection(header: "基本控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ]),
            MySection(header: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"
                
                return cell
        },
            //设置分区头标题
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        }
        )
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    //MARK:方式二：使用自定义的Section
    func test3() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let items = Observable.just([
            SectionModel(model: "基本控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ]),
            SectionModel(model: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, String>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(element)"
                return cell
            })
        
        //设置分区头标题
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].model
        }
        
        //设置分区尾标题
        //dataSource.titleForFooterInSection = { ds, index in
        //    return "footer"
        //}
        
        //绑定单元格数据
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    //========================//
    //MARK:方式二：使用自定义的Section
    func test2() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let sections = Observable.just([
            MySection(header: "", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"
                
                return cell
        })
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    //MARK:方式一：使用自带的Section
    func test1() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let items = Observable.just([
            SectionModel(model: "", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, String>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(element)"
                return cell
            })
        
        //绑定单元格数据
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
