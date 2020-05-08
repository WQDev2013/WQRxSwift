//
//  RxSwiftTestViewController26.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/27.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController26: WQBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        test1()
//        test2()
        test3()
        // Do any additional setup after loading the view.
    }
    func test3() {
        view.addSubview(slider)
        view.addSubview(stepper)
        slider.rx.value
            .map{ Double($0) }  //由于slider值为Float类型，而stepper的stepValue为Double类型，因此需要转换
            .bind(to: stepper.rx.stepValue)
            .disposed(by: disposeBag)
        
    }
    func test2(){
        view.addSubview(stepper)
        stepper.rx.value.asObservable()
            .subscribe(onNext: {
                print("当前值为：\($0)")
            })
            .disposed(by: disposeBag)
    }

    func test1(){
        view.addSubview(slider)
        slider.rx.value.asObservable()
            .subscribe(onNext: {
                print("当前值为：\($0)")
            })
            .disposed(by: disposeBag)
    }

    lazy var slider: UISlider = {
       let sli = UISlider(frame: CGRect(x: 100, y: 150, width: 200, height: 40))
        sli.value = 0.1
        return sli
    }()
    
    lazy var stepper: UIStepper = {
        let stp = UIStepper(frame: CGRect(x: 100, y: 200, width: 200, height: 40))
        return stp
    }()
    
}
