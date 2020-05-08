//
//  RxSwiftTestViewController35.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/2.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController35: WQBaseViewController {

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        // Do any additional setup after loading the view.
    }

    func test1() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(FirstTableViewCell.self,
                                 forCellReuseIdentifier: "FirstTableViewCell")
        self.tableView!.register(SecondTableViewCell.self,
                                 forCellReuseIdentifier: "SecondTableViewCell")
        
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let sections = Observable.just([
            MySection(header: "我是第一个分区", items: ["图片数据1","图片数据2","图片数据3"]),
            MySection(header: "我是第二个分区", items: ["开关数据2","开关数据23","开关数据33"])
            ])
        //
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(
            //设置单元格
            configureCell: { dataSource, tableView, indexPath, item in
                if indexPath.section % 2 == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell",
                                                             for: indexPath) as! FirstTableViewCell
                    cell.titleLabel.text = item
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell",
                                                             for: indexPath) as! SecondTableViewCell
                    cell.titleLabel.text = item
                    return cell
                }
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
}




