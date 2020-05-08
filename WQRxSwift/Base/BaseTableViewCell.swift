//
//  BaseTableViewCell.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/9/3.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    public lazy var disposeBag = DisposeBag()
    
    ///cell下标
    public var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        ///self.selectionStyle = .none
        
        configureUI()
        addAction()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc dynamic public func configureUI() {}
    @objc dynamic public func addAction() {}

}
