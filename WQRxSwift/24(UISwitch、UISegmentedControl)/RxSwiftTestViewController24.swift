//
//  RxSwiftTestViewController24.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/27.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController24: WQBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
        // Do any additional setup after loading the view.
    }

    func test2() {
        self.view.addSubview(segmented)
        view.addSubview(imageView)
        segmented.rx.selectedSegmentIndex.asObservable()
            .subscribe(onNext: {
                print("当前项：\($0)")
            })
            .disposed(by: disposeBag)
        
        //创建一个当前需要显示的图片的可观察序列
        let showImageObservable: Observable<UIImage> =
            segmented.rx.selectedSegmentIndex.asObservable().map {
                let images = ["js.png", "php.png", "react.png"]
                return UIImage(named: images[$0])!
        }

        //把需要显示的图片绑定到 imageView 上
        showImageObservable.bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
    }
    func test1() {
        self.view.addSubview(switch1)
        switch1.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前开关状态：\($0)")
            })
            .disposed(by: disposeBag)
    }
    
    lazy var switch1: UISwitch = {
        let btn: UISwitch = UISwitch(frame: CGRect(x: 100, y: 130, width: 50, height: 40))
        btn.frame = CGRect(x:120, y:130, width:60, height:30)
        return btn
    }()
    
    lazy var segmented: UISegmentedControl = {
        let seg: UISegmentedControl = UISegmentedControl(items: ["first","second","third"])
        seg.layer.position = CGPoint(x: self.view.bounds.size.width/2, y: 130)
        seg.selectedSegmentIndex = 0
        return seg
    }()
    
    lazy var imageView: UIImageView = {
        let btn: UIImageView = UIImageView(frame: CGRect(x: 100, y: 230, width: 100, height: 100))
        return btn
    }()
    
    
}
