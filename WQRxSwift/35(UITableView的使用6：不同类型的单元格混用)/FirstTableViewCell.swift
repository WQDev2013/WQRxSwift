//
//  FirstTableViewCell.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/3.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class FirstTableViewCell: BaseTableViewCell {

    override func configureUI() {
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(headImageView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-40)
            make.centerY.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH - 150)
            make.height.equalTo(titleLabel)
        }
        headImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-40)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
    }
    
    lazy var titleLabel:UILabel = {
        
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = .black
        return lab
        
    }()
    
    lazy var detailLabel:UILabel = {
        
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = .gray
        lab.textAlignment = .right
        return lab
        
    }()
    
    lazy var headImageView: UIImageView = {
        
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.backgroundColor = .brown
        return view
        
    }()

}
