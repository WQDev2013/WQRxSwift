//
//  ViewController.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/7/19.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
//import RxCocoa
class ViewController: UIViewController {

    public let disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
        
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view).offset( -safeBottomAreaHeight)
        }
        tableView.scrollToRow(at: IndexPath(row: titleArray.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: false)
    }

    private var titleArray: Array<String> {
        var arr = ["Swift - RxSwift的使用详解21（UI控件扩展1：UILabel）"]
        arr.append("Swift - RxSwift的使用详解22（UI控件扩展2：UITextField、UITextView）")
        arr.append("Swift - RxSwift的使用详解23（UI控件扩展3：UIButton、UIBarButtonItem）")
        arr.append("Swift - RxSwift的使用详解24（UI控件扩展4：UISwitch、UISegmentedControl）")
        arr.append("Swift - RxSwift的使用详解25（UI控件扩展5：UIActivityIndicatorView、UIApplication）")
        arr.append("Swift - RxSwift的使用详解26（UI控件扩展6：UISlider、UIStepper）")
        arr.append("Swift - RxSwift的使用详解27（双向绑定：<->）")
        arr.append("Swift - RxSwift的使用详解28（UI控件扩展7：UIGestureRecognizer）")
        arr.append("Swift - RxSwift的使用详解29（UI控件扩展8：UIDatePicker）")
        arr.append("Swift - RxSwift的使用详解30（UITableView的使用1：基本用法）")
        arr.append("Swift - RxSwift的使用详解31（UITableView的使用2：RxDataSources）")
        arr.append("Swift - RxSwift的使用详解32（UITableView的使用3：刷新表格数据）")
        arr.append("Swift - RxSwift的使用详解33（UITableView的使用4：表格数据的搜索过滤）")
        arr.append("Swift - RxSwift的使用详解34（UITableView的使用5：可编辑表格）")
        arr.append("Swift - RxSwift的使用详解35（UITableView的使用6：不同类型的单元格混用）")
        arr.append("Swift - RxSwift的使用详解36（UITableView的使用7：样式修改）")
        arr.append("wift - RxSwift的使用详解37（UICollectionView的使用1：基本用法）")
        arr.append("Swift - RxSwift的使用详解38（UICollectionView的使用2：RxDataSources）")
        arr.append("Swift - RxSwift的使用详解39（UICollectionView的使用3：刷新集合数据）")
        arr.append("Swift - RxSwift的使用详解40（UICollectionView的使用4：样式修改）")
        arr.append("Swift - RxSwift的使用详解41（UIPickerView的使用）")
        arr.append("Swift - RxSwift的使用详解42（[unowned self] 与 [weak self]）")
        arr.append("Swift - RxSwift的使用详解43（URLSession的使用1：请求数据）")
        arr.append("Swift - RxSwift的使用详解44（URLSession的使用2：结果处理、模型转换）")
        arr.append("Swift - RxSwift的使用详解45（结合RxAlamofire使用1：数据请求）")
        arr.append("Swift - RxSwift的使用详解46（结合RxAlamofire使用2：结果处理、模型转换）")
        arr.append("Swift - RxSwift的使用详解47（结合RxAlamofire使用3：文件上传）")
        arr.append("Swift - RxSwift的使用详解48（结合RxAlamofire使用4：文件下载）")
        arr.append("Swift - RxSwift的使用详解49（结合Moya使用1：数据请求）")
        arr.append("Swift - RxSwift的使用详解50（结合Moya使用2：结果处理、模型转换）")
//        arr.append("Swift - RxSwift的使用详解51（MVVM架构演示1：基本介绍、与MVC比较）")
//        arr.append("Swift - RxSwift的使用详解52（MVVM架构演示2：使用Observable样例）")
//        arr.append("Swift - RxSwift的使用详解53（MVVM架构演示3：使用Driver样例）")
//        arr.append("Swift - RxSwift的使用详解54（一个用户注册样例1：基本功能实现）")
//        arr.append("Swift - RxSwift的使用详解55（一个用户注册样例2：显示网络请求活动指示器）")
//        arr.append("Swift - RxSwift的使用详解56（结合MJRefresh使用1：下拉刷新）")
//        arr.append("Swift - RxSwift的使用详解57（结合MJRefresh使用2：上拉加载、以及上下拉组合）")
//        arr.append("Swift - RxSwift的使用详解58（DelegateProxy样例1：获取地理定位信息 ）")
//        arr.append("Swift - RxSwift的使用详解59（DelegateProxy样例2：图片选择功能 ）")
//        arr.append("Swift - RxSwift的使用详解60（DelegateProxy样例3：应用生命周期的状态变化）")
//        arr.append("Swift - RxSwift的使用详解61（sendMessage和methodInvoked的区别）")
//        arr.append("Swift - RxSwift的使用详解62 (订阅UITableViewCell里的按钮点击事件)")
//        arr.append("Swift - RxSwift的使用详解63 (通知NotificationCenter的使用)")
//        arr.append("Swift - RxSwift的使用详解64（键值观察KVO的使用）")
        return arr
    }
    private lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.estimatedRowHeight = 80
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "mainCell")
        table.tableFooterView = UIView()
        return table
    }()
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell")
        cell?.textLabel?.numberOfLines = 0
        cell!.textLabel!.text = self.titleArray[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = RxSwiftTestViewController21()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
            
        case 1:
            let vc = RxSwiftTestViewController22()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        
        case 2:
            let vc = RxSwiftTestViewController23()
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case 3:
            let vc = RxSwiftTestViewController24()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = RxSwiftTestViewController25()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 5:
            let vc = RxSwiftTestViewController26()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 6:
            let vc = RxSwiftTestViewController27()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 7:
            let vc = RxSwiftTestViewController28()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        
        case 8:
            let vc = RxSwiftTestViewController29()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 9:
            let vc = RxSwiftTestViewController30()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 10:
            let vc = RxSwiftTestViewController31()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 11:
            let vc = RxSwiftTestViewController32()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 12:
            let vc = RxSwiftTestViewController33()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 13:
            let vc = RxSwiftTestViewController34()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 14:
            let vc = RxSwiftTestViewController35()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 15:
            let vc = RxSwiftTestViewController36()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 16:
            let vc = RxSwiftTestViewController37()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 17:
            let vc = RxSwiftTestViewController38()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 18:
            let vc = RxSwiftTestViewController39()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 19:
            let vc = RxSwiftTestViewController40()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 20:
            let vc = RxSwiftTestViewController41()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 21:
            let vc = RxSwiftTestViewController42()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 22:
            let vc = RxSwiftTestViewController43()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 23:
            let vc = RxSwiftTestViewController44()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
        
    }
}
