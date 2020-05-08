//
//  RxSwiftTestViewController39.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/2.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class RxSwiftTestViewController39: WQBaseViewController {

    
    var refreshButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    //集合视图
    var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
        
    }
    //中途停止数据请求
    func test2() {
        refreshButton = UIBarButtonItem.init(title: "刷新", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        cancelButton = UIBarButtonItem.init(title: "停止", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItems = [cancelButton,refreshButton]
        
        //定义布局方式以及单元格大小
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        
        //创建集合视图
        self.collectionView = UICollectionView(frame: self.view.frame,
                                               collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        
        //创建一个重用的单元格
        self.collectionView.register(MyCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(self.collectionView!)
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest{
                self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
            }
            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, Int>>(
                configureCell: { (dataSource, collectionView, indexPath, element) in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                  for: indexPath) as! MyCollectionViewCell
                    cell.label.text = "\(element)"
                    return cell}
        )
        
        //绑定单元格数据
        randomResult
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    func test1() {
        refreshButton = UIBarButtonItem.init(title: "刷新", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
//        cancelButton = UIBarButtonItem.init(title: "停止", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItems = [refreshButton]
        //定义布局方式以及单元格大小
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        
        //创建集合视图
        self.collectionView = UICollectionView(frame: self.view.frame,
                                               collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        
        //创建一个重用的单元格
        self.collectionView.register(MyCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(self.collectionView!)
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult)
            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, Int>>(
                configureCell: { (dataSource, collectionView, indexPath, element) in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                  for: indexPath) as! MyCollectionViewCell
                    cell.label.text = "\(element)"
                    return cell}
        )
        
        //绑定单元格数据
        randomResult
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
extension RxSwiftTestViewController39 {
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random_uniform(100000))
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(DispatchTimeInterval.seconds(2), scheduler: MainScheduler.instance)
    }
    
}
