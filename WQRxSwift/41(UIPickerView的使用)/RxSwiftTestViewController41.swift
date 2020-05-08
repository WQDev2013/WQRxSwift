//
//  RxSwiftTestViewController41.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/10.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController41: WQBaseViewController {

    var pickerView:UIPickerView!
    //最简单的pickerView适配器（显示普通文本）
    private let stringPickerAdapter = RxPickerViewStringAdapter<[String]>(
        components: [],
        numberOfComponents: { _,_,_  in 1 },
        numberOfRowsInComponent: { (_, _, items, _) -> Int in
            return items.count},
        titleForRow: { (_, _, items, row, _) -> String? in
            return items[row]}
    )
    
    //最简单的pickerView适配器（显示普通文本）
    private let stringPickerAdapter2 = RxPickerViewStringAdapter<[[String]]>(
        components: [],
        numberOfComponents: { dataSource,pickerView,components  in components.count },
        numberOfRowsInComponent: { (_, _, components, component) -> Int in
            return components[component].count},
        titleForRow: { (_, _, components, row, component) -> String? in
            return components[component][row]}
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
        // Do any additional setup after loading the view.
    }
    //MARK: --基本用法(多列）
    func test2() {
        //创建pickerView
        pickerView = UIPickerView()
        self.view.addSubview(pickerView)
        
        //绑定pickerView数据
        Observable.just([["One", "Two", "Tree"],
                         ["A", "B", "C", "D"]])
            .bind(to: pickerView.rx.items(adapter: stringPickerAdapter2))
            .disposed(by: disposeBag)
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let button = UIButton(frame:CGRect(x:0, y:0, width:100, height:30))
        button.center = self.view.center
        button.backgroundColor = UIColor.blue
        button.setTitle("获取信息",for:.normal)
        //按钮点击响应
        button.rx.tap
            .bind { [weak self] in
                self?.getPickerViewValue()
            }
            .disposed(by: disposeBag)
        self.view.addSubview(button)
    }

    //MARK: --基本用法(单列）
    func test1() {
        //创建pickerView
        pickerView = UIPickerView()
        self.view.addSubview(pickerView)
        
        //绑定pickerView数据
        Observable.just(["One", "Two", "Tree"])
            .bind(to: pickerView.rx.items(adapter: stringPickerAdapter))
            .disposed(by: disposeBag)
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let button = UIButton(frame:CGRect(x:0, y:0, width:100, height:30))
        button.center = self.view.center
        button.backgroundColor = UIColor.blue
        button.setTitle("获取信息",for:.normal)
        //按钮点击响应
        button.rx.tap
            .bind { [weak self] in
                self?.getPickerViewValue()
            }
            .disposed(by: disposeBag)
        self.view.addSubview(button)
    }

    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue(){
        let message = String(pickerView.selectedRow(inComponent: 0))
        let alertController = UIAlertController(title: "被选中的索引为",
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
