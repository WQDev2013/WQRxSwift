//
//  RxSwiftTestViewController36.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/2.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController36: WQBaseViewController {

    var tableView:UITableView!
    var dataSource:RxTableViewSectionedAnimatedDataSource<MySection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test1()
    
        // Do any additional setup after loading the view.
    }
    func test1() {
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
        
        self.dataSource = dataSource
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        //设置代理
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }


}
//tableView代理实现
extension RxSwiftTestViewController36 : UITableViewDelegate {
    //设置单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            guard let _ = dataSource?[indexPath],
                let _ = dataSource?[indexPath.section]
                else {
                    return 0.0
            }
            
            return 60
    }
    
    //返回分区头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int)
        -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.black
            let titleLabel = UILabel()
            titleLabel.text = self.dataSource?[section].header
            titleLabel.textColor = UIColor.white
            titleLabel.sizeToFit()
            titleLabel.center = CGPoint(x: self.view.frame.width/2, y: 20)
            headerView.addSubview(titleLabel)
            return headerView
    }
    
    //返回分区头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int)
        -> CGFloat {
            return 40
    }
    
}

