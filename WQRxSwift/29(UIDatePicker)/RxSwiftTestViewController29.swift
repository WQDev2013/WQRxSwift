//
//  RxSwiftTestViewController29.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/20.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController29: WQBaseViewController {

    
    //开始按钮
    var btnstart:UIButton!
    
    //剩余时间（必须为 60 的整数倍，比如设置为100，值自动变为 60）
    let leftTime = BehaviorRelay(value: TimeInterval(5))
    
    //当前倒计时是否结束
    let countDownStopped = BehaviorRelay(value: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化button
        btnstart =  UIButton(type: .system)
        btnstart.frame = CGRect(x:0, y:300, width:320, height:30);
        btnstart.setTitleColor(UIColor.red, for: .normal)
        btnstart.setTitleColor(UIColor.darkGray, for:.disabled)
        self.view.addSubview(btnstart)
        
        
        //绑定button标题
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable()) {
            leftTimeValue, countDownStoppedValue in
            //根据当前的状态设置按钮的标题
            if countDownStoppedValue {
                return "获取验证码"
            }else{
                return "\(Int(leftTimeValue)) s"
            }
            }.bind(to: btnstart.rx.title())
            .disposed(by: disposeBag)
        
        //按钮点击响应
        btnstart.rx.tap
            .bind { [weak self] in
                self?.startClicked()
            }
            .disposed(by: disposeBag)
        
         countDownStopped.asDriver().drive(btnstart.rx.isEnabled).disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }
    

    //开始倒计时
    func startClicked() {
        //开始倒计时
        self.countDownStopped.accept(false)
        //创建一个计时器
        Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .takeUntil(countDownStopped.asObservable().filter{ $0 }) //倒计时结束时停止计时器
            .subscribe { event in
                //每次剩余时间减1
                self.leftTime.accept(self.leftTime.value - 1)
                // 如果剩余时间小于等于0
                if(self.leftTime.value == 0) {
                    print("倒计时结束！")
                    //结束倒计时
                    self.countDownStopped.accept(true)
                    //重制时间
                    self.leftTime.accept(5)
                }
            }.disposed(by: disposeBag)
    }
    
   

}
